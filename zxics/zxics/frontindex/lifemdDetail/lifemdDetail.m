//
//  lifemdDetail.m
//  zxics
//
//  Created by johnson on 14-8-5.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "lifemdDetail.h"
#import "Commons.h"
#import "ImageCacher.h"

@interface lifemdDetail ()

@end

@implementation lifemdDetail

@synthesize logoImage;
@synthesize orgLabel;
@synthesize urlLabel;
@synthesize addrLabel;
@synthesize addrdetailLabel;
@synthesize telLabel;
@synthesize businessLabel;
@synthesize contectpeopleLabel;
@synthesize introduceLabel;
@synthesize DetailsLabel;
@synthesize lifeLabel;
@synthesize dateLabel;
@synthesize Project_communityorgs;
@synthesize lfmdscrollview;

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
    [self showdatas];
}

//加载数据
-(void)showdatas
{
    NSDictionary *pc=[Project_communityorgs objectForKey:@"pc"];
    orgLabel.text=[pc objectForKey:@"target"];
    addrLabel.text=[Project_communityorgs objectForKey:@"townName"];
    addrdetailLabel.text=[pc objectForKey:@"addr"];
    telLabel.text=[pc objectForKey:@"phones"];
    businessLabel.text=[pc objectForKey:@"target"];
    contectpeopleLabel.text=[pc objectForKey:@"userName"];
    
    
    NSString *url=[NSString stringWithFormat:@"%@%@",domainser,[pc objectForKey:@"headUrl"]];
    NSURL *imgUrl=[NSURL URLWithString:url];
    if (hasCachedImage(imgUrl)) {
        [logoImage setImage:[UIImage imageWithContentsOfFile:pathForURL(imgUrl)]];
    }else{
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:imgUrl,@"url",logoImage,@"imageView",nil];
        [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
    }
    
    
    introduceLabel.numberOfLines=0;
    CGSize size =CGSizeMake(introduceLabel.frame.size.width,0);
    UIFont * tfont = introduceLabel.font;
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
    
    CGSize  actualsize =[[pc objectForKey:@"commet"] boundingRectWithSize:size options:
                         NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
    introduceLabel.text=[NSString stringWithFormat:@"介绍：%@",[pc objectForKey:@"commet"]];
    introduceLabel.frame=CGRectMake(introduceLabel.frame.origin.x, introduceLabel.frame.origin.y, introduceLabel.frame.size.width, actualsize.height+24);
    
    DetailsLabel.numberOfLines=0;
    actualsize =[[pc objectForKey:@"introduce"] boundingRectWithSize:size options:
                 NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
    DetailsLabel.text=[NSString stringWithFormat:@"详细：%@",[pc objectForKey:@"introduce"]];
    DetailsLabel.frame=CGRectMake(DetailsLabel.frame.origin.x, introduceLabel.frame.origin.y+introduceLabel.frame.size.height, DetailsLabel.frame.size.width, actualsize.height+24);
    
    
    lifeLabel.text=[NSString stringWithFormat:@"类型：%@",[Project_communityorgs objectForKey:@"typeName"]];
    lifeLabel.frame=CGRectMake(lifeLabel.frame.origin.x, DetailsLabel.frame.origin.y+DetailsLabel.frame.size.height, lifeLabel.frame.size.width, lifeLabel.frame.size.height);
    
    
    Commons *_Commons=[[Commons alloc]init];
    dateLabel.text=[NSString stringWithFormat:@"时间：%@",[_Commons stringtoDateforsecond:[pc objectForKey:@"createTime"]]];
    dateLabel.frame=CGRectMake(dateLabel.frame.origin.x, lifeLabel.frame.origin.y+30, dateLabel.frame.size.width, dateLabel.frame.size.height);
    
    
    urlLabel.text=nil;
    MyLabel *webSite = [[MyLabel alloc] initWithFrame:CGRectMake(urlLabel.frame.origin.x, urlLabel.frame.origin.y, urlLabel.frame.size.width, urlLabel.frame.size.height)];
    [webSite setText:[pc objectForKey:@"openurl"]];
    [lfmdscrollview addSubview:webSite];
    
    lfmdscrollview.contentSize=CGSizeMake(320, dateLabel.frame.origin.y-logoImage.frame.origin.y+dateLabel.frame.size.height+10);
    lfmdscrollview.showsHorizontalScrollIndicator=NO;//不显示水平滑动线
    lfmdscrollview.showsVerticalScrollIndicator=YES;//不显示垂直滑动线
    lfmdscrollview.scrollEnabled=YES;
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
