//
//  login.h
//  zhubao
//
//  Created by moko on 14-6-4.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginEntity.h"
#import "AppDelegate.h"
#import "Tool.h"
#import "fontindex.h"

@interface login : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;


@property (weak, nonatomic) IBOutlet UITextField *account;

@property (weak, nonatomic) IBOutlet UITextField *password;

@property (weak, nonatomic) IBOutlet UIButton *submitlogin;
@property (weak, nonatomic) IBOutlet UILabel *tipLable;
@property (weak, nonatomic) IBOutlet UIButton *passwordbtn;
@property (weak, nonatomic) IBOutlet UIImageView *logoshengyu;

- (IBAction)loginAction:(id)sender;

@end
