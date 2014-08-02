//
//  AppDelegate.h
//  zxics
//
//  Created by moko on 14-8-1.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FileHelpers.h"
#import "LoginEntity.h"
#import "login.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(retain , nonatomic) LoginEntity * entityl;//保存登录的用户信息


@end
