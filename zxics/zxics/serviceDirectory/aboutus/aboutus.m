//
//  aboutus.m
//  zxics
//
//  Created by johnson on 14-8-11.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "aboutus.h"
#import "Commons.h"
#import "DataService.h"

@interface aboutus ()

@end

@implementation aboutus

@synthesize versonnoLabel;

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
    NSString *appCurVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    versonnoLabel.text=appCurVersion;
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
//            dictResult=[DataService PostDataService:[NSString stringWithFormat:@"%@api/updateFindApi",domainser] postDatas:nil];
            
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
