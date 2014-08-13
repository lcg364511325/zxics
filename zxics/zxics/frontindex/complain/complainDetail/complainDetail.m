//
//  complainDetail.m
//  zxics
//
//  Created by johnson on 14-8-5.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "complainDetail.h"
#import "Commons.h"

@interface complainDetail ()

@end

@implementation complainDetail

@synthesize complainaboutLabel;
@synthesize titleLabel;
@synthesize introduceLabel;
@synthesize detailsLabel;
@synthesize complainDateLabel;
@synthesize complainstateLabel;
@synthesize dealdateLabel;
@synthesize dealstateLabel;
@synthesize complaininfo;

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
    
    //加载数据
    [self loaddata];
}

-(void)loaddata
{
    //投诉对象
    NSString * subtype=[NSString stringWithFormat:@"%@",[complaininfo objectForKey:@"subtype"]];
    if ([subtype isEqualToString:@"0"]) {
        complainaboutLabel.text=@"网站服务";
    }else if ([subtype isEqualToString:@"1"])
    {
        complainaboutLabel.text=@"商铺服务";
    }else if ([subtype isEqualToString:@"2"])
    {
        complainaboutLabel.text=@"物业";
    }
    
    
    titleLabel.text=[complaininfo objectForKey:@"title"];
    
    introduceLabel.numberOfLines=0;
    CGSize size =CGSizeMake(300,500);
    UIFont * tfont = [UIFont systemFontOfSize:10];
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
    CGSize  actualsize =[[complaininfo objectForKey:@"descc"] boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
    introduceLabel.frame=CGRectMake(introduceLabel.frame.origin.x, introduceLabel.frame.origin.y, introduceLabel.frame.size.width, actualsize.height+20);
    introduceLabel.text=[complaininfo objectForKey:@"descc"];
    
    detailsLabel.numberOfLines=0;
    actualsize =[[complaininfo objectForKey:@"contents"] boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
    detailsLabel.frame=CGRectMake(detailsLabel.frame.origin.x, introduceLabel.frame.origin.y+introduceLabel.frame.size.height+30, detailsLabel.frame.size.width, actualsize.height+20);
    detailsLabel.text=[NSString stringWithFormat:@"投诉内容：%@",[complaininfo objectForKey:@"contents"]];
    
    Commons *_Commons=[[Commons alloc]init];
    complainDateLabel.frame=CGRectMake(complainDateLabel.frame.origin.x, detailsLabel.frame.origin.y+30, complainDateLabel.frame.size.width, complainDateLabel.frame.size.height);
    complainDateLabel.text=[NSString stringWithFormat:@"投诉时间：%@",[_Commons stringtoDate:[complaininfo objectForKey:@"createtime"]]];
    
    complainstateLabel.text=[complaininfo objectForKey:@"approverflag"];
    dealdateLabel.text=[complaininfo objectForKey:@"apptime"];
    dealstateLabel.text=[complaininfo objectForKey:@"1"];
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
