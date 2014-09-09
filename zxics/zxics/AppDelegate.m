//
//  AppDelegate.m
//  zxics
//
//  Created by moko on 14-8-1.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "AppDelegate.h"
#import "personInfo.h"
#import "AlixPayResult.h"
#import "DataVerifier.h"

@implementation AppDelegate
@synthesize alter;
@synthesize entityl;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [application setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    
    //初始化url
    //url=@"http://www.jiahao123.com/";
    
    //初始化
    //self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //首次打开APP 创建缓存文件夹
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"firstLaunch"]==nil) {
        [[NSFileManager defaultManager] createDirectoryAtPath:pathInCacheDirectory(@"com.xmly") withIntermediateDirectories:YES attributes:nil error:nil];
        [[NSUserDefaults standardUserDefaults]setObject:[NSNumber numberWithBool:YES] forKey:@"firstLaunch"];
    }
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstapp"];
    }
    else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstapp"];
    }
    
    
    
    //初始化实体
    //self.entityl=[[LoginEntity alloc] init];
    
    //设置ios不锁屏
    //[[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
    //系统新安装未初始化
    fontindex * lo = [[fontindex alloc] init];
    //Index *lo = [[Index alloc] initWithNibName:@"Index" bundle:nil] ;
    
    //设置初始化值，判断是否第一次进入首页
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"firstin"];
    
    UINavigationController * loginNav = [[UINavigationController alloc] initWithRootViewController:lo];
    self.window.rootViewController = loginNav;
    
    [self.window makeKeyAndVisible];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//上传图片到服务器
