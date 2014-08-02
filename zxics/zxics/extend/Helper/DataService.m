//
//  DataService.m
//  uih
//
//  Created by 陈 星 on 13-6-30.
//  Copyright (c) 2013年 才国. All rights reserved.
//

#import "DataService.h"

@implementation DataService

/////////////////////////////请求服务器的封装方法//////////////////////////////////////


+(NSMutableDictionary*)GetDataService:(NSString*) URL forPage:(int)Page forPageSize:(int)PageSize
{
    NSError *error;
    
    if([URL rangeOfString:@"?"].length > 0)
        URL = [NSString stringWithFormat:@"%@&page=%d&pagesize=%d",URL,Page,PageSize];
    else
        URL = [NSString stringWithFormat:@"%@?page=%d&pagesize=%d",URL,Page,PageSize];
    
    NSLog(@"%@",URL);
    
    //加载一个NSURL对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSMutableDictionary * dict =nil;
    if (response) {
        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
         dict =[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
    }else{
        
        dict =[[NSMutableDictionary alloc] initWithObjectsAndKeys:0,@"result",@"亲，请求服务器出错！",@"info", nil];
    }

    return dict;
}


+(NSMutableDictionary*)GetDataService:(NSString*) URL
{
    NSError *error;

    NSLog(@"%@",URL);
    
    //加载一个NSURL对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSMutableDictionary * dict =nil;
    if (response) {
        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
        dict =[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
    }else{
        
        dict =[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"0",@"result",@"亲，请求服务器出错！",@"info", nil];
    }

    
    return dict;
}

+(NSString *)GetDataServiceToNsstring:(NSString*) URL
{
    NSLog(@"%@",URL);
    
    //加载一个NSURL对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];

    if (response) {
        NSString *str = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
        return str;
    }else{
        
        return @"亲，请求服务器出错！";
    }
    
}

//post请求服务器
+(NSMutableDictionary*)PostDataService:(NSString*) URL postDatas:(NSString*)str
{
    NSError *error;
    
    NSLog(@"%@",URL);

    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:URL] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];

    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET

    //NSString *str = @"type=focus-c";//设置参数
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];

    //NSString *str1 = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    //NSLog(@"%@",str1);

    //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
    //NSMutableDictionary * dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];

    NSMutableDictionary * dict =nil;
    if (response) {
        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
        dict =[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
    }else{
        
        dict =[[NSMutableDictionary alloc] initWithObjectsAndKeys:0,@"result",@"亲，请求服务器出错！",@"info", nil];
    }

    return dict;
}


+(NSMutableDictionary*)PostDataService:(NSString*) URL postDatas:(NSString*)str forPage:(int)Page forPageSize:(int)PageSize
{
    NSError *error;
    
    if([URL rangeOfString:@"?"].length > 0)
        URL = [NSString stringWithFormat:@"%@&page=%d&pagesize=%d",URL,Page,PageSize];
    else
        URL = [NSString stringWithFormat:@"%@?page=%d&pagesize=%d",URL,Page,PageSize];
    
    NSLog(@"%@",URL);
    
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:URL] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    
    //NSString *str = @"type=focus-c";//设置参数
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    //NSString *str1 = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    //NSLog(@"%@",str1);
    
    //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
    //NSMutableDictionary * dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
    
    NSMutableDictionary * dict =nil;
    if (response) {
        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
        dict =[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
    }else{
        
        dict =[[NSMutableDictionary alloc] initWithObjectsAndKeys:0,@"result",@"亲，请求服务器出错！",@"info", nil];
    }
    
    return dict;
}

@end
