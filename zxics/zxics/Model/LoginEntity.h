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
@property (nonatomic, retain) NSString * resultcount;//购物车数量
@property (nonatomic, retain) NSString * info;
@property (nonatomic, retain) NSString * webcode;

@property (nonatomic, retain) NSString * uId;
@property (nonatomic, retain) NSString * userType;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSString * userPass;
@property (nonatomic, retain) NSString * userDueDate;
@property (nonatomic, retain) NSString * userTrueName;
@property (nonatomic, retain) NSString * sfUrl;
@property (nonatomic, retain) NSString * lxrName;
@property (nonatomic, retain) NSString * Sex;
@property (nonatomic, retain) NSString * bmName;
@property (nonatomic, retain) NSString * Email;
@property (nonatomic, retain) NSString * Phone;
@property (nonatomic, retain) NSString * Lxphone;
@property (nonatomic, retain) NSString * Sf;
@property (nonatomic, retain) NSString * Cs;
@property (nonatomic, retain) NSString * Address;

@end
