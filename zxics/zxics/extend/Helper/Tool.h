//
//  Tool.h
//  
//
//  Created by wangjun on 12-3-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Tool : NSObject


-(NSString*) UUID ;

+ (void)clearWebViewBackground:(UIWebView *)webView;

+ (NSString *)intervalSinceNow: (NSString *) theDate;

+ (int)getDaysCount:(int)year andMonth:(int)month andDay:(int)day;


+ (NSString *)getAppClientString:(int)appClient;

+ (void)ReleaseWebView:(UIWebView *)webView;


+ (UIColor *)getBackgroundColor;
+ (UIColor *)getCellBackgroundColor;
+ (UIColor *)getseparatorColor;
+ (UIColor *)getPersonInfoViewColor;
+ (UIColor *)getfootColor;

+ (int)getTextViewHeight:(UITextView *)txtView andUIFont:(UIFont *)font andText:(NSString *)txt;

//重复性判断
+ (NSString *)getHTMLString:(NSString *)html;

+ (UIImage *) scale:(UIImage *)sourceImg toSize:(CGSize)size;

+ (CGSize)scaleSize:(CGSize)sourceSize;

+ (NSString *)getOSVersion;

+ (NSDate *)NSStringDateToNSDate:(NSString *)string;

+ (UIColor *)colorFromHexRGB:(NSString *)inColorString;

+ (UIImage *) headbg;

+ (BOOL)isBlankString:(NSString *)string;

//判断是否为整形
+ (BOOL)isPureInt:(NSString *)string;

+(NSString *)getTargetFloderPath;//得到实际文件存储文件夹的路径
+(NSString *)getTempFolderPath;//得到临时文件存储文件夹的路径
+(BOOL)isExistFile:(NSString *)fileName;//检查文件名是否存在

@end
