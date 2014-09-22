//
//  nameforgoods.m
//  zxics
//
//  Created by johnson on 14-9-9.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "nameforgoods.h"
#import "goodslist.h"

@interface nameforgoods ()

@end

@implementation nameforgoods

@synthesize goodsnameText;

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
    [self.UINavigationBar setBackgroundImage:[UIImage imageNamed:@"logo_bg"] forBarMetrics:UIBarMetricsDefault];}

-(IBAction)searchofname:(id)sender
{
    goodslist *_goodslist=[[goodslist alloc]init];
    _goodslist.goodsname=goodsnameText.text;
    [self.navigationController pushViewController:_goodslist animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
