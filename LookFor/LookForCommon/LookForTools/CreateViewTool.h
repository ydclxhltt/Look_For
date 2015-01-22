//
//  CreateViewTool.h
//  SmallPig
//
//  Created by clei on 14/11/5.
//  Copyright (c) 2014年 chenlei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonTool.h"  
#import "UIImageView+WebCache.h"

@interface CreateViewTool : NSObject

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
 *  设置阴影
 *
 *  @pram view          view视图
 *  @pram shadowColor   阴影颜色
 *  @pram offset        阴影区域
 *  @pram opacity       阴影模糊度
 */
+ (void)setViewShadow:(UIView *)view withShadowColor:(UIColor *)shadowColor shadowOffset:(CGSize)offset shadowOpacity:(float)opacity;

/*
 *  创建Label
 *
 *  @pram   frame   Label尺寸
 *  @pram   color   文字颜色
 *  @pram   text    文字内容
 *  @pram   font    文字字体
 *
 *  @return UILabel对象
 */
+ (UILabel *)createLabelWithFrame:(CGRect)frame  textString:(NSString *)text textColor:(UIColor *)color textFont:(UIFont *)font;

/*
 *  创建UIImageView 获取网络图片
 *
 *  @pram   frame       Label尺寸
 *  @pram   image       默认图片
 *  @pram   urlString   图片地址
 *  @pram   showProcess 是否显示进度条
 *
 *  @return UIImageView对象
 */
+ (UIImageView *)createImageViewWithFrame:(CGRect)frame placeholderImage:(UIImage *)image imageUrl:(NSString *)urlString isShowProcess:(BOOL)showProcess;

/*
 *  创建普通的UIImageView
 *
 *  @pram   frame   Label尺寸
 *  @pram   image   默认图片
 *
 *  @return UIImageView对象
 */
+ (UIImageView *)createImageViewWithFrame:(CGRect)frame placeholderImage:(UIImage *)image;

/*
 *  圆形头像UIImageView视图
 *
 *  @pram   frame     Label尺寸
 *  @pram   image     默认图片
 *  @pram   urlString 图片地址
 *  @pram   color     layer颜色
 *
 *  @return UIImageView对象
 */
+ (UIImageView *)createRoundImageViewWithFrame:(CGRect)frame placeholderImage:(UIImage *)image  borderColor:(UIColor*)color  imageUrl:(NSString *)urlString;

/*
 *  创建UITextField
 *
 *  @pram   frame   Label尺寸
 *  @pram   color   文字颜色
 *  @pram   font    文字大小
 *  @pram   text    默认文字
 *
 *  @return UITextField对象
 */
+ (UITextField *)createTextFieldWithFrame:(CGRect)frame textColor:(UIColor *)color textFont:(UIFont *)font placeholderText:(NSString *)text;

/*
 *  以图片创建按钮
 *
 *  @pram   imageName  图片名称(如：back_up back_down 传back)
 *  @pram   selName    方法名
 *  @pram   delegate   按钮响应方法类
 *
 *  @return UIButton对象
 */
+ (UIButton *)createButtonWithImage:(NSString *)imageName selectorName:(NSString *)selName tagDelegate:(id)delegate;

/*
 *  以frame创建按钮
 *
 *  @pram   frame      button尺寸
 *  @pram   imageName  图片名称
 *  @pram   selName    方法名
 *  @pram   delegate   按钮响应方法类
 *
 *  @return UIButton对象
 */

+ (UIButton *)createButtonWithFrame:(CGRect)frame buttonImage:(NSString *)imageName selectorName:(NSString *)selName tagDelegate:(id)delegate;

/*
 *  以frame创建按钮 用颜色设置图片
 *
 *  @pram   nor_Title       button正常状态title
 *  @pram   color           button正常状态titlecolor
 *  @pram   frame           button尺寸
 *  @pram   normalColor     默认颜色
 *  @pram   selectedColor   选中颜色
 *  @pram   selName         方法名
 *  @pram   delegate        按钮响应方法类
 *
 *  @return UIButton对象
 */
+ (UIButton *)createButtonWithFrame:(CGRect)frame buttonTitle:(NSString *)nor_Title  titleColor:(UIColor *)color normalBackgroundColor:(UIColor *)normalColor highlightedBackgroundColor:(UIColor *)selectedColor selectorName:(NSString *)selName tagDelegate:(id)delegate;
@end
