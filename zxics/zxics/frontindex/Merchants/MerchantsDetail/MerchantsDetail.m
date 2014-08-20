//
//  MerchantsDetail.m
//  zxics
//
//  Created by johnson on 14-8-11.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "MerchantsDetail.h"
#import "Commons.h"

@interface MerchantsDetail ()

@end

@implementation MerchantsDetail

@synthesize titleLabel;
@synthesize detailLabel;
@synthesize userLabel;
@synthesize dateLabel;
@synthesize cpd;
@synthesize merSView;

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


//加载数据
-(void)loaddata
{
    titleLabel.text=[cpd objectForKey:@"title"];
    
    //内容
    detailLabel.text=[NSString stringWithFormat:@"%@",[cpd objectForKey:@"content"]];
    detailLabel.numberOfLines=0;
    CGSize size =CGSizeMake(detailLabel.frame.size.width,0);
    UIFont * tfont = detailLabel.font;
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
    
    CGSize  actualsize =[[cpd objectForKey:@"descc"] boundingRectWithSize:size options:
                         NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
    
    detailLabel.frame=CGRectMake(detailLabel.frame.origin.x, detailLabel.frame.origin.y, detailLabel.frame.size.width, actualsize.height+24);
    
    //发布人
    NSString *memberid=[NSString stringWithFormat:@"%@",[cpd objectForKey:@"memberid"]];
    if (![memberid isEqualToString:@"<null>"]) {
        userLabel.text=@"发布人：会员";
    }else{
        userLabel.text=@"发布人：游客";
    }
    userLabel.frame=CGRectMake(userLabel.frame.origin.x, detailLabel.frame.origin.y+detailLabel.frame.size.height, userLabel.frame.size.width, userLabel.frame.size.height);
    
    //发布时间
    Commons *_Commons=[[Commons alloc]init];
    dateLabel.text=[NSString stringWithFormat:@"发布时间：%@",[_Commons stringtoDateforsecond:[cpd objectForKey:@"createDate"]]];
    dateLabel.frame=CGRectMake(dateLabel.frame.origin.x, userLabel.frame.origin.y+30, dateLabel.frame.size.width, dateLabel.frame.size.height);
    
    merSView.contentSize=CGSizeMake(320, detailLabel.frame.size.height+merSView.frame.size.height-250);
    merSView.showsHorizontalScrollIndicator=NO;//不显示水平滑动线
    merSView.showsVerticalScrollIndicator=YES;//不显示垂直滑动线
    merSView.scrollEnabled=YES;
    
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
