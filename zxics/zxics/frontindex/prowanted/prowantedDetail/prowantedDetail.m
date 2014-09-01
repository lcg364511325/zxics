//
//  prowantedDetail.m
//  zxics
//
//  Created by johnson on 14-8-11.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "prowantedDetail.h"
#import "Commons.h"

@interface prowantedDetail ()

@end

@implementation prowantedDetail

@synthesize pwSView;
@synthesize titleLabel;
@synthesize personLabel;
@synthesize telLabel;
@synthesize emailLabel;
@synthesize addrLabel;
@synthesize wantedLabel;
@synthesize dateLabel;
@synthesize pwd;

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
    titleLabel.text=[pwd objectForKey:@"title"];
    personLabel.text=[pwd objectForKey:@"contacts"];
    telLabel.text=[pwd objectForKey:@"phone"];
    emailLabel.text=[pwd objectForKey:@"emails"];
    
    //需求详细地址
    addrLabel.text=[NSString stringWithFormat:@"需求详细地址：%@",[pwd objectForKey:@"address"]];
    addrLabel.numberOfLines=0;
    CGSize size =CGSizeMake(addrLabel.frame.size.width,0);
    UIFont * tfont = addrLabel.font;
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
    
    CGSize  actualsize =[[pwd objectForKey:@"address"] boundingRectWithSize:size options:
                         NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
    
    addrLabel.frame=CGRectMake(addrLabel.frame.origin.x, addrLabel.frame.origin.y, addrLabel.frame.size.width, actualsize.height+24);
    
    //需求描述
    wantedLabel.text=[NSString stringWithFormat:@"需求描述：%@",[pwd objectForKey:@"rentdetail"]];
    wantedLabel.numberOfLines=0;
    actualsize =[[pwd objectForKey:@"rentdetail"] boundingRectWithSize:size options:
                         NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
    
    wantedLabel.frame=CGRectMake(wantedLabel.frame.origin.x, addrLabel.frame.origin.y+addrLabel.frame.size.height, wantedLabel.frame.size.width, actualsize.height+24);
    
    //发布时间
    Commons *_Commons=[[Commons alloc]init];
    NSString *timestr=[_Commons stringtoDateforsecond:[pwd objectForKey:@"createtime"]];
    dateLabel.text=[NSString stringWithFormat:@"发布时间：%@",timestr];
    dateLabel.frame=CGRectMake(dateLabel.frame.origin.x, wantedLabel.frame.origin.y+wantedLabel.frame.size.height, dateLabel.frame.size.width, dateLabel.frame.size.height);
    
    pwSView.contentSize=CGSizeMake(320, dateLabel.frame.size.height+dateLabel.frame.origin.y-titleLabel.frame.origin.y+10);
    pwSView.showsHorizontalScrollIndicator=NO;//不显示水平滑动线
    pwSView.showsVerticalScrollIndicator=YES;//不显示垂直滑动线
    pwSView.scrollEnabled=YES;
    
    
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
