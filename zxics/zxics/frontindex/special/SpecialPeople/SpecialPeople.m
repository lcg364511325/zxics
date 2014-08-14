//
//  SpecialPeople.m
//  zxics
//
//  Created by johnson on 14-8-4.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "SpecialPeople.h"
#import "filecenterlist.h"

@interface SpecialPeople ()

@end

@implementation SpecialPeople

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


-(IBAction)goback:(id)sender
{
    fontindex *_fontindex=[[fontindex alloc]init];
    [self.navigationController pushViewController:_fontindex animated:NO];
}

//除文件中心外的页面跳转
-(IBAction)buttonclick:(id)sender
{
    UIButton* btn = (UIButton*)sender;
    NSInteger btntag=[btn tag];
    SpecialPeopleDetail *spd = [[SpecialPeopleDetail alloc] initWithNibName:@"SpecialPeopleDetail" bundle:nil];
    spd.spdbtntag=[NSString stringWithFormat:@"%d",btntag];
    [self.navigationController pushViewController:spd animated:NO];
}

//文件中心页面跳转
-(IBAction)filecenter:(id)sender
{
    filecenterlist *_filecenterlist=[[filecenterlist alloc]init];
    [self.navigationController pushViewController:_filecenterlist animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
