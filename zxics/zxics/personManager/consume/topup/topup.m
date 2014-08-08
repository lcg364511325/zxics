//
//  topup.m
//  zxics
//
//  Created by johnson on 14-8-7.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "topup.h"

@interface topup ()

@end

@implementation topup

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.UINavigationBar setBarTintColor:[UIColor colorWithRed:7.0/255.0 green:3.0/255.0 blue:164.0/255.0 alpha:1]];//设置bar背景颜色
}

-(IBAction)goback:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

//账号充值页面跳转
-(IBAction)topupmoney:(id)sender
{
    topupmoney *_topupmoney=[[topupmoney alloc]init];
    [self.navigationController pushViewController:_topupmoney animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
