//
//  wuyeNoticeEdit.m
//  zxics
//
//  Created by johnson on 15-3-5.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import "wuyeNoticeEdit.h"
#import "DataService.h"
#import "AppDelegate.h"
#import "residentManager.h"
#import "Commons.h"

@interface wuyeNoticeEdit ()

@end

@implementation wuyeNoticeEdit

@synthesize titleText;
@synthesize communityText;
@synthesize detailLabel;
@synthesize orderLabel;
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
        if (cid) {
            self.UINavigationItem.title=@"修改社区活动信息";
            [self loaddata];
        }else{
            self.UINavigationItem.title=@"添加社区活动信息";
            [self loadMyView];
        }
    }else{
        if (cid) {
            self.UINavigationItem.title=@"修改物业通知信息";
            [self loaddata];
        }else{
            self.UINavigationItem.title=@"添加物业通知信息";
            [self loadMyView];
        }
    }
}

-(void)loadMyView
{
    //介绍内容
    detailView=[self setTextView:detailView];
    detailView.frame=CGRectMake(communityText.frame.origin.x, communityText.frame.origin.y+communityText.frame.size.height+3, titleText.frame.size.width, titleText.frame.size.height);
    detailLabel.frame=CGRectMake(detailLabel.frame.origin.x, communityText.frame.origin.y+communityText.frame.size.height+3, detailLabel.frame.size.width, detailLabel.frame.size.height);
    oldheight=titleText.frame.size.height;
    detailView.minNumberOfLines=1;
    detailView.maxNumberOfLines=6;
    detailView.placeholder=@"请输入";
    [self.view addSubview:detailView];
    
    //其他要求
    orderView=[self setTextView:orderView];
    orderView.frame=CGRectMake(communityText.frame.origin.x, detailView.frame.origin.y+detailView.frame.size.height+3, titleText.frame.size.width, titleText.frame.size.height);
    orderLabel.frame=CGRectMake(detailLabel.frame.origin.x, detailView.frame.origin.y+detailView.frame.size.height+3, detailLabel.frame.size.width, detailLabel.frame.size.height);
    orderView.minNumberOfLines=1;
    orderView.maxNumberOfLines=6;
    orderView.placeholder=@"请输入";
    [self.view addSubview:orderView];
    
}

-(void)loaddata
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作（异步操作）
        
        Commons *_Commons=[[Commons alloc]init];
        NSMutableDictionary * pw = [NSMutableDictionary dictionaryWithCapacity:5];
        pw=[DataService PostDataService:[NSString stringWithFormat:@"%@api/getActiveNoticeDetail",domainser] postDatas:[NSString stringWithFormat:@"id=%@",cid]];
        NSDictionary *article=[pw objectForKey:@"data"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            titleText.text=[_Commons turnNullValue:@"title" Object:article];
            comid=[_Commons turnNullValue:@"communityid" Object:article];
            communityText.text=[_Commons turnNullValue:@"cname" Object:article];
            
            //介绍内容
            NSString *detailStr=[_Commons turnNullValue:@"content" Object:article];
            CGSize detailheight=[_Commons NSStringHeightForLabel:communityText.font width:titleText.frame.size.width Str:detailStr];
            detailView=[self setTextView:detailView];
            detailView.text=detailStr;
            detailView.frame=CGRectMake(communityText.frame.origin.x, communityText.frame.origin.y+communityText.frame.size.height+3, titleText.frame.size.width, detailheight.height+24);
            detailLabel.frame=CGRectMake(detailLabel.frame.origin.x, communityText.frame.origin.y+communityText.frame.size.height+3, detailLabel.frame.size.width, detailLabel.frame.size.height);
            oldheight=titleText.frame.size.height;
            detailView.minNumberOfLines=1;
            detailView.maxNumberOfLines=6;
            detailView.placeholder=@"请输入";
            [self.view addSubview:detailView];
            
            //其他要求
            NSString *orderStr=[_Commons turnNullValue:@"description" Object:article];
            detailheight=[_Commons NSStringHeightForLabel:communityText.font width:titleText.frame.size.width Str:orderStr];
            orderView=[self setTextView:orderView];
            orderView.text=orderStr;
            orderView.frame=CGRectMake(communityText.frame.origin.x, detailView.frame.origin.y+detailView.frame.size.height+3, titleText.frame.size.width, detailheight.height+24);
            orderLabel.frame=CGRectMake(detailLabel.frame.origin.x, detailView.frame.origin.y+detailView.frame.size.height+3, detailLabel.frame.size.width, detailLabel.frame.size.height);
            orderView.minNumberOfLines=1;
            orderView.maxNumberOfLines=6;
            orderView.placeholder=@"请输入";
            [self.view addSubview:orderView];
            
        });
    });
    
}

//创建textview
-(HPGrowingTextView*)setTextView:(HPGrowingTextView*)textView
{
    textView = [[HPGrowingTextView alloc] init];
    textView.isScrollable = NO;
    textView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
	textView.returnKeyType = UIReturnKeyGo; //just as an example
	textView.delegate = self;
    textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
    textView.backgroundColor = [UIColor whiteColor];
    textView.layer.borderColor=[UIColor colorWithRed:200.0/255 green:199.0/255  blue:204.0/255 alpha:1.0f].CGColor;
    textView.layer.borderWidth=1.0f;
    textView.layer.cornerRadius=3.0f;
    return textView;
}

- (void)growingTextViewDidChange:(HPGrowingTextView *)growingTextView;
{
    if (growingTextView==detailView) {
        int newheight=detailView.frame.size.height;
        if (newheight!=oldheight) {
            //其他要求
            [orderView removeFromSuperview];
            orderView.frame=CGRectMake(communityText.frame.origin.x, detailView.frame.origin.y+detailView.frame.size.height+3, titleText.frame.size.width, orderView.frame.size.height);
            orderLabel.frame=CGRectMake(detailLabel.frame.origin.x, detailView.frame.origin.y+detailView.frame.size.height+3, detailLabel.frame.size.width, detailLabel.frame.size.height);
            orderView.minNumberOfLines=1;
            orderView.maxNumberOfLines=6;
            orderView.placeholder=@"请输入";
            [self.view addSubview:orderView];
            oldheight=newheight;
        }
    }
}

-(IBAction)goback:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

-(IBAction)submitWuyeInfo:(id)sender
{
    NSString *title=titleText.text;
    NSString *info=detailView.text;
    NSString *order=orderView.text;
    NSMutableDictionary * pw = [NSMutableDictionary dictionaryWithCapacity:5];
    
    if(!cid)
    {
        cid=@"";
    }
    
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    pw=[DataService PostDataService:[NSString stringWithFormat:@"%@api/modifyActiveNotice",domainser] postDatas:[NSString stringWithFormat:@"id=%@&title=%@&info=%@&description=%@&communityid=%@&categoryId=%@&uId=%@&oId=%@",cid,title,info,order,comid,type,myDelegate.entityl.userid,myDelegate.entityl.orgId]];
    NSString *rowString =[pw objectForKey:@"info"];
    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alter show];
}

//alertview响应事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if([cid isEqualToString:@""])
    {
        [self.navigationController popViewControllerAnimated:NO];
    }
}

-(IBAction)selectCommunity:(id)sender
{
    residentManager *_residentManager=[[residentManager alloc]init];
    _residentManager.type=@"1";
    _residentManager.delegate=self;
    [self.navigationController pushViewController:_residentManager animated:NO];
}

-(void)passValue:(NSString *)value key:(NSString *)key tag:(NSInteger)tag
{
    comid=value;
    communityText.text=key;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
