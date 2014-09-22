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

//下载管理页面跳转
-(IBAction)download:(id)sender
{
    download * _download=[[download alloc] init];
    
    [self.navigationController pushViewController:_download animated:NO];
}

//用户咨询页面跳转
-(IBAction)consultlist:(id)sender
{
    
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    if (myDelegate.entityl) {
        consultlist * _consultlist=[[consultlist alloc] init];
        
        [self.navigationController pushViewController:_consultlist animated:NO];
    }else{
        NSString *rowString =@"请先登陆！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
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
    _surveylist.btntag=@"0";
    [self.navigationController pushViewController:_surveylist animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
