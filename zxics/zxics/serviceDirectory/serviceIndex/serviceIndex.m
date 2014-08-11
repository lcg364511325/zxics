//
//  serviceIndex.m
//  zxics
//
//  Created by johnson on 14-8-11.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "serviceIndex.h"
#import "fontindex.h"
#import "personIndex.h"
#import "download.h"
#import "consultlist.h"
#import "questionslist.h"
#import "surveylist.h"
#import "aboutus.h"
#import "goodslist.h"

@interface serviceIndex ()

@end

@implementation serviceIndex

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

//首页跳转
-(IBAction)frontindex:(id)sender
{
    fontindex * _fontindex=[[fontindex alloc] init];
    
    [self.navigationController pushViewController:_fontindex animated:NO];
}

//个人管理页面跳转
-(IBAction)personindex:(id)sender
{
    personIndex *_personIndex=[[personIndex alloc]init];
    [self.navigationController pushViewController:_personIndex animated:NO];
}

//下载管理页面跳转
-(IBAction)download:(id)sender
{
    download * _download=[[download alloc] init];
    
    [self.navigationController pushViewController:_download animated:NO];
}

//用户咨询页面跳转
-(IBAction)consultlist:(id)sender
{
    consultlist * _consultlist=[[consultlist alloc] init];
    
    [self.navigationController pushViewController:_consultlist animated:NO];
}

//常见问题页面跳转
-(IBAction)questionslist:(id)sender
{
    questionslist * _questionslist=[[questionslist alloc] init];
    
    [self.navigationController pushViewController:_questionslist animated:NO];
}

//在线调查页面跳转
-(IBAction)surveylist:(id)sender
{
    surveylist * _surveylist=[[surveylist alloc] init];
    
    [self.navigationController pushViewController:_surveylist animated:NO];
}

//关于我们页面跳转
-(IBAction)aboutus:(id)sender
{
    aboutus * _aboutus=[[aboutus alloc] init];
    
    [self.navigationController pushViewController:_aboutus animated:NO];
}

//社区商城页面跳转
-(IBAction)goodslist:(id)sender
{
    goodslist * _goodslist=[[goodslist alloc] init];
    
    [self.navigationController pushViewController:_goodslist animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
