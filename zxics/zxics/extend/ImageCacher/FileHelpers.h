//
//  FileHelpers.h
//  AAPinChe
//
//  Created by Reese on 13-1-17.
//  Copyright (c) 2013年 Himalayas Technology&Science Company CO.,LTD-重庆喜玛拉雅科技有限公司. All rights reserved.
//  这是一个纯C函数，用于获取应用沙盒文件路径
//

#import <Foundation/Foundation.h>


NSString *pathInDocumentDirectory(NSString *fileName);
NSString *pathInCacheDirectory(NSString *fileName);
NSString *pathForURL(NSURL *aURL);
BOOL hasCachedImage(NSURL *aURL);
NSString *hashCodeForURL(NSURL *aURL);
//判断是否已经缓存过这个URL，如果有则删除掉
BOOL deleteCachedImage(NSURL *aURL);