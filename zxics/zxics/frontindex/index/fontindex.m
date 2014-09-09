//
//  fontindex.m
//  zxics
//
//  Created by johnson on 14-8-4.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "fontindex.h"
#import "download.h"
#import "goodslist.h"
#import "DataService.h"
#import "succourlist.h"

@interface fontindex ()

@end

@implementation fontindex

@synthesize functionscroll;
@synthesize functionpage;
@synthesize loginbutton;

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
    
    
    //设置scrollview属性
    _secondview.frame=CGRectMake(functionscroll.frame.size.width,               functionscroll.contentOffset.y, 320, 284);
    [functionscroll addSubview:_secondview];
    functionscroll.contentSize=CGSizeMake(functionscroll.frame.size.width*2, functionscroll.frame.size.height);
    functionscroll.showsHorizontalScrollIndicator=NO;//不显示水平滑动线
    functionscroll.showsVerticalScrollIndicator=NO;//不显示垂直滑动线
    functionscroll.pagingEnabled=YES;//scrollView不会停在页面之间，即只会显示第一页或者第二页，不会各一半显示
    
    //设置pagecontroller
    functionpage.numberOfPages=2;//设置页数为2
    functionpage.currentPage=0;//初始页码为 0
    functionpage.userInteractionEnabled=NO;//pagecontroller不响应点击操作
    
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    if (myDelegate.entityl) {
        loginbutton.titleLabel.text=@"退出";
    }else{
        loginbutton.titleLabel.text=@"登录";
    }
    
    NSLog(@"已经不是第一次启动了");
    NSString * firstin=[[NSUserDefaults standardUserDefaults] objectForKey:@"firstin"];
    if([firstin isEqualToString:@"0"])
    {
        [self findVersion];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if(scrollView==functionscroll){
        
        CGPoint offset = scrollView.contentOffset;
        functionpage.currentPage = offset.x / (self.view.bounds.size.width); //计算当前的页码
        [functionscroll setContentOffset:CGPointMake(functionscroll.frame.size.width * (functionpage.currentPage),               functionscroll.contentOffset.y) animated:YES]; //设置scrollview的显示为当前滑动到的页面
    }
}

//特殊人群关怀页面跳转
-(IBAction)specialpeople:(id)sender
{
    SpecialPeople * _SpecialPeople=[[SpecialPeople alloc] init];
    
    [self.navigationController pushViewController:_SpecialPeople animated:NO];
}

//生活管家页面跳转
-(IBAction)lifemd:(id)sender
{
    lifemd * _lifemd=[[lifemd alloc] init];
    
    [self.navigationController pushViewController:_lifemd animated:NO];
}

//投诉管理页面跳转
-(IBAction)complainlist:(id)sender
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    if (myDelegate.entityl) {
        complainlist * _complainlist=[[complainlist alloc] init];
        
        [self.navigationController pushViewController:_complainlist animated:NO];
    }else
    {
        NSString *rowString =@"请先登陆！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
}

//社区活动，物业通知页面跳转
-(IBAction)cplist:(id)sender
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    if (myDelegate.entityl.communityid) {
        UIButton *btn=(UIButton *)sender;
        NSInteger btntag=btn.tag;
        cplist * _cplist=[[cplist alloc] init];
        _cplist.btntag=[NSString stringWithFormat:@"%d",btntag];
        [self.navigationController pushViewController:_cplist animated:NO];
    }else
    {
        NSString *rowString =@"请先加入社区！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
}

//个人管理首页
-(IBAction)personindex:(id)sender
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    if (myDelegate.entityl) {
        personIndex * _personIndex=[[personIndex alloc] init];
        
        [self.navigationController pushViewController:_personIndex animated:NO];
    }else{
        NSString *rowString =@"请先登陆！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
}

//物业报修
-(IBAction)repairlist:(id)sender
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    if (myDelegate.entityl.communityid) {
        repairlist * _repairlist=[[repairlist alloc] init];
        
        [self.navigationController pushViewController:_repairlist animated:NO];
    }else
    {
        NSString *rowString =@"请先加入社区！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
}

//招商信息页面跳转
-(IBAction)Merchantslist:(id)sender
{
    Merchantslist * _Merchantslist=[[Merchantslist alloc] init];
    
    [self.navigationController pushViewController:_Merchantslist animated:NO];
}

//在线调查页面跳转
-(IBAction)surveylist:(id)sender
{
    surveylist * _surveylist=[[surveylist alloc] init];
    UIButton *btn=(UIButton *)sender;
    NSInteger btntag=btn.tag;
    _surveylist.btntag=[NSString stringWithFormat:@"%d",btntag];
    [self.navigationController pushViewController:_surveylist animated:NO];
}

//下载管理页面跳转
-(IBAction)download:(id)sender
{
    download * _download=[[download alloc] init];
    
    [self.navigationController pushViewController:_download animated:NO];
}

//用户咨询页面跳转
-(IBAction)consultlist:(id)sender
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    if (myDelegate.entityl) {
        consultlist * _consultlist=[[consultlist alloc] init];
        
        [self.navigationController pushViewController:_consultlist animated:NO];
    }else{
        NSString *rowString =@"请先登陆！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
}

//救助申请页面跳转
-(IBAction)succourlist:(id)sender
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    if (myDelegate.entityl) {
        succourlist * _succourlist=[[succourlist alloc] init];
        
        [self.navigationController pushViewController:_succourlist animated:NO];
    }else{
        NSString *rowString =@"请先登陆！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
}

//常见问题页面跳转
-(IBAction)questionslist:(id)sender
{
    questionslist * _questionslist=[[questionslist alloc] init];
    
    [self.navigationController pushViewController:_questionslist animated:NO];
}

//物业出租出售页面跳转
-(IBAction)rentorshelllist:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    NSInteger btntag=btn.tag;
    rentorshelllist * _rentorshelllist=[[rentorshelllist alloc] init];
    _rentorshelllist.btntag=[NSString stringWithFormat:@"%d",btntag];
    [self.navigationController pushViewController:_rentorshelllist animated:NO];
}

//求租求购页面跳转
-(IBAction)prowantedlist:(id)sender
{
    prowantedlist * _prowantedlist=[[prowantedlist alloc] init];
    
    [self.navigationController pushViewController:_prowantedlist animated:NO];
}

//服务指南页面跳转
-(IBAction)serviceIndex:(id)sender
{
    serviceIndex * _serviceIndex=[[serviceIndex alloc] init];
    
    [self.navigationController pushViewController:_serviceIndex animated:NO];
}

//社区商城页面跳转
-(IBAction)goodslist:(id)sender
{
    goodslist * _goodslist=[[goodslist alloc] init];
    
    [self.navigationController pushViewController:_goodslist animated:NO];
}

//登录页面跳转
-(IBAction)login:(id)sender
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    if (myDelegate.entityl) {
        myDelegate.entityl=nil;
        NSString *rowString =@"退出成功";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        [self reloadInputViews];
    }else
    {
        login * _login=[[login alloc] init];
        
        [self.navigationController pushViewController:_login animated:NO];
    }
}

//检查是否有版本更新
-(void)findVersion{
    
    @try {
        NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
        NSString *key = [NSString stringWithFormat:@"dataVersion"];
        NSString *dataVersion = [settings objectForKey:key];
        if(!dataVersion || [dataVersion isEqualToString:@""])dataVersion=@"0";
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 耗时的操作（异步操作）
            //            Commons *common=[[Commons alloc] init];
            NSDictionary * dictResult =nil;
            //
            //            NSString * code = @"DS02";
            //            NSString * params =[NSString stringWithFormat:@"{\"app\":\"ios\",\"dataVersion\":\"%@\"}",dataVersion];
            //            WebService * service = [[WebService alloc] init];
            //            service.businessCode = code;
            //            service.params = params;
            //            NSString * result1 =[service GetData1];
            //
            //            //NSLog(@"result1------:%@",result1);
            //
            //            NSString * result = [common GetWebServicegetResult1:result1];//Shawn 2013.12.27 作为.net webservice解析方式
            //            //NSLog(@"result------:%@",result);
            //
            //            //将json字符串转为字典类型
            //            dictResult = [result objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
            //
            dictResult=[DataService PostDataService:[NSString stringWithFormat:@"%@api/updateFindApi",domainser] postDatas:@"OS=IOS"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // 更新界面（处理结果）
                //　　{"appResult":"1","appVersion":"1.1.1001","appInfo":"","appUrl":"http://192.168.1.121/sdk.apk", "dataVersion":"2.1.1001","dataResult":"1","dataInfo":"数据更新说明", "dataUrl":"http://192.168.1.121/sdk.txt" , "dataImportant":"0"}
                @try {
                    //更新升级应用程序
                    NSString *status=[NSString stringWithFormat:@"%@",[dictResult objectForKey:@"status"]];
                    if([status isEqualToString:@"1"]){
                        NSString * version=[dictResult objectForKey:@"version"];
                        NSString *appCurVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
                        
                        if(![version isEqualToString:appCurVersion]){
                            NSString * appInfo=[dictResult objectForKey:@"info"];
                            NSString * info=[NSString stringWithFormat:@"当前最新版本：%@ \n 更新内容：%@",version,appInfo];
                            appurl=[dictResult objectForKey:@"url"];
                            
                            isupdate=NO;
                            isExit=NO;//升级提示时，设置不判断退出
                            [[[UIAlertView alloc] initWithTitle:@"系统有更新，是否升级？" message:info delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
                            
                        }
                        
                    }else{
                        //[[[UIAlertView alloc] initWithTitle:@"信息提示" message:@"没有更新版本，此版本已经是最新。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
                        
                    }
                }
                @catch (NSException *exception) {
                    
                }
            });
        });
        
    }
    @catch (NSException *exception) {
        
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"firstin"];
    if (buttonIndex == 0) {
        if(isupdate){
            isupdate=NO;
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appurl]];
        }
        
    }else if (buttonIndex == 1) {
        if(isExit)
            exit(0);
        else
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appurl]];
        //exit(0);
        //        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_appUrl]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
