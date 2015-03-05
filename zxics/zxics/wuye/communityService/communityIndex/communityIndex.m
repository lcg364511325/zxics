//
//  communityIndex.m
//  zxics
//
//  Created by johnson on 15-3-3.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import "communityIndex.h"
#import "residentManager.h"
#import "AppDelegate.h"
#import "wuyeInfo.h"
#import "wuyeNotice.h"
#import "wyConsultManager.h"

@interface communityIndex ()

@end

@implementation communityIndex

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
}

//居民审核页面跳转
-(IBAction)residentManager:(id)sender
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    if (myDelegate.entityl.orgId) {
        residentManager * _complainlist=[[residentManager alloc] init];
        _complainlist.type=@"0";
        [self.navigationController pushViewController:_complainlist animated:NO];
    }else
    {
        NSString *rowString =@"你不是物业管理员无法进行此操作！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
}

//物业消息页面跳转
-(IBAction)wuyeInfo:(id)sender
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    if (myDelegate.entityl.orgId) {
        wuyeInfo * _complainlist=[[wuyeInfo alloc] init];
        
        [self.navigationController pushViewController:_complainlist animated:NO];
    }else
    {
        NSString *rowString =@"你不是物业管理员无法进行此操作！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
}

//物业通知页面跳转
-(IBAction)wuyeNotice:(id)sender
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    if (myDelegate.entityl.orgId) {
        wuyeNotice * _complainlist=[[wuyeNotice alloc] init];
        _complainlist.cid=@"80";
        [self.navigationController pushViewController:_complainlist animated:NO];
    }else
    {
        NSString *rowString =@"你不是物业管理员无法进行此操作！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
}

//社区活动页面跳转
-(IBAction)communityActivity:(id)sender
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    if (myDelegate.entityl.orgId) {
        wuyeNotice * _complainlist=[[wuyeNotice alloc] init];
        _complainlist.cid=@"79";
        [self.navigationController pushViewController:_complainlist animated:NO];
    }else
    {
        NSString *rowString =@"你不是物业管理员无法进行此操作！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
}

//咨询管理页面跳转
-(IBAction)wyConsultManager:(id)sender
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    if (myDelegate.entityl.orgId) {
        wyConsultManager * _complainlist=[[wyConsultManager alloc] init];
        _complainlist.type=@"consult";
        [self.navigationController pushViewController:_complainlist animated:NO];
    }else
    {
        NSString *rowString =@"你不是物业管理员无法进行此操作！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
}

//社区活动页面跳转
-(IBAction)wycomplainManager:(id)sender
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    if (myDelegate.entityl.orgId) {
        wyConsultManager * _complainlist=[[wyConsultManager alloc] init];
        _complainlist.type=@"complaint";
        [self.navigationController pushViewController:_complainlist animated:NO];
    }else
    {
        NSString *rowString =@"你不是物业管理员无法进行此操作！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
