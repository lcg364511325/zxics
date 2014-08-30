//
//  specialPeopleIntroduce.m
//  zxics
//
//  Created by johnson on 14-8-5.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "specialPeopleIntroduce.h"
#import "Commons.h"

@interface specialPeopleIntroduce ()

@end

@implementation specialPeopleIntroduce

@synthesize titleLabel;
@synthesize contentLabel;
@synthesize userLabel;
@synthesize dateLabel;
@synthesize introduce;
@synthesize spiscrollview;

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

-(IBAction)goback:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)loaddata
{
    titleLabel.text=[introduce objectForKey:@"title"];
    
    //文章内容自动换行
    contentLabel.numberOfLines=0;
    CGSize size =CGSizeMake(contentLabel.frame.size.width,500);
    UIFont * tfont = [UIFont systemFontOfSize:10];
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
    CGSize  actualsize =[[introduce objectForKey:@"content"] boundingRectWithSize:size options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
    contentLabel.frame = CGRectMake(contentLabel.frame.origin.x, contentLabel.frame.origin.y, contentLabel.frame.size.width, actualsize.height+24);
    contentLabel.text=[introduce objectForKey:@"content"];
    
    userLabel.frame=CGRectMake(userLabel.frame.origin.x, contentLabel.frame.origin.y+contentLabel.frame.size.height, userLabel.frame.size.width, userLabel.frame.size.height);
    userLabel.text=[NSString stringWithFormat:@"发布人：%@",[introduce objectForKey:@"title"]];
    
    //时间戳转换为时间
    Commons *_Commons=[[Commons alloc]init];
    dateLabel.frame=CGRectMake(dateLabel.frame.origin.x, userLabel.frame.origin.y+30, dateLabel.frame.size.width, dateLabel.frame.size.height);
    dateLabel.text=[NSString stringWithFormat:@"发布时间：%@",[_Commons stringtoDate:[introduce objectForKey:@"createDate"]]];
    
    spiscrollview.contentSize=CGSizeMake(320, dateLabel.frame.origin.y-titleLabel.frame.origin.y+dateLabel.frame.size.height+20);
    spiscrollview.showsHorizontalScrollIndicator=NO;//不显示水平滑动线
    spiscrollview.showsVerticalScrollIndicator=YES;//不显示垂直滑动线
    spiscrollview.scrollEnabled=YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
