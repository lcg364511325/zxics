//
//  surveyDetail.m
//  zxics
//
//  Created by johnson on 14-8-16.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "surveyDetail.h"
#import "AppDelegate.h"

@interface surveyDetail ()

@end

@implementation surveyDetail

@synthesize surveyWView;
@synthesize sid;
@synthesize style;

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
    
    //设置web view
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    NSURLRequest *request;
    
    //判断参与还是查看结果
    if ([style isEqualToString:@"1"]) {
        request =[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@mobilePage/mobileSureyResult.jsp?id=%@",myDelegate.url,sid]]];
    }else if ([style isEqualToString:@"0"])
    {
        request =[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@mobilePage/mobileSurveyQuestion.jsp?id=%@",myDelegate.url,sid]]];
    }
    
    [surveyWView setScalesPageToFit:YES];
    [surveyWView loadRequest:request];
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
