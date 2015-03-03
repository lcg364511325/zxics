//
//  LoginEntity.h
//  uih
//
//  Created by xing on 13-7-14.
//  Copyright (c) 2013年 才国. All rights reserved.
//

#import <Foundation/Foundation.h>

//验证登录实体类
@interface LoginEntity : NSObject
@property (nonatomic, retain) NSString * pay_points;//消费积分
@property (nonatomic, retain) NSString * account;//用户账号
@property (nonatomic, retain) NSString * userid;//用户id
@property (nonatomic, retain) NSString * name;//用户名
@property (nonatomic, retain) NSString * headimg;//用户头像
@property (nonatomic, retain) NSString * communityName;//社区名称
@property (nonatomic, retain) NSString * userMoney;//用户现有现金
@property (nonatomic, retain) NSString * communityid;//社区id
@property (nonatomic, retain) NSString * orgId;//组织id
@property (nonatomic, retain) NSString * orgName;//组织名称

@end
