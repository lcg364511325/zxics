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

@end
