//
//  questionsDetail.m
//  zxics
//
//  Created by johnson on 14-8-20.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "questionsDetail.h"

@interface questionsDetail ()

@end

@implementation questionsDetail

@synthesize qtd;
@synthesize qtSView;
@synthesize titleLabel;
@synthesize contentsLabel;

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
    titleLabel.text=[qtd objectForKey:@"title"];
    
    //内容
    [contentsLabel loadHTMLString:[NSString stringWithFormat:@"%@",[qtd objectForKey:@"content"]] baseURL:nil];
    CGSize size =CGSizeMake(contentsLabel.frame.size.width,0);
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:nil,NSFontAttributeName,nil];
    
    CGSize  actualsize =[[qtd objectForKey:@"content"] boundingRectWithSize:size options:
                         NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
    
    contentsLabel.frame=CGRectMake(contentsLabel.frame.origin.x, contentsLabel.frame.origin.y, contentsLabel.frame.size.width, actualsize.height+24);
    
    qtSView.contentSize=CGSizeMake(320, contentsLabel.frame.size.height+qtSView.frame.size.height-250);
    qtSView.showsHorizontalScrollIndicator=NO;//不显示水平滑动线
    qtSView.showsVerticalScrollIndicator=YES;//不显示垂直滑动线
    qtSView.scrollEnabled=YES;
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
