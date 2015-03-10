//
//  UIViewPassValueDelegate.h
//  dzqz_6
//
//  Created by xing on 13-10-26.
//  Copyright (c) 2013年 moko. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UIViewPassValueDelegate <NSObject>

- (void)passValue:(NSString *)value key:(NSString *)key tag:(NSInteger)tag;
- (void)passDictionaryValue:(NSDictionary *)value key:(NSDictionary *)key tag:(NSInteger)tag;
@end
