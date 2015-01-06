//
//  DBManager.h
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "LookForContentModel.h"

@interface DBManager : NSObject

/****/
/**
 *	@brief	db single object method
 *
 *	@return	FMDB Object
 */

//create db class, single instance. It involved FMDatabaseQuene
+ (DBManager*)sharedInstance;

//create database
- (void)buildDB:(NSString*)dbFilePath;

#pragma mark -user
- (void)insertUser:(QJUser *)user;
- (QJUser *)selectUser:(NSString *)loginName;

@end
