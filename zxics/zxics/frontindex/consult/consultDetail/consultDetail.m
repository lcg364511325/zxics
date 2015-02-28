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
    [self.UINavigationBar setBackgroundImage:[UIImage imageNamed:@"logo_bg"] forBarMetrics:UIBarMetricsDefault];    
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
    
    //设置圆角边框
    UIImageView *borderImage=[[UIImageView alloc] init];
    borderImage.frame=CGRectMake(4,titleLabel.frame.origin.y-2,self.view.frame.size.width-8, createdateLabel.frame.size.height+createdateLabel.frame.origin.y-titleLabel.frame.origin.y+13);
    borderImage.layer.cornerRadius = 5;
    borderImage.layer.masksToBounds = YES;
    //设置边框及边框颜色
    borderImage.layer.borderWidth = 0.8;
    borderImage.layer.borderColor =[ [UIColor colorWithRed:200.0/255 green:199.0/255  blue:204.0/255 alpha:1.0f] CGColor];
    [conSView addSubview:borderImage];
    
    //回答
    answerLabel.frame=CGRectMake(answerLabel.frame.origin.x, createdateLabel.frame.origin.y+30, answerLabel.frame.size.width, answerLabel.frame.size.height);
    
    id appaccount=[consultinfo objectForKey:@"appaccount"];
    if (appaccount!=[NSNull null]) {
        //回复内容
        UIWebView *replyDetailview=[[UIWebView alloc]init];
        replyDetailview.scrollView.bounces=NO;
        [replyDetailview loadHTMLString:[NSString stringWithFormat:@"<html> \n"
                                     "<head> \n"
                                     "<style type=\"text/css\"> \n"
                                     "body {font-family: \"%@\"; font-size: %f; color: %@;}\n"
                                     "</style> \n"
                                     "</head> \n"
                                     "<body>内容：%@</body> \n"
                                     "</html>", @"宋体", 12.0,@"black",[consultinfo objectForKey:@"reply_contents"]] baseURL:nil];
        actualsize =[[consultinfo objectForKey:@"reply_contents"] boundingRectWithSize:size options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
        replyDetailview.frame=CGRectMake(replyDetailLabel.frame.origin.x, answerLabel.frame.origin.y+30, replyDetailLabel.frame.size.width, actualsize.height+24);
        [conSView addSubview:replyDetailview];
        
        //回复人
        replyuserLabel.text=[NSString stringWithFormat:@"回复人：%@",[consultinfo objectForKey:@"appaccount"]];
        replyuserLabel.frame=CGRectMake(replyuserLabel.frame.origin.x, replyDetailview.frame.origin.y+replyDetailLabel.frame.size.height, replyuserLabel.frame.size.width, replyuserLabel.frame.size.height);
        
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
        NSString *assessdetailStr=[NSString stringWithFormat:@"%@",[consultinfo objectForKey:@"assessdetail"]];
        if ([assessdetailStr isEqualToString:@"<null>"]) {
            assessdetailStr=@"";
        }
        replydetailLabel.text=[NSString stringWithFormat:@"详细评价：%@",assessdetailStr];
        replydetailLabel.numberOfLines=0;
        actualsize =[[NSString stringWithFormat:@"%@",[consultinfo objectForKey:@"assessdetail"]] boundingRectWithSize:size options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
        replydetailLabel.frame=CGRectMake(replydetailLabel.frame.origin.x, assessLabel.frame.origin.y+30, replydetailLabel.frame.size.width, actualsize.height+24);
        
        //回复时间
        replyDateLabel.text=[NSString stringWithFormat:@"时间：%@",[_Commons stringtoDateforsecond:[consultinfo objectForKey:@"apptime"]]];
        replyDateLabel.frame=CGRectMake(replyDateLabel.frame.origin.x, replydetailLabel.frame.origin.y+replydetailLabel.frame.size.height, replyDateLabel.frame.size.width, replyDateLabel.frame.size.height);
        
        //设置圆角边框
        UIImageView *borderImage1=[[UIImageView alloc] init];
        borderImage1.frame=CGRectMake(4,replyDetailview.frame.origin.y-2,self.view.frame.size.width-8, replyDateLabel.frame.size.height+replyDateLabel.frame.origin.y-replyDetailview.frame.origin.y+13);
        borderImage1.layer.cornerRadius = 5;
        borderImage1.layer.masksToBounds = YES;
        //设置边框及边框颜色
        borderImage1.layer.borderWidth = 0.8;
        borderImage1.layer.borderColor =[ [UIColor colorWithRed:200.0/255 green:199.0/255  blue:204.0/255 alpha:1.0f] CGColor];
        [conSView addSubview:borderImage1];
    }
    if (appaccount!=[NSNull null])
    {
        conSView.contentSize=CGSizeMake(320, replyDateLabel.frame.origin.y-titleLabel.frame.origin.y+replyDateLabel.frame.size.height+10);
    }else{
        conSView.contentSize=CGSizeMake(320, answerLabel.frame.origin.y-titleLabel.frame.origin.y+answerLabel.frame.size.height+10);
    }
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
