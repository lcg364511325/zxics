//
//  lifemdDetail.m
//  zxics
//
//  Created by johnson on 14-8-5.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "lifemdDetail.h"

@interface lifemdDetail ()

@end

@implementation lifemdDetail

@synthesize logoImage;
@synthesize orgLabel;
@synthesize urlLabel;
@synthesize addrLabel;
@synthesize addrdetailLabel;
@synthesize telLabel;
@synthesize businessLabel;
@synthesize contectpeopleLabel;
@synthesize introduceLabel;
@synthesize DetailsLabel;
@synthesize lifeLabel;
@synthesize dateLabel;
@synthesize Project_communityorgs;

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
    
    //加载数据
    [self showdatas];
}

//加载数据
-(void)showdatas
{
    NSDictionary *pc=[Project_communityorgs objectForKey:@"pc"];
    orgLabel.text=[pc objectForKey:@"target"];
    addrLabel.text=[Project_communityorgs objectForKey:@"townName"];
    addrdetailLabel.text=[pc objectForKey:@"addr"];
    telLabel.text=[pc objectForKey:@"phones"];
    businessLabel.text=[pc objectForKey:@"target"];
    contectpeopleLabel.text=[pc objectForKey:@"userName"];
    introduceLabel.text=[pc objectForKey:@"commet"];
    DetailsLabel.text=[pc objectForKey:@"introduce"];
    lifeLabel.text=[Project_communityorgs objectForKey:@"typeName"];
    NSString *time =[NSString stringWithFormat:@"%@",[pc objectForKey:@"createTime"]];
    NSString *aaa=[time substringToIndex:10];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:[aaa intValue]];
    dateLabel.text=[formatter stringFromDate:date];
    urlLabel.text=nil;
    MyLabel *webSite = [[MyLabel alloc] initWithFrame:CGRectMake(urlLabel.frame.origin.x, urlLabel.frame.origin.y, urlLabel.frame.size.width, urlLabel.frame.size.height)];
    [webSite setText:[pc objectForKey:@"openurl"]];
    [self.view addSubview:webSite];
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
