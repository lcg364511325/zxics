//
//  personIndex.m
//  zxics
//
//  Created by johnson on 14-8-6.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "personIndex.h"
#import "goodslist.h"
#import "personfootprintlist.h"
#import "myhome.h"
#import "decorateView.h"
#import "myelectric.h"

@interface personIndex ()

@end

@implementation personIndex

@synthesize UINavigationBar;
@synthesize UINavigationItem;

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
    [self.navigationController setNavigationBarHidden:YES];
    [self.UINavigationBar setBackgroundImage:[UIImage imageNamed:@"logo_bg"] forBarMetrics:UIBarMetricsDefault];
    self.UINavigationItem.title=@"个人管理";
    
}

//首页页面跳转
-(IBAction)fontindex:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
//    decorateView *_decorateView=[[decorateView alloc]init];
//    [self.navigationController pushViewController:_decorateView animated:NO ];
}

//个人信息
-(IBAction)personinfo:(id)sender
{
    personInfo * _personInfo=[[personInfo alloc] init];
    
    [self.navigationController pushViewController:_personInfo animated:NO];
}


//个人日志
-(IBAction)personlog:(id)sender
{
    personLog * _personLog=[[personLog alloc] init];
    
    [self.navigationController pushViewController:_personLog animated:NO];
}

//个人足迹
-(IBAction)personfootprintlist:(id)sender
{
    personfootprintlist * _personfootprintlist=[[personfootprintlist alloc] init];
    
    [self.navigationController pushViewController:_personfootprintlist animated:NO];
}

//欠费（缴费）查询页面跳转
-(IBAction)arrearagelist:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    NSInteger btntag=btn.tag;
    arrearagecheck * _arrearagecheck=[[arrearagecheck alloc] init];
    _arrearagecheck.btntag=[NSString stringWithFormat:@"%d",btntag];
    [self.navigationController pushViewController:_arrearagecheck animated:NO];
}

//消费查询，停车记录页面跳转
-(IBAction)consumelist:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    NSInteger btntag=btn.tag;
    consumelist * _consumelist=[[consumelist alloc] init];
    _consumelist.btntag=[NSString stringWithFormat:@"%d",btntag];
    [self.navigationController pushViewController:_consumelist animated:NO];
}

//余额查询
-(IBAction)balancelist:(id)sender
{
    balancelist * _balancelist=[[balancelist alloc] init];
    
    [self.navigationController pushViewController:_balancelist animated:NO];
}

//我的家
-(IBAction)myhome:(id)sender
{
    myhome * _myhome=[[myhome alloc] init];
    
    [self.navigationController pushViewController:_myhome animated:NO];
}

//会员中心页面跳转
-(IBAction)membercenter:(id)sender
{
    membercenter * _membercenter=[[membercenter alloc] init];
    
    [self.navigationController pushViewController:_membercenter animated:NO];
}

//加入社区页面跳转
-(IBAction)communitylist:(id)sender
{
    communitylist * _communitylist=[[communitylist alloc] init];
    
    [self.navigationController pushViewController:_communitylist animated:NO];
}

//切换社区页面跳转
-(IBAction)changecom:(id)sender
{
    changecom * _changecom=[[changecom alloc] init];
    
    [self.navigationController pushViewController:_changecom animated:NO];
}

//我的副卡页面跳转
-(IBAction)ViewController:(id)sender
{
    Vicecardlist * _Vicecardlist=[[Vicecardlist alloc] init];
    
    [self.navigationController pushViewController:_Vicecardlist animated:NO];
}

//我的发电
-(IBAction)myelectric:(id)sender
{
    myelectric * _myelectric=[[myelectric alloc] init];
    
    [self.navigationController pushViewController:_myelectric animated:NO];
}

//退出登录
-(IBAction)logout:(id)sender
{
    NSString *rowString =@"是否退出登录？";
    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alter show];
}

//alertview响应事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
        if (buttonIndex==1) {
            AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
            myDelegate.entityl=nil;
            
            login * _login=[[login alloc] init];
            [self.navigationController pushViewController:_login animated:NO];
        }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
