//
//  showAD.m
//  zxics
//
//  Created by johnson on 14-9-9.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "showAD.h"
#import "fontindex.h"
#import "VisaIntroduce.h"
#import "DataService.h"
#import "ImageCacher.h"

@interface showAD ()

@end

@implementation showAD

@synthesize adimg;

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
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"firstapp"]){
        
        VisaIntroduce *sysmenu=[[VisaIntroduce alloc] init];
        [self.navigationController pushViewController:sysmenu animated:NO];
        
    }else
    {
        NSString *url=[self loaddata];
        if ([url isEqualToString:@""]) {
            [adimg setImage:[UIImage imageNamed:@"guidancemr"]];
        }else
        {
            NSURL *imgUrl=[NSURL URLWithString:url];
            if (hasCachedImage(imgUrl)) {
                [adimg setImage:[UIImage imageWithContentsOfFile:pathForURL(imgUrl)]];
            }else{
                NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:imgUrl,@"url",adimg,@"imageView",nil];
                [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
            }
        }
        [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(turntofrontindex) userInfo:nil repeats:NO];
    }
    
}


//获得广告图片地址
-(NSString *)loaddata
{
    NSMutableDictionary * picinfo = [NSMutableDictionary dictionaryWithCapacity:5];
    picinfo=[DataService PostDataService:[NSString stringWithFormat:@"%@api/updateAdvertisingApi",domainser] postDatas:nil];
    NSString *url=[NSString stringWithFormat:@"%@",[picinfo objectForKey:@"url"]];
    return url;
}


//首页跳转
-(void)turntofrontindex
{
    fontindex *_fontindex=[[fontindex alloc]init];
    [self.navigationController pushViewController:_fontindex animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
