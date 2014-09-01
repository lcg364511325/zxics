//
//  personfootprintDetail.m
//  zxics
//
//  Created by johnson on 14-8-21.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "personfootprintDetail.h"
#import "Commons.h"

@interface personfootprintDetail ()

@end

@implementation personfootprintDetail

@synthesize pfp;
@synthesize tname;
@synthesize pfpSView;
@synthesize cartnoLabel;
@synthesize terminalLabel;
@synthesize terminalnameLabel;
@synthesize terminaltypeLabel;
@synthesize detailLabel;
@synthesize footDetailLabel;
@synthesize accountLabel;
@synthesize typeLabel;
@synthesize childtypeLabel;
@synthesize moneylabel;
@synthesize stateLabel;
@synthesize runLabel;
@synthesize dateLabel;

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
    
    [self loaddata];
}

-(void)loaddata
{
    cartnoLabel.text=[NSString stringWithFormat:@"卡号：%@",[pfp objectForKey:@"cardcode"]];
    
    terminalLabel.text=[NSString stringWithFormat:@"终端号：%@",[pfp objectForKey:@"terminalcode"]];
    
    terminalnameLabel.text=[NSString stringWithFormat:@"终端名称：%@",[pfp objectForKey:@"terminalname"]];
    
    terminaltypeLabel.text=[NSString stringWithFormat:@"终端类型：%@",[pfp objectForKey:@"terminaltype"]];
    
    accountLabel.text=[NSString stringWithFormat:@"创建账号：%@",[pfp objectForKey:@"createaccount"]];
    //类型
    typeLabel.text=tname;
    
    childtypeLabel.text=[NSString stringWithFormat:@"子类型：%@",[pfp objectForKey:@"subtype"]];
    
    moneylabel.text=[NSString stringWithFormat:@"金额：%@",[pfp objectForKey:@"money"]];
    
    stateLabel.text=[NSString stringWithFormat:@"状态：%@",[pfp objectForKey:@"status"]];
    
    runLabel.text=[NSString stringWithFormat:@"流水号：%@",[pfp objectForKey:@"transsn"]];
    
    //日志时间
    Commons *_commons=[[Commons alloc]init];
    NSString *timestr=[NSString stringWithFormat:@"%@",[pfp objectForKey:@"log_date"]];
    dateLabel.text=[NSString stringWithFormat:@"日志时间：%@",[_commons stringtoDate:timestr]];
    
    //内容
    detailLabel.text=[NSString stringWithFormat:@"内容：%@",[pfp objectForKey:@"terminaldec"]];
    detailLabel.numberOfLines=0;
    CGSize size =CGSizeMake(detailLabel.frame.size.width,0);
    UIFont * tfont = detailLabel.font;
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];    CGSize  actualsize =[[pfp objectForKey:@"terminaldec"] boundingRectWithSize:size options:
                         NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
    detailLabel.frame=CGRectMake(detailLabel.frame.origin.x, detailLabel.frame.origin.y, detailLabel.frame.size.width, actualsize.height+24);
    
    //行踪描述
    footDetailLabel.text=[NSString stringWithFormat:@"行踪描述：%@",[pfp objectForKey:@"terminaldetail"]];
    actualsize =[[pfp objectForKey:@"terminaldetail"] boundingRectWithSize:size options:
                 NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
    footDetailLabel.frame=CGRectMake(footDetailLabel.frame.origin.x, detailLabel.frame.origin.y+detailLabel.frame.size.height, footDetailLabel.frame.size.width, actualsize.height+24);
    
    pfpSView.contentSize=CGSizeMake(320, footDetailLabel.frame.size.height+footDetailLabel.frame.origin.y-cartnoLabel.frame.origin.y+10);
    pfpSView.showsHorizontalScrollIndicator=NO;//不显示水平滑动线
    pfpSView.showsVerticalScrollIndicator=YES;//不显示垂直滑动线
    pfpSView.scrollEnabled=YES;
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
