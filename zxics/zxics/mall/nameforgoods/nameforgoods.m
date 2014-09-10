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
    [self.UINavigationBar setBarTintColor:[UIColor colorWithRed:7.0/255.0 green:3.0/255.0 blue:164.0/255.0 alpha:1]];//设置bar背景颜色
}

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
