//
//  updatepassword.m
//  zxics
//
//  Created by johnson on 14-9-1.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "updatepassword.h"
#import "AppDelegate.h"
#import "DataService.h"

@interface updatepassword ()

@end

@implementation updatepassword

@synthesize oldpassword;
@synthesize newpassword;
@synthesize checkpassword;

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

-(IBAction)goback:(id)sender
{
    personInfo *_personInfo=[[personInfo alloc]init];
    [self.navigationController pushViewController:_personInfo animated:NO];
}

//更新个人信息
-(IBAction)changepensoninfo:(id)sender
{
    if (![oldpassword.text isEqualToString:@""] && ![newpassword.text isEqualToString:@""] && ![checkpassword.text isEqualToString:@""]) {
        if ([newpassword.text isEqualToString:checkpassword.text]) {
            AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
            NSMutableDictionary * state = [NSMutableDictionary dictionaryWithCapacity:5];
            state=[DataService PostDataService:[NSString stringWithFormat:@"%@api/changeMyInfo",domainser] postDatas:[NSString stringWithFormat:@"userid=%@&account=%@&oldPwd=%@&pwd=%@",myDelegate.entityl.userid,myDelegate.entityl.account,oldpassword.text,newpassword.text]];
            NSString *rowString =[state objectForKey:@"info"];
            UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alter show];
            NSString *status=[NSString stringWithFormat:@"%@",[state objectForKey:@"status"]];
            if ([status isEqualToString:@"1"]) {
                personInfo *_personInfo=[[personInfo alloc]init];
                [self.navigationController pushViewController:_personInfo animated:NO];
            }
        }else{
            NSString *rowString =@"两次输入的密码不相同，请重新确认修改密码!";
            UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alter show];
        }
    }else{
        NSString *rowString =@"内容不能为空!";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
