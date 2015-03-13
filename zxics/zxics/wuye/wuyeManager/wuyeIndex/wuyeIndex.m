//
//  wuyeIndex.m
//  zxics
//
//  Created by johnson on 15-3-3.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import "wuyeIndex.h"
#import "AppDelegate.h"
#import "conservationPeople.h"
#import "shopMlist.h"
#import "staffSearchList.h"
#import "repairManagerList.h"
#import "chargeQPersonList.h"

@interface wuyeIndex ()

@end

@implementation wuyeIndex

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

//常住人口页面跳转
-(IBAction)wyConsultManager:(id)sender
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    if (myDelegate.entityl.orgId) {
        conservationPeople * _complainlist=[[conservationPeople alloc] init];
        [self.navigationController pushViewController:_complainlist animated:NO];
    }else
    {
        NSString *rowString =@"你不是物业管理员无法进行此操作！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
}

//人员查询页面跳转
-(IBAction)staffSearchList:(id)sender
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    if (myDelegate.entityl.orgId) {
        staffSearchList * _complainlist=[[staffSearchList alloc] init];
        [self.navigationController pushViewController:_complainlist animated:NO];
    }else
    {
        NSString *rowString =@"你不是物业管理员无法进行此操作！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
}

//招商信息页面跳转
-(IBAction)shopMlist:(id)sender
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    if (myDelegate.entityl.orgId) {
        shopMlist * _complainlist=[[shopMlist alloc] init];
        [self.navigationController pushViewController:_complainlist animated:NO];
    }else
    {
        NSString *rowString =@"你不是物业管理员无法进行此操作！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
}

//报修管理页面跳转
-(IBAction)repairManagerList:(id)sender
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    if (myDelegate.entityl.orgId) {
        repairManagerList * _complainlist=[[repairManagerList alloc] init];
        [self.navigationController pushViewController:_complainlist animated:NO];
    }else
    {
        NSString *rowString =@"你不是物业管理员无法进行此操作！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
}

//收费管理页面跳转
-(IBAction)chargeQPersonList:(id)sender
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    if (myDelegate.entityl.orgId) {
        chargeQPersonList * _complainlist=[[chargeQPersonList alloc] init];
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