-(BOOL*)submitOrder:(NSString *)gid  uploadpath:(NSMutableArray *)uploadpath URL:(NSString *)URL  postid:(NSString *)postid{
    
    @try {
        
        alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"提交信息中。。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        
        
        URL = [NSString stringWithFormat:@"%@%@",domainser,URL];
        
        
        ASIFormDataRequest *uploadImageRequest= [ ASIFormDataRequest requestWithURL : [NSURL URLWithString:[URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ]];
        
        [uploadImageRequest setStringEncoding:NSUTF8StringEncoding];
        [uploadImageRequest setRequestMethod:@"POST"];
        [uploadImageRequest setPostValue:gid forKey:postid];
        [uploadImageRequest setPostFormat:ASIMultipartFormDataPostFormat];
        
        int i=0;
        for (NSString *eImage in uploadpath)
        {
            i++;
            NSData *imageData = [NSData dataWithContentsOfFile:eImage];
            //NSData *imageData=UIImageJPEGRepresentation(eImage,100);
            //NSString *photoName=[NSString stringWithFormat:@"file%d.jpg",i];
            NSString * photoName=[eImage lastPathComponent];//从路径中获得完整的文件名（带后缀）
            photoName=[NSString stringWithFormat:@"%d%@",i,photoName];
            //NSString *photoDescribe=@" ";
            //NSLog(@"photoName=%@",photoName);
            //NSLog(@"photoDescribe=%@",photoDescribe);
            NSLog(@"图片名字+++++%@",photoName);
            NSLog(@"图片大小+++++%d",[imageData length]/1024);
            //照片content
            //[uploadImageRequest setPostValue:photoDescribe forKey:@"photoContent"];
            //[uploadImageRequest addData:imageData withFileName:photoName andContentType:@"image/jpeg" forKey:@"photoContent"];
            //[requset addData:imageData withFileName:[NSString stringWithFormat:@"%@_%d.png",self.TF_tel.text,ranNum] andContentType:@"image/png" forKey:[NSString stringWithFormat:@"uploadImage%d",index]];
            
            [uploadImageRequest addData:imageData withFileName:photoName andContentType:@"image/jpeg" forKey:[NSString stringWithFormat:@"uploadImage%d",i]];
        }
        
        [uploadImageRequest setDelegate : self ];
        [uploadImageRequest setDidFinishSelector : @selector (responseComplete:)];
        [uploadImageRequest setDidFailSelector : @selector (responseFailed:)];
        [uploadImageRequest startAsynchronous];
        
        
    }@catch (NSException *exception) {
        [alter dismissWithClickedButtonIndex:0 animated:YES];
    }
    @finally {
        
    }
    return nil;
    
}

//数据提交上传完成
-(void)responseComplete:(ASIHTTPRequest*)request
{
    @try {
        [alter dismissWithClickedButtonIndex:0 animated:YES];
        
        //Use when fetching text data
        NSString *responseString = [request responseString];
        
        //Use when fetching binary data
        NSData *jsonData = [request responseData];
        
        NSError *error = nil;
        if ([jsonData length] > 0 && error == nil){
            error = nil;
            
            id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
            
            if (jsonObject != nil && error == nil){
                if ([jsonObject isKindOfClass:[NSDictionary class]])
                {
                    NSDictionary *d = (NSDictionary *)jsonObject;
                    NSString * status=[NSString stringWithFormat:@"%@",[d objectForKey:@"status"]];
                    NSString * info=[NSString stringWithFormat:@"%@",[d objectForKey:@"info"]];
                    NSString * url=[NSString stringWithFormat:@"%@",[d objectForKey:@"url"]];
                    if ([status isEqualToString:@"0"]) {
                        //提交失败
                        [[[UIAlertView alloc] initWithTitle:@"信息提示" message:@"提交失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
                        
                        return;
                    }else if([status isEqualToString:@"1"]){
                        [[[UIAlertView alloc] initWithTitle:@"信息提示" message:@"提交成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
                        if ([info isEqualToString:@"更新头像成功"]) {
                            entityl.headimg=url;
                            [_mydelegate performSelector:@selector(loaddata)];
                        }
                        
                        return;
                    }
                    
                }else if ([jsonObject isKindOfClass:[NSArray class]]){
                    
                }
                else {
                    NSLog(@"无法解析的数据结构.");
                }
                
                
            }
            else if (error != nil){
                NSLog(@"%@",error);
            }
        }
        else if ([jsonData length] == 0 &&error == nil){
            NSLog(@"空的数据集.");
        }
        else if (error != nil){
            NSLog(@"发生致命错误：%@", error);
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    [[[UIAlertView alloc] initWithTitle:@"信息提示" message:@"提交失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
    
}

//提交上传数据失败
-(void)responseFailed:(ASIHTTPRequest *)request
{
    [alter dismissWithClickedButtonIndex:0 animated:YES];
    //NSError *error = [request error];
    
    [[[UIAlertView alloc] initWithTitle:@"信息提示" message:@"提交失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
    
}

//独立客户端回调函数
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
	
	[self parse:url application:application];
	return YES;
}

- (void)parse:(NSURL *)url application:(UIApplication *)application {
    
    //结果处理
    AlixPayResult* result = [self handleOpenURL:url];
    
	if (result)
    {
		
		if (result.statusCode == 9000)
        {
			/*
			 *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
			 */
            
            //交易成功
            //            NSString* key = @"签约帐户后获取到的支付宝公钥";
            //			id<DataVerifier> verifier;
            //            verifier = CreateRSADataVerifier(key);
            //
            //			if ([verifier verifyString:result.resultString withSign:result.signString])
            //            {
            //                //验证签名成功，交易结果无篡改
            //			}
            
        }
        else
        {
            //交易失败
        }
    }
    else
    {
        //失败
    }
    
}

- (AlixPayResult *)resultFromURL:(NSURL *)url {
	NSString * query = [[url query] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
#if ! __has_feature(objc_arc)
    return [[[AlixPayResult alloc] initWithString:query] autorelease];
#else
	return [[AlixPayResult alloc] initWithString:query];
#endif
}

- (AlixPayResult *)handleOpenURL:(NSURL *)url {
	AlixPayResult * result = nil;
	
	if (url != nil && [[url host] compare:@"safepay"] == 0) {
		result = [self resultFromURL:url];
	}
    
	return result;
}

@end
