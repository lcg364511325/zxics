//
//  lifemdDetail.m
//  zxics
//
//  Created by johnson on 14-8-5.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "lifemdDetail.h"

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
    urlLabel.text=nil;
    MyLabel *webSite = [[MyLabel alloc] initWithFrame:CGRectMake(urlLabel.frame.origin.x, urlLabel.frame.origin.y, urlLabel.frame.size.width, urlLabel.frame.size.height)];
    [webSite setText:@"http://www.baidu.com"];
    [self.view addSubview:webSite];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
