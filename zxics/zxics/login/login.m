//
//  login.m
//  zhubao
//
//  Created by moko on 14-6-4.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "login.h"
#import "DataService.h"
#import "LoginEntity.h"

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
    
    [self.UINavigationBar setBarTintColor:[UIColor colorWithRed:7.0/255.0 green:3.0/255.0 blue:164.0/255.0 alpha:1]];//设置bar背景颜色
    
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"_account"]) {
        
        _account.text=(NSString *)[[NSUserDefaults standardUserDefaults]objectForKey:@"_account"];
        _password.text=(NSString *)[[NSUserDefaults standardUserDefaults]objectForKey:@"_password"];
        [passwordbtn setBackgroundImage:[UIImage imageNamed:@"sure"] forState:UIControlStateNormal];
        i=1;
    }else{
        //_account.text=@"13428706220";
        //_password.text=@"111111";
    }
    
    [_submitlogin setTitle:@"登录" forState:UIControlStateNormal];
    
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
        
        NSString *rowString =@"正在登录。。。。";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alter show];
        [resultButton setTag:1];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 耗时的操作（异步操作）
            
            NSString * account = _account.text;
            NSString * password = _password.text;
            
             NSMutableDictionary * login = [NSMutableDictionary dictionaryWithCapacity:5];
            AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
            login=[DataService PostDataService:[NSString stringWithFormat:@"%@api/login",myDelegate.url] postDatas:[NSString stringWithFormat:@"account=%@&pwd=%@",account,password]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // 更新界面（处理结果）
                if(login.count>2){
                    
                    //判断是否要保存密码
                    if(i==1){
                        [[NSUserDefaults standardUserDefaults]setObject:account forKey:@"_account"];
                        [[NSUserDefaults standardUserDefaults]setObject:password forKey:@"_password"];
                    }else{
                        [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"_account"];
                        [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"_password"];
                    }
                    LoginEntity *loginuser=[[LoginEntity alloc]init];
                    loginuser.pay_points=[login objectForKey:@"pay_points"];
                    loginuser.account=[login objectForKey:@"account"];
                    loginuser.userid=[login objectForKey:@"userid"];
                    loginuser.name=[login objectForKey:@"name"];
                    loginuser.headimg=[login objectForKey:@"headimg"];
                    loginuser.communityName=[login objectForKey:@"communityName"];
                    loginuser.userMoney=[login objectForKey:@"userMoney"];
                    loginuser.communityid=[login objectForKey:@"communityid"];
                    myDelegate.entityl=loginuser;
                    
                    

                    //登录成功，进入系统首页
                    NSLog(@"登录成功，进入系统首页");
                    [alter dismissWithClickedButtonIndex:0 animated:YES];
                    NSString *rowString =@"登录成功";
                    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alter show];
                    
                    
                }else{
                    //测试中，进入系统首页
                    [alter dismissWithClickedButtonIndex:0 animated:YES];
                    NSString *info=@"用户名或密码不正确";
                    // NSLog(@"登录失败------:%@",info);
                    [[[UIAlertView alloc] initWithTitle:@"登录失败" message:info delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil] show];
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

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    if (myDelegate.entityl) {
        [self goback:nil];
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
