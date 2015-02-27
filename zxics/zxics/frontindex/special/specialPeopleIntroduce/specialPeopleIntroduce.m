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
    [self.UINavigationBar setBackgroundImage:[UIImage imageNamed:@"logo_bg"] forBarMetrics:UIBarMetricsDefault];    
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
    titleLabel.numberOfLines=0;
    CGSize size =CGSizeMake(titleLabel.frame.size.width,500);
    UIFont * tfont = [UIFont systemFontOfSize:17];
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
    CGSize  actualsize =[[introduce objectForKey:@"title"] boundingRectWithSize:size options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
    titleLabel.frame = CGRectMake(titleLabel.frame.origin.x, titleLabel.frame.origin.y, titleLabel.frame.size.width, actualsize.height+24);
    
    //文章内容自动换行
    NSString * contentStr=[self flattenHTML:[NSString stringWithFormat:@"%@",[introduce objectForKey:@"content"]]];
    contentLabel.numberOfLines=0;
    size =CGSizeMake(contentLabel.frame.size.width,500);
    tfont = [UIFont systemFontOfSize:10];
    tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
    actualsize =[contentStr boundingRectWithSize:size options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
    contentLabel.frame = CGRectMake(contentLabel.frame.origin.x, titleLabel.frame.origin.y+titleLabel.frame.size.height, contentLabel.frame.size.width, actualsize.height+24);
    contentLabel.text=contentStr;
    
    userLabel.frame=CGRectMake(userLabel.frame.origin.x, contentLabel.frame.origin.y+contentLabel.frame.size.height, userLabel.frame.size.width, userLabel.frame.size.height);
    userLabel.text=@"发布人：会员";
    
    //时间戳转换为时间
    Commons *_Commons=[[Commons alloc]init];
    dateLabel.frame=CGRectMake(dateLabel.frame.origin.x, userLabel.frame.origin.y+30, dateLabel.frame.size.width, dateLabel.frame.size.height);
    dateLabel.text=[NSString stringWithFormat:@"发布时间：%@",[_Commons stringtoDate:[introduce objectForKey:@"createDate"]]];
    
    spiscrollview.contentSize=CGSizeMake(320, dateLabel.frame.origin.y-titleLabel.frame.origin.y+dateLabel.frame.size.height+20);
    
    //设置圆角边框
    UIImageView *borderImage=[[UIImageView alloc] init];
    borderImage.frame=CGRectMake(4,titleLabel.frame.origin.y-10,self.view.frame.size.width-8, dateLabel.frame.origin.y-titleLabel.frame.origin.y+dateLabel.frame.size.height+20);
    borderImage.layer.cornerRadius = 5;
    borderImage.layer.masksToBounds = YES;
    //设置边框及边框颜色
    borderImage.layer.borderWidth = 0.8;
    borderImage.layer.borderColor =[ [UIColor colorWithRed:200.0/255 green:199.0/255  blue:204.0/255 alpha:1.0f] CGColor];
    [spiscrollview addSubview:borderImage];
    
    spiscrollview.showsHorizontalScrollIndicator=NO;//不显示水平滑动线
    spiscrollview.showsVerticalScrollIndicator=YES;//不显示垂直滑动线
    spiscrollview.scrollEnabled=YES;
}
- (NSString *)flattenHTML:(NSString *)html {
    
    NSScanner *theScanner;
    NSString *text = nil;
    
    theScanner = [NSScanner scannerWithString:html];
    
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [NSString stringWithFormat:@"%@>", text]
                                               withString:@""];
    } // while //
    
    NSLog(@"-----===%@",html);
    return html;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
