//
//  surveyDetail.m
//  zxics
//
//  Created by johnson on 14-8-16.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "surveyDetail.h"

@interface surveyDetail ()

@end

@implementation surveyDetail

@synthesize surveyWView;
@synthesize sid;
@synthesize style;
@synthesize type;

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
    if ([type isEqualToString:@"0"]) {
        self.UINavigationItem.title=@"参与调查";
    }else if([type isEqualToString:@"1"])
    {
        self.UINavigationItem.title=@"参与评价";
    }
    
    //设置web view
    NSURLRequest *request;
    
    
    //判断参与还是查看结果
    if ([style isEqualToString:@"1"]) {
        request =[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@mobilePage/mobileSureyResult.jsp?id=%@",domainser,sid]]];
    }else if ([style isEqualToString:@"0"])
    {
        request =[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@mobilePage/mobileSurveyQuestion.jsp?id=%@",domainser,sid]]];
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
