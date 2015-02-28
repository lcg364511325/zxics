//
//  common.h
//  dzqz_6
//
//  Created by xing on 13-10-26.
//  Copyright (c) 2013年 moko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface Commons : NSObject

-(NSString*) UUID ;

-(BOOL) IsSuccess:(NSString *) result;

+ (NSString *)md5:(NSString *)str;

//
-(NSString *)getGoldtypename:(NSString *)codevalue;

-(NSString *)getGoldtypevalue:(NSString *)name;

-(NSString *)stringtoDate:(NSString *)str;

-(NSString *)stringtoDateforsecond:(NSString *)str;

//webviewHtml内容自适应屏幕宽度
-(NSString *)webViewDidFinishLoad:(UIWebView *)webView webStr:(NSString *)webStr;

@end
