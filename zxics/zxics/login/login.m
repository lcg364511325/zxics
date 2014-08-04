//
//  login.m
//  zhubao
//
//  Created by moko on 14-6-4.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "login.h"

@interface login ()

@end

@implementation login

@synthesize tipLable;
@synthesize passwordbtn;
@synthesize logoshengyu;

NSInteger i=0;

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
    
    //shengyu    222222   13428706220  111111
    [self.navigationController setNavigationBarHidden:YES];
    
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"_account"]) {
        
        _account.text=(NSString *)[[NSUserDefaults standardUserDefaults]objectForKey:@"_account"];
        _password.text=(NSString *)[[NSUserDefaults standardUserDefaults]objectForKey:@"_password"];
        [passwordbtn setBackgroundImage:[UIImage imageNamed:@"sure"] forState:UIControlStateNormal];
        i=1;
    }else{
        //_account.text=@"13428706220";
        //_password.text=@"111111";
    }
    
    [_submitlogin setTitle:@"" forState:UIControlStateNormal];
    
    //设置此输入框可以隐藏键盘
    _account.delegate=self;
    //[_account setKeyboardType:UIKeyboardTypeDecimalPad];
    _password.delegate=self;
    //[_password setKeyboardType:UIKeyboardTypeDecimalPad];
    
    
}


-(IBAction)loginAction:(id)sender
{
    @try {
        
        UIButton *resultButton = (UIButton *)sender;
        
        if(resultButton.tag==1)return;
        
        tipLable.text=@"正努力登录中...";
        [resultButton setTag:1];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 耗时的操作（异步操作）
            
            NSString * account = _account.text;
            NSString * password = _password.text;
            
//            LoginApi * service = [[LoginApi alloc] init];
            LoginEntity * result = nil;//[service login:account password:password verlity:code];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // 更新界面（处理结果）
                if(result){
                    
                    //判断是否要保存密码
                    if(i==1){
                        [[NSUserDefaults standardUserDefaults]setObject:account forKey:@"_account"];
                        [[NSUserDefaults standardUserDefaults]setObject:password forKey:@"_password"];
                    }else{
                        [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"_account"];
                        [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"_password"];
                    }
                    
//                    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
                    
//                    myDelegate.entityl=result;
//                    
//                    customer * n = [[customer alloc] init];
//                    n.uId = result.uId;
//                    n.userType = result.userType;
//                    n.userName = result.userName;
//                    n.userPass = result.userPass;
//                    n.userDueDate = result.userDueDate;
//                    n.userTrueName = result.userTrueName;
//                    n.sfUrl = result.sfUrl;
//                    n.lxrName = result.lxrName;
//                    n.Sex = result.Sex;
//                    n.bmName = result.bmName;
//                    n.Email = result.Email;
//                    n.Phone = result.Phone;
//                    n.Lxphone = result.Lxphone;
//                    n.Sf = result.Sf;
//                    n.Cs = result.Cs;
//                    n.Address = result.Address;

                    //登录成功，进入系统首页
                    NSLog(@"登录成功，进入系统首页");
                    //Index *sysmenu=[[Index alloc] init];
                    //FVImageSequenceDemoViewController *sysmenu=[[FVImageSequenceDemoViewController alloc] init];
                    //[self.navigationController pushViewController:sysmenu animated:NO];
                    
                    
                }else{
                    //测试中，进入系统首页
                    
                    NSString *info=@"登录失败！";
                    // NSLog(@"登录失败------:%@",info);
                    [[[UIAlertView alloc] initWithTitle:@"信息提示" message:info delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil] show];
                }
                
                //[resultButton setTitle:@"登录" forState:UIControlStateNormal];
                [resultButton setTag:0];
                tipLable.text=@"";
            });
        });
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}

//记住密码
-(IBAction)rememberpassword:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    if (i==0) {
        [btn setBackgroundImage:[UIImage imageNamed:@"sure"] forState:UIControlStateNormal];
        i++;
    }else if (i==1)
    {
        [btn setBackgroundImage:[UIImage imageNamed:@"0001_bg"] forState:UIControlStateNormal];
        i--;
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(done:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer: tapGestureRecognizer];   //只需要点击非文字输入区域就会响应hideKeyBoard
    
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:0.3f];
    float width=self.view.frame.size.width;
    float height=self.view.frame.size.height;
    //CGRect rect=CGRectMake(0.0f,-80*(textField.tag),width,height);//上移80个单位，按实际情况设置
    CGRect rect=CGRectMake(0.0f,-80,width,height);//上移80个单位，按实际情况设置
    self.view.frame=rect;
    [UIView commitAnimations];
    
    return YES;
}

-(void)done:(id)sender
{
    [self.view endEditing:YES];
    
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:0.3f];
    float width=self.view.frame.size.width;
    float height=self.view.frame.size.height;
    CGRect rect=CGRectMake(0.0f,0.0f,width,height);//上移80个单位，按实际情况设置
    if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0)
        //rect=CGRectMake(0.0f,60.0f,width,height);//上移80个单位，按实际情况设置
    self.view.frame=rect;
    [UIView commitAnimations];
    
    UITapGestureRecognizer *tapGestureRecognizer=(UITapGestureRecognizer *)sender;
    [tapGestureRecognizer setEnabled:NO];
}

-(IBAction)goback:(id)sender
{
    fontindex * _fontindex=[[fontindex alloc] init];
    
    [self.navigationController pushViewController:_fontindex animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
