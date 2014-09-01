//
//  cpdetali.m
//  zxics
//
//  Created by johnson on 14-8-5.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "cpdetali.h"
#import "Commons.h"

@interface cpdetali ()

@end

@implementation cpdetali

@synthesize cpd;
@synthesize cid;
@synthesize titleLable;
@synthesize contentLable;
@synthesize othercontentLabel;
@synthesize orgLabel;
@synthesize dataLabel;
@synthesize cpScrollview;

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
    
    NSInteger selecttype=[cid integerValue];
    if (selecttype==79) {
        self.UINavigationItem.title=@"活动详情";
    }else if (selecttype==80)
    {
        self.UINavigationItem.title=@"通知详情";
    }
    
    //加载数据
    [self loadData];
}

//加载数据，处理界面
-(void)loadData
{
    titleLable.text=[cpd objectForKey:@"title"];
    UIWebView *contentview=[[UIWebView alloc]init];
    contentview.scrollView.bounces=NO;
    [contentview loadHTMLString:[NSString stringWithFormat:@"<html> \n"
                                 "<head> \n"
                                 "<style type=\"text/css\"> \n"
                                 "body {font-family: \"%@\"; font-size: %f; color: %@;}\n"
                                 "</style> \n"
                                 "</head> \n"
                                 "<body>回复内容：%@</body> \n"
                                 "</html>", @"宋体", 10.0,@"black",[cpd objectForKey:@"content"]] baseURL:nil];
    //[contentview loadHTMLString:[NSString stringWithFormat:@"回复内容：%@",[cpd objectForKey:@"content"]] baseURL:nil];
    CGSize size =CGSizeMake(contentLable.frame.size.width,0);
    UIFont * tfont = contentLable.font;
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
    
    CGSize  actualsize =[[cpd objectForKey:@"title"] boundingRectWithSize:size options:
                         NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
    
    contentview.frame=CGRectMake(contentLable.frame.origin.x, contentLable.frame.origin.y, contentLable.frame.size.width, actualsize.height+24);
    [cpScrollview addSubview:contentview];
    
    othercontentLabel.text=[NSString stringWithFormat:@"其他要求：%@",[cpd objectForKey:@"description"]];
    othercontentLabel.numberOfLines=0;
    actualsize =[[cpd objectForKey:@"description"] boundingRectWithSize:size options:
                 NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
    othercontentLabel.frame=CGRectMake(othercontentLabel.frame.origin.x, contentview.frame.origin.y+contentview.frame.size.height, othercontentLabel.frame.size.width, actualsize.height+24);
    
    orgLabel.text=[NSString stringWithFormat:@"发布机构：%@",[cpd objectForKey:@"orgName"]];
    orgLabel.frame=CGRectMake(othercontentLabel.frame.origin.x, othercontentLabel.frame.origin.y+othercontentLabel.frame.size.height, orgLabel.frame.size.width, orgLabel.frame.size.height);
    
    Commons *_Commons=[[Commons alloc]init];
    dataLabel.text=[NSString stringWithFormat:@"发布时间：%@",[_Commons stringtoDateforsecond:[cpd objectForKey:@"createDate"]]];
    dataLabel.frame=CGRectMake(dataLabel.frame.origin.x, orgLabel.frame.origin.y+30, dataLabel.frame.size.width, dataLabel.frame.size.height);
    
    cpScrollview.contentSize=CGSizeMake(320, dataLabel.frame.origin.y-titleLable.frame.origin.y+dataLabel.frame.size.height+20);
    cpScrollview.showsHorizontalScrollIndicator=NO;//不显示水平滑动线
    cpScrollview.showsVerticalScrollIndicator=YES;//不显示垂直滑动线
    cpScrollview.scrollEnabled=YES;
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
