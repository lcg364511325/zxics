//
//  membercenter.m
//  zxics
//
//  Created by johnson on 14-8-8.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "membercenter.h"

@interface membercenter ()

@end

@implementation membercenter

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

//我的评价页面跳转
-(IBAction)myappraise:(id)sender
{
    myappraise *_myappraise=[[myappraise alloc]init];
    [self.navigationController pushViewController:_myappraise animated:NO];
}

//我的订单页面跳转
-(IBAction)myorder:(id)sender
{
    myorder *_myorder=[[myorder alloc]init];
    [self.navigationController pushViewController:_myorder animated:NO];
}

//我的购物车页面跳转
-(IBAction)shoppingcart:(id)sender
{
    shoppingcart *_shoppingcart=[[shoppingcart alloc]init];
    [self.navigationController pushViewController:_shoppingcart animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
