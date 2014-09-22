//
//  VicecardDetail.m
//  zxics
//
//  Created by johnson on 14-8-9.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "VicecardDetail.h"
#import "Commons.h"

@interface VicecardDetail ()

@end

@implementation VicecardDetail
@synthesize vcdetail;
@synthesize nameLabel;
@synthesize accountLabel;
@synthesize cardnoLabel;
@synthesize personnoLabel;
@synthesize mobileLabel;
@synthesize addtimeLabel;


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
    [self.UINavigationBar setBackgroundImage:[UIImage imageNamed:@"logo_bg"] forBarMetrics:UIBarMetricsDefault];    
    [self loaddata];
}

-(void)loaddata
{
    nameLabel.text=[NSString stringWithFormat:@"名称：%@",[vcdetail objectForKey:@"name"]];
    accountLabel.text=[NSString stringWithFormat:@"账号：%@",[vcdetail objectForKey:@"account"]];
    cardnoLabel.text=[NSString stringWithFormat:@"卡号：%@",[vcdetail objectForKey:@"cardcode"]];
    personnoLabel.text=[NSString stringWithFormat:@"身份证号：%@",[vcdetail objectForKey:@"codeid"]];
    mobileLabel.text=[NSString stringWithFormat:@"手机号码：%@",[vcdetail objectForKey:@"mobile"]];
    
    Commons *_Commons=[[Commons alloc]init];
    NSString *timestr=[NSString stringWithFormat:@"%@",[vcdetail objectForKey:@"time"]];
    addtimeLabel.text=[NSString stringWithFormat:@"关联时间：%@",[_Commons stringtoDateforsecond:timestr]];
}

-(IBAction)goback:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
