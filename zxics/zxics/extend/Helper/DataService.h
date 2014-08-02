//
//  DataService.h
//  uih
//
//  Created by 陈 星 on 13-6-30.
//  Copyright (c) 2013年 才国. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface DataService : NSObject

//get请求服务器
+(NSMutableDictionary*)GetDataService:(NSString*) URL forPage:(int)Page forPageSize:(int)PageSize;
//get请求服务器
+(NSMutableDictionary*)GetDataService:(NSString*) URL;

//get请求服务器
+(NSString *)GetDataServiceToNsstring:(NSString*) URL;

//post请求服务器
+(NSMutableDictionary*)PostDataService:(NSString*) URL postDatas:(NSString*)str;
//post请求服务器
+(NSMutableDictionary*)PostDataService:(NSString*) URL postDatas:(NSString*)str forPage:(int)Page forPageSize:(int)PageSize;

@end
