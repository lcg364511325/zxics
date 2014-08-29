//
//  updateinfo.m
//  zxics
//
//  Created by johnson on 14-8-7.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "updateinfo.h"
#import "AppDelegate.h"
#import "DataService.h"
#import "personInfo.h"

@interface updateinfo ()

@end

@implementation updateinfo

@synthesize btntag;
@synthesize updatetext;
@synthesize value;

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
    [self setnavbar];//修改navbar标题
    
    //初始化
    updatetext.text=value;
}

-(IBAction)goback:(id)sender
{
    personInfo *_personInfo=[[personInfo alloc]init];
    [self.navigationController pushViewController:_personInfo animated:NO];
}

//修改navbar标题
-(void)setnavbar
{
    NSInteger selecttype= [btntag intValue];
    if (selecttype==0) {
        self.UINavigationItem.title=@"修改身份证号";
        valuename=@"codeid";
    }else if (selecttype==1)
    {
        self.UINavigationItem.title=@"修改卡号";
        valuename=@"cardcode";
    }else if (selecttype==3)
    {
        self.UINavigationItem.title=@"修改昵称";
        valuename=@"name";
    }else if (selecttype==6)
    {
        self.UINavigationItem.title=@"修改手机号码";
        valuename=@"mobile";
    }else if (selecttype==7)
    {
        self.UINavigationItem.title=@"修改电子邮箱";
        valuename=@"email";
    }else if (selecttype==8)
    {
        self.UINavigationItem.title=@"修改QQ";
        valuename=@"qq";
    }else if (selecttype==10)
    {
        self.UINavigationItem.title=@"修改联系地址";
        valuename=@"addr";
    }
}

//更新个人信息
-(IBAction)changepensoninfo:(id)sender
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    NSMutableDictionary * state = [NSMutableDictionary dictionaryWithCapacity:5];
    NSString * updatavalue=updatetext.text;
    if (updatavalue!=nil && ![updatavalue isEqualToString:@""]) {
        state=[DataService PostDataService:[NSString stringWithFormat:@"%@api/changeMyInfo",domainser] postDatas:[NSString stringWithFormat:@"userid=%@&account=%@&%@=%@",myDelegate.entityl.userid,myDelegate.entityl.account,valuename,updatetext.text]];
    }
    NSString *rowString =[state objectForKey:@"info"];
    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alter show];
    NSString *status=[NSString stringWithFormat:@"%@",[state objectForKey:@"status"]];
    if ([status isEqualToString:@"1"]) {
        personInfo *_personInfo=[[personInfo alloc]init];
        [self.navigationController pushViewController:_personInfo animated:NO];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
