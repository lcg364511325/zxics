//
//  personLogDetail.m
//  zxics
//
//  Created by johnson on 14-8-7.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "personLogDetail.h"
#import "AppDelegate.h"
#import "Commons.h"

@interface personLogDetail ()

@end

@implementation personLogDetail

@synthesize UINavigationBar;
@synthesize psd;
@synthesize detailLabel;
@synthesize typeLabel;
@synthesize personLabel;
@synthesize typeDetailLabel;
@synthesize accountLabel;
@synthesize ipLabel;
@synthesize datelabel;

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
    detailLabel.text=[psd objectForKey:@"datail"];
    
    NSString *type=[NSString stringWithFormat:@"%@",[psd objectForKey:@"type"]];
    if ([type isEqualToString:@"1"]) {
        typeLabel.text=@"前台";
    }else{
        typeLabel.text=@"后台";
    }
    
    NSString *usertype=[NSString stringWithFormat:@"%@",[psd objectForKey:@"usertype"]];
    if ([usertype isEqualToString:@"0"]) {
        personLabel.text=@"管理员";
    }else{
        personLabel.text=@"客户";
    }
    
    NSString *actiontype=[NSString stringWithFormat:@"%@",[psd objectForKey:@"actiontype"]];
    if ([actiontype isEqualToString:@"0"]) {
        typeDetailLabel.text=@"新增";
    }else if ([actiontype isEqualToString:@"1"])
    {
        typeDetailLabel.text=@"修改";
    }else if ([actiontype isEqualToString:@"2"])
    {
        typeDetailLabel.text=@"删除";
    }else if ([actiontype isEqualToString:@"4"])
    {
        typeDetailLabel.text=@"登录 ";
    }
    
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    accountLabel.text=myDelegate.entityl.account;
    
    
    id ip=[psd objectForKey:@"ip"];
    if (ip!=[NSNull null]) {
        ipLabel.text=[psd objectForKey:@"ip"];
    }
    
    Commons *_Commons=[[Commons alloc]init];
    NSString *timestr=[NSString stringWithFormat:@"%@",[psd objectForKey:@"create_time"]];
    datelabel.text=[_Commons stringtoDate:timestr];
    
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
