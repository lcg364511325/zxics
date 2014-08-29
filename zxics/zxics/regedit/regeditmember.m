//
//  regeditmember.m
//  zxics
//
//  Created by johnson on 14-8-21.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "regeditmember.h"
#import "fontindex.h"
#import "DataService.h"

@interface regeditmember ()

@end

@implementation regeditmember

@synthesize accountText;
@synthesize nameText;
@synthesize passwordText;
@synthesize checkpswText;

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


//提交注册
-(IBAction)regedit:(id)sender
{
    NSMutableDictionary * state = [NSMutableDictionary dictionaryWithCapacity:5];
    NSString *account=accountText.text;
    NSString *password=passwordText.text;
    NSString *check=checkpswText.text;
    if (account!=nil && ![account isEqualToString:@""]) {
        if ([password isEqualToString:check]) {
            state=[DataService PostDataService:[NSString stringWithFormat:@"%@api/regist",domainser] postDatas:[NSString stringWithFormat:@"account=%@&pwd=%@&name=%@",accountText.text,password,nameText.text]];
            
            NSString *rowString =[state objectForKey:@"info"];
            UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alter show];
        }else
        {
            NSString *rowString =@"两次输入密码不相同";
            UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alter show];
        }
    }else
    {
        NSString *rowString =@"账号不能为空";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
    
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
