//
//  DBManager.m
//

#import <Foundation/Foundation.h>
#import "DBManager.h"
#import "FMDatabaseQueue.h"

#define  ELDBVersion @"100"
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)


//#define debugMethod(...) NSLog((@"In %s,%s [Line %d] "), __PRETTY_FUNCTION__,__FILE__,__LINE__,##__VA_ARGS__)
static FMDatabaseQueue *dbQueue = NULL;
static FMDatabase *shareDataBase = nil;
static DBManager *shareDBManager = nil;
@implementation DBManager


+ (DBManager*)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareDBManager = [[DBManager alloc] init];
    });
    
    return shareDBManager;
}


- (void) buildDB:(NSString*)dbFilePath {
    if (dbFilePath) {
        /*
         Request local database version and comparation
         if database version is null, initial database
         if any update exist, call update function
         */
        if (![[NSFileManager defaultManager] fileExistsAtPath:dbFilePath]) {
            if (dbQueue == NULL) {
                dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbFilePath];
            }
            
            //create table
            [self createAllTable];
            //call function to update table
            for (NSInteger i = 101; i <= [ELDBVersion integerValue]; i++) {
                char actionName[128];
                sprintf(actionName, "dbUpdate%ld", (long)i);
                SEL action = sel_registerName(actionName);
                SuppressPerformSelectorLeakWarning(
                                                   [self performSelector:(SEL)action];
                                                   );
            }
            
        } else {
            if (dbQueue == NULL) {
                dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbFilePath];
            }
            
            NSInteger curDBVersion = [[self getDBVersion] integerValue];
            //update table
            if (curDBVersion < [ELDBVersion integerValue] && curDBVersion != 0) {
                for (NSInteger i = curDBVersion + 1; i <= [ELDBVersion integerValue]; i++) {
                    char actionName[128];
                    sprintf(actionName, "dbUpdate%ld", (long)i);
                    SEL action = sel_registerName(actionName);
                    SuppressPerformSelectorLeakWarning(
                                                       [self performSelector:(SEL)action];
                                                       );
                }
            }
        }
        //update database version
        [self alterDBVersionTable];
    }
}

#pragma mark - updateDB
- (void)dbUpdate101 {
    
}

#pragma mark -private

- (void)checkErr:(FMDatabase*)fmDatabase {
    if ([fmDatabase hadError]) {
        NSLog(@"DB Err %d: %@", [fmDatabase lastErrorCode], [fmDatabase lastErrorMessage]);
    }
}

- (NSString*) checkNSString:(NSString*)contentString {
    return [contentString length] == 0 ? @"" : contentString;
}


#pragma mark - createTable

- (void)createAllTable {
    [self createDBVersionTable];
    [self createUserTable];
}

- (void)createDBVersionTable {
    [dbQueue inDatabase:^(FMDatabase *aDB) {
        [aDB executeUpdate:@"CREATE TABLE IF NOT EXISTS BMSDB_version (Version varchar(20), Name varchar(10))"];
    }];
}


#pragma mark -DBVersionTable

- (void)alterDBVersionTable
{
    NSString* version = [self getDBVersion];
    
    [dbQueue inDatabase:^(FMDatabase *aDB) {
        if (version && version.length > 0) {
            [aDB executeUpdate:@"UPDATE BMSDB_version SET Version=? WHERE Name = 'version'", ELDBVersion];
        } else {
            [aDB executeUpdate:@"INSERT INTO BMSDB_version(Name, Version) VALUES(?,?)" , @"version", ELDBVersion];
        }
        [self checkErr:aDB];
    }];
}


//Request database version
- (NSString*)getDBVersion {
    __block NSString* version = nil;
    
    [dbQueue inDatabase:^(FMDatabase *aDB) {
        FMResultSet *rs = [aDB executeQuery:@"SELECT Version FROM BMSDB_version WHERE Name = 'version'"];
        while ([rs next]) {
            version = [rs stringForColumnIndex:0];
        }
        [rs close];
        [self checkErr:aDB];
    }];
    
    return (version && [version length]) ? version : NULL;
}


#pragma mark -CreateTable
- (void)createUserTable {
    [dbQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"CREATE TABLE IF NOT EXISTS QJUser_table (userId int(64) NOT NULL, loginName varchar(128) NOT NULL,passWord varchar(256),nickName varchar(128),email varchar(128),headImageUrl varchar(512),phone varchar(64),sex int(1),level int(1),R1 varchar(64),R2 varchar(64),PRIMARY KEY (userId,loginName) ON CONFLICT REPLACE)"];
    }];
}


#pragma mark -private


- (void)insertuserWithDB:(FMDatabase *)db withUser:(QJUser *)user {
    [db executeUpdate:@"INSERT OR REPLACE INTO QJUser_table (userId, loginName ,passWord ,nickName ,email ,headImageUrl ,phone ,sex ,level) VALUES(? , ?, ?, ? ,? ,? , ?, ?, ?)",
     [NSNumber numberWithLongLong:user.userId],
     [self checkNSString:user.loginName],
     [self checkNSString:user.passWord],
     [self checkNSString:user.nickName],
     [self checkNSString:user.email],
     [self checkNSString:user.headImageUrl],
     [self checkNSString:user.phone],
     [NSNumber numberWithLongLong:user.sex],
     [NSNumber numberWithLongLong:user.level]];
    
    [self checkErr:db];
}

- (QJUser *)selectUser:(FMDatabase*)db withUserId:(NSInteger)userId {
    QJUser *user = [[QJUser alloc] init];
    FMResultSet *resut = [db executeQuery:@"SELECT * FROM QJUser_table where userId = ?",[NSNumber numberWithInteger:userId]];
    if ([resut next]) {
        user.userId = [resut longForColumnIndex:0];
        user.loginName = [resut stringForColumnIndex:1];
        user.passWord = [resut stringForColumnIndex:2];
        user.nickName = [resut stringForColumnIndex:3];
        user.email = [resut stringForColumnIndex:4];
        user.headImageUrl = [resut stringForColumnIndex:5];
        user.phone = [resut stringForColumnIndex:6];
        user.sex = [resut intForColumnIndex:7];
        user.level = [resut intForColumnIndex:8];
    }
    
    [resut close];
    [self checkErr:db];
    return user;
}


#pragma mark -user
- (void)insertUser:(QJUser *)user {
    [dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [self insertuserWithDB:db withUser:user];
    }];
}

- (QJUser *)selectUser:(NSString *)loginName {
    __block QJUser *user = [QJUser shareInstance];
    
    [dbQueue inTransaction:^(FMDatabase *aDB, BOOL *rollback) {
        FMResultSet *resut = [aDB executeQuery:@"SELECT * FROM QJUser_table where loginName = ?",loginName];
        if ([resut next]) {
            user.userId = [resut longForColumnIndex:0];
            user.loginName = [resut stringForColumnIndex:1];
            user.passWord = [resut stringForColumnIndex:2];
            user.nickName = [resut stringForColumnIndex:3];
            user.email = [resut stringForColumnIndex:4];
            user.headImageUrl = [resut stringForColumnIndex:5];
            user.phone = [resut stringForColumnIndex:6];
            user.sex = [resut intForColumnIndex:7];
            user.level = [resut intForColumnIndex:8];
        }
        
        [resut close];
        [self checkErr:aDB];
    }];
    return user;
}



@end
