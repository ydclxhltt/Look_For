//
//  CommonTool.h
//  SmallPig
//
//  Created by clei on 14/11/6.
//  Copyright (c) 2014年 chenlei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonTool : NSObject

/*
 * 判断手机号或邮箱是否合法
 *
 * @pram string 手机号或者邮箱字符串
 *
 * @return 返回格式是否合法
 */
+ (BOOL)isEmailOrPhoneNumber:(NSString*)string;

/*
 * 判断身份证是否合法
 *
 * @pram identityCard 身份证号码字符串
 *
 * @return 返回格式是否合法
 */
+ (BOOL) validateIdentityCard: (NSString *)identityCard;

/*
 * 颜色生成图片
 *
 * @pram color 颜色
 *
 * @return 返回图片对象
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/*
 * 根据UILabel计算高度和设置Label高度和行数
 *
 * @pram textLabel  Label
 * @pram font       字体
 *
 * @return 返回字符串高度
 */
+ (float)labelHeightWithTextLabel:(UILabel *)textLabel textFont:(UIFont *)font;

/*
 * 根据字符串计算高度文字高度
 *
 * @pram text       字符串
 * @pram font       字体
 * @pram width      字符串显示区域宽度
 *
 * @return 返回字符串高度
 */
+ (float)labelHeightWithText:(NSString *)text textFont:(UIFont*)font labelWidth:(float)width;

/*
 *  设置view图层相关属性
 *
 *  @pram view   view视图
 *  @pram color  图层颜色
 *  @pram width  图层边缘宽度
 */
+ (void)setViewLayer:(UIView *)view withLayerColor:(UIColor *)color bordWidth:(float)width;

/*
 *  设置特层圆角属性
 *
 *  @pram view   view视图
 *  @pram radius 圆角大小
 */
+ (void)clipView:(UIView *)view withCornerRadius:(float)radius;


/*
 *  MD5
 *
 *  @pram   str    需要加密的字符串
 *
 *  @return        加密后的字符串
 */
+ (NSString *)md5:(NSString *)str;

/*
 *  创建提示alert
 *
 *  @pram   message 提示文字
 */
+ (void)addAlertTipWithMessage:(NSString *)message;

/*
 *  時間轉換為字符串
 *
 *  @pram   date   時間
 *
 *  @return        時間字符串
 */
+ (NSString *)getStringFromDate:(NSDate *)date formatterString:(NSString *)fmtString;

/*
 *  URL编码
 *
 *  @pram   input  需要编码的字符串
 *
 *  @return        编码后的字符串
 */
+ (NSString *)encodeToPercentEscapeString: (NSString *) input;

@end
