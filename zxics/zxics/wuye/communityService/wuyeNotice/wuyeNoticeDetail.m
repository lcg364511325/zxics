//
//  wuyeNoticeDetail.m
//  zxics
//
//  Created by johnson on 15-3-5.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import "wuyeNoticeDetail.h"
#import "DataService.h"
#import "Commons.h"

@interface wuyeNoticeDetail ()

@end

@implementation wuyeNoticeDetail

@synthesize detailWeb;
@synthesize titleLabel;
@synthesize cid;
@synthesize type;

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
    [self.UINavigationBar setBackgroundImage:[UIImage imageNamed:@"logo_bg"] forBarMetrics:UIBarMetricsDefault];
    
    if ([type isEqualToString:@"79"]) {
        self.UINavigationItem.title=@"社区活动信息";
    }
    
    [self loaddata];
}

-(void)loaddata
{
    Commons *_Commons=[[Commons alloc]init];
    NSMutableDictionary * pw = [NSMutableDictionary dictionaryWithCapacity:5];
    pw=[DataService PostDataService:[NSString stringWithFormat:@"%@api/getActiveNoticeDetail",domainser] postDatas:[NSString stringWithFormat:@"id=%@",cid]];
    NSDictionary *article=[pw objectForKey:@"data"];
    
    
    //标题
    titleLabel.numberOfLines=0;
    NSString *titleStr=[_Commons turnNullValue:@"title" Object:article];
    titleLabel.text=titleStr;
    CGSize titleheight=[_Commons NSStringHeightForLabel:titleLabel.font width:titleLabel.frame.size.width Str:titleStr];
    titleLabel.frame=CGRectMake(titleLabel.frame.origin.x, titleLabel.frame.origin.y, titleLabel.frame.size.width, titleheight.height+24);
    
    //内容
    detailWeb.opaque=NO;
    detailWeb.backgroundColor=[UIColor clearColor];
    NSString *detailStr=[_Commons turnNullValue:@"content" Object:article];
    NSString *orderStr=[_Commons turnNullValue:@"description" Object:article];
    NSString *orgStr=[_Commons turnNullValue:@"oname" Object:article];
    NSString *timeStr=[_Commons turnNullValue:@"create_date" Object:article];
    timeStr=[_Commons stringtoDateforsecond:timeStr];
    NSString * webStr=[NSString stringWithFormat:@"<html> \n"
                       "<head> \n"
                       "<style type=\"text/css\"> \n"
                       "body {font-family: \"%@\"; font-size: %f; color: %@;}\n"
                       "#dtitle{color:orange;}"
                       "</style> \n"
                       "</head> \n"
                       "<body>%@<br/><br/>其他要求：%@<br/><br/>发布机构：%@<br/><br/>发布时间：%@</body> \n"
                       "</html>", @"宋体", 12.0,@"black",detailStr,orderStr,orgStr,timeStr];
    [detailWeb loadHTMLString:webStr baseURL:nil];
    
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
