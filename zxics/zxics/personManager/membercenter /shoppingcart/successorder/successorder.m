//
//  successorder.m
//  zxics
//
//  Created by johnson on 14-8-27.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "successorder.h"
#import "myorderDetail.h"
#import "yikatong.h"
#import "membercenter.h"

@interface successorder ()

@end

@implementation successorder

@synthesize so;
@synthesize ordernoLabel;
@synthesize phoneLabel;
@synthesize sendway;
@synthesize price;
@synthesize payButton;
@synthesize checkorderButton;

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
    
    ordernoLabel.text=[NSString stringWithFormat:@"%@",[so objectForKey:@"info"]];
    phoneLabel.text=[NSString stringWithFormat:@"(提示：虚拟商品订单在成功支付后，取货/消费凭证信息将通过短信形式发送到手机号：%@，请注意查收，谢谢)",[so objectForKey:@"mobile"]];
    
    if ([sendway isEqualToString:@"5"]) {
        payButton.hidden=YES;
        checkorderButton.frame=CGRectMake(160, checkorderButton.frame.origin.y, checkorderButton.frame.size.width, checkorderButton.frame.size.height);
    }
}

-(IBAction)goback:(id)sender
{
    membercenter *_membercenter=[[membercenter alloc]init];
    [self.navigationController pushViewController:_membercenter animated:NO];
}

//查看订单
-(IBAction)checkorder:(id)sender
{
    myorderDetail *_myorderDetail=[[myorderDetail alloc]init];
    _myorderDetail.orderid=[NSString stringWithFormat:@"%@",[so objectForKey:@"oId"]];
    _myorderDetail.orderstate=@"0";
    [self.navigationController pushViewController:_myorderDetail animated:NO];
}

-(IBAction)pay:(id)sender
{
    if ([sendway isEqualToString:@"4"]) {
        yikatong *_yikatong=[[yikatong alloc]init];
        _yikatong.price=price;
        _yikatong.orderid=[NSString stringWithFormat:@"%@",[so objectForKey:@"oId"]];
        [self.navigationController pushViewController:_yikatong animated:NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
