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
#import "regeditmember.h"
#import "decorateView.h"

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
    
    [self.UINavigationBar setBackgroundImage:[UIImage imageNamed:@"logo_bg"] forBarMetrics:UIBarMetricsDefault];    
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"_account"]) {
        
        _account.text=(NSString *)[[NSUserDefaults standardUserDefaults]objectForKey:@"_account"];
        _password.text=(NSString *)[[NSUserDefaults standardUserDefaults]objectForKey:@"_password"];
        [passwordbtn setBackgroundImage:[UIImage imageNamed:@"sure"] forState:UIControlStateNormal];
        i=1;
    }else{
        //_account.text=@"jm";
        //_password.text=@"123456";
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
            login=[DataService PostDataService:[NSString stringWithFormat:@"%@api/login",domainser] postDatas:[NSString stringWithFormat:@"account=%@&pwd=%@",account,password]];
            
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
                    NSString *orgid=[NSString stringWithFormat:@"%@",[login objectForKey:@"orgId"]];
                    if (orgid!=nil && ![orgid isEqualToString:@""]) {
                        loginuser.account=[login objectForKey:@"uAccount"];
                        loginuser.userid=[login objectForKey:@"uId"];
                        loginuser.name=[login objectForKey:@"uName"];
                        loginuser.communityid=[login objectForKey:@"communityIds"];
                        loginuser.orgId=[login objectForKey:@"orgId"];
                        loginuser.orgName=[login objectForKey:@"orgName"];
                    }else{
                        loginuser.pay_points=[login objectForKey:@"pay_points"];
                        loginuser.account=[login objectForKey:@"account"];
                        loginuser.userid=[login objectForKey:@"userid"];
                        loginuser.name=[login objectForKey:@"name"];
                        loginuser.headimg=[login objectForKey:@"headimg"];
                        loginuser.communityName=[login objectForKey:@"communityName"];
                        loginuser.userMoney=[login objectForKey:@"userMoney"];
                        loginuser.communityid=[login objectForKey:@"communityid"];
                        loginuser.orgId=[login objectForKey:@"orgId"];
                    }
                    myDelegate.entityl=loginuser;
                    
                    

                    //登录成功，进入系统首页
                    NSLog(@"登录成功，进入系统首页");
                    [alter dismissWithClickedButtonIndex:0 animated:YES];
                    decorateView *_decorateView=[[decorateView alloc]init];
                    [self.navigationController pushViewController:_decorateView animated:NO];
                    
                    
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

//注册
-(IBAction)regeditmember:(id)sender
{
    regeditmember *_regeditmember=[[regeditmember alloc]init];
    [self.navigationController pushViewController:_regeditmember animated:NO];
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
    decorateView *_decorateView=[[decorateView alloc]init];
    [self.navigationController pushViewController:_decorateView animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
