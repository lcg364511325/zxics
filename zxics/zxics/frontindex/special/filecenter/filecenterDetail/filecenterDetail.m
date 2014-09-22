//
//  filecenterDetail.m
//  zxics
//
//  Created by johnson on 14-8-13.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "filecenterDetail.h"

@interface filecenterDetail ()

@end

@implementation filecenterDetail

@synthesize filecenterWView;
@synthesize fid;

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
    //设置web view
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@f/service/filesDetail-%@.shtml",domainser,fid]]];
    [filecenterWView setScalesPageToFit:YES];
    [filecenterWView loadRequest:request];
    
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
