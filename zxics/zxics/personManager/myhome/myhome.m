//
//  myhome.m
//  zxics
//
//  Created by johnson on 14-9-4.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "myhome.h"
#import "personIndex.h"

@interface myhome ()

@end

@implementation myhome

@synthesize myhomeWView;

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
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@api/homemap",domainser]]];
    
    myhomeWView.scrollView.bounces=NO;
    [myhomeWView setScalesPageToFit:YES];
    [myhomeWView loadRequest:request];
}

-(IBAction)goback:(id)sender
{
    personIndex *_personIndex=[[personIndex alloc]init];
    [self.navigationController pushViewController:_personIndex animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
