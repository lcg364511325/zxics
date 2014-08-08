//
//  updateinfo.m
//  zxics
//
//  Created by johnson on 14-8-7.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "updateinfo.h"

@interface updateinfo ()

@end

@implementation updateinfo

@synthesize btntag;

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
    }else if (selecttype==1)
    {
        self.UINavigationItem.title=@"修改卡号";
    }else if (selecttype==3)
    {
        self.UINavigationItem.title=@"修改昵称";
    }else if (selecttype==6)
    {
        self.UINavigationItem.title=@"修改手机号码";
    }else if (selecttype==7)
    {
        self.UINavigationItem.title=@"修改电子邮箱";
    }else if (selecttype==8)
    {
        self.UINavigationItem.title=@"修改QQ";
    }else if (selecttype==10)
    {
        self.UINavigationItem.title=@"修改联系地址";
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
