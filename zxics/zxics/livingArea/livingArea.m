//
//  livingArea.m
//  zxics
//
//  Created by johnson on 15-2-27.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import "livingArea.h"

@interface livingArea ()

@end

@implementation livingArea
@synthesize wView;

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
    
    NSURL *url =[NSURL URLWithString:@"http://map.baidu.com/mobile/webapp/index/index/foo=bar/tab=place"];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [wView loadRequest:request];
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
