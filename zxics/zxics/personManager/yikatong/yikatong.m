//
//  yikatong.m
//  zxics
//
//  Created by johnson on 14-8-27.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "yikatong.h"
#import "DataService.h"
#import "membercenter.h"

@interface yikatong ()

@end

@implementation yikatong

@synthesize orderid;
@synthesize price;
@synthesize ordernoLabel;
@synthesize priceLabel;
@synthesize pwdLabel;
@synthesize accountLabel;
@synthesize cardidText;

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
    ordernoLabel.text=orderid;
    priceLabel.text=[NSString stringWithFormat:@"%@元",price];
}

-(IBAction)goback:(id)sender
{
    membercenter *_membercenter=[[membercenter alloc]init];
    [self.navigationController pushViewController:_membercenter animated:NO];
}

//确定支付
-(IBAction)pay:(id)sender
{
    NSMutableDictionary * state = [NSMutableDictionary dictionaryWithCapacity:5];
    state=[DataService PostDataService:[NSString stringWithFormat:@"%@api/MoblieCardWsreduce",domainser] postDatas:[NSString stringWithFormat:@"amtc=%@&cardId=%@&account=%@&pwd=%@&oId=%@",price,cardidText.text,accountLabel.text,pwdLabel.text,orderid]];
    NSString *rowString =[NSString stringWithFormat:@"%@",[state objectForKey:@"info"]];
    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alter show];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
