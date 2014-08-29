//
//  consultDetail.m
//  zxics
//
//  Created by johnson on 14-8-11.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "consultDetail.h"
#import "Commons.h"

@interface consultDetail ()

@end

@implementation consultDetail

@synthesize consultinfo;
@synthesize titleLabel;
@synthesize introduceLabel;
@synthesize detailLabel;
@synthesize createdateLabel;
@synthesize replyDetailLabel;
@synthesize replyuserLabel;
@synthesize assessLabel;
@synthesize replydetailLabel;
@synthesize replyDateLabel;
@synthesize answerLabel;
@synthesize conSView;

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
    titleLabel.text=[consultinfo objectForKey:@"title"];
    
    //介绍
    introduceLabel.text=[NSString stringWithFormat:@"介绍：%@",[consultinfo objectForKey:@"descc"]];
    introduceLabel.numberOfLines=0;
    CGSize size =CGSizeMake(introduceLabel.frame.size.width,0);
    UIFont * tfont = introduceLabel.font;
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
    
    CGSize  actualsize =[[consultinfo objectForKey:@"descc"] boundingRectWithSize:size options:
                         NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
    
    introduceLabel.frame=CGRectMake(introduceLabel.frame.origin.x, introduceLabel.frame.origin.y, introduceLabel.frame.size.width, actualsize.height+24);
    
    //咨询内容
    detailLabel.text=[NSString stringWithFormat:@"投诉内容：%@",[consultinfo objectForKey:@"contents"]];
    detailLabel.numberOfLines=0;
    actualsize =[[consultinfo objectForKey:@"contents"] boundingRectWithSize:size options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
    detailLabel.frame=CGRectMake(detailLabel.frame.origin.x, introduceLabel.frame.origin.y+introduceLabel.frame.size.height, detailLabel.frame.size.width, actualsize.height+24);
    
    //咨询时间
    Commons *_Commons=[[Commons alloc]init];
    createdateLabel.text=[NSString stringWithFormat:@"时间：%@",[_Commons stringtoDateforsecond:[consultinfo objectForKey:@"createtime"]]];
    createdateLabel.frame=CGRectMake(createdateLabel.frame.origin.x, detailLabel.frame.origin.y+detailLabel.frame.size.height, createdateLabel.frame.size.width, createdateLabel.frame.size.height);
    
    //回答
    answerLabel.frame=CGRectMake(answerLabel.frame.origin.x, createdateLabel.frame.origin.y+30, answerLabel.frame.size.width, answerLabel.frame.size.height);
    
    id appaccount=[consultinfo objectForKey:@"appaccount"];
    if (appaccount!=[NSNull null]) {
        //回复内容
        replyDetailLabel.text=[NSString stringWithFormat:@"内容：%@",[consultinfo objectForKey:@"reply_contents"]];
        replyDetailLabel.numberOfLines=0;
        actualsize =[[consultinfo objectForKey:@"reply_contents"] boundingRectWithSize:size options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
        replyDetailLabel.frame=CGRectMake(replyDetailLabel.frame.origin.x, answerLabel.frame.origin.y+30, replyDetailLabel.frame.size.width, actualsize.height+24);
        
        //回复人
        replyuserLabel.text=[NSString stringWithFormat:@"回复人：%@",[consultinfo objectForKey:@"appaccount"]];
        replyuserLabel.frame=CGRectMake(replyuserLabel.frame.origin.x, replyDetailLabel.frame.origin.y+replyDetailLabel.frame.size.height, replyuserLabel.frame.size.width, replyuserLabel.frame.size.height);
        
        //满意度
        NSString *assess=[NSString stringWithFormat:@"%@",[consultinfo objectForKey:@"assess"]];
        if ([assess isEqualToString:@"4"]) {
            assessLabel.text=@"满意度：差";
        }else if ([assess isEqualToString:@"3"])
        {
            assessLabel.text=@"满意度：不满意";
        }else if ([assess isEqualToString:@"2"])
        {
            assessLabel.text=@"满意度：一般";
        }else if ([assess isEqualToString:@"1"])
        {
            assessLabel.text=@"满意度：满意";
        }else if ([assess isEqualToString:@"5"])
        {
            assessLabel.text=@"满意度：非常满意";
        }
        assessLabel.frame=CGRectMake(assessLabel.frame.origin.x, replyuserLabel.frame.origin.y+30, assessLabel.frame.size.width, assessLabel.frame.size.height);
        
        //详细评价
        replydetailLabel.text=[NSString stringWithFormat:@"详细评价：%@",[consultinfo objectForKey:@"assessdetail"]];
        replydetailLabel.numberOfLines=0;
        actualsize =[[consultinfo objectForKey:@"assessdetail"] boundingRectWithSize:size options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
        replydetailLabel.frame=CGRectMake(replydetailLabel.frame.origin.x, assessLabel.frame.origin.y+30, replydetailLabel.frame.size.width, actualsize.height+24);
        
        //回复时间
        replyDateLabel.text=[NSString stringWithFormat:@"时间：%@",[_Commons stringtoDateforsecond:[consultinfo objectForKey:@"apptime"]]];
        replyDateLabel.frame=CGRectMake(replyDateLabel.frame.origin.x, replydetailLabel.frame.origin.y+replydetailLabel.frame.size.height, replyDateLabel.frame.size.width, replyDateLabel.frame.size.height);
    }
    
    conSView.contentSize=CGSizeMake(320, replydetailLabel.frame.size.height+conSView.frame.size.height+replyDetailLabel.frame.size.height+introduceLabel.frame.size.height+detailLabel.frame.size.height-250);
    conSView.showsHorizontalScrollIndicator=NO;//不显示水平滑动线
    conSView.showsVerticalScrollIndicator=YES;//不显示垂直滑动线
    conSView.scrollEnabled=YES;
    
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
