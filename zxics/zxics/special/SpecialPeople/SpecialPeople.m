//
//  SpecialPeople.m
//  zxics
//
//  Created by johnson on 14-8-4.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "SpecialPeople.h"

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
    [self.navigationController setNavigationBarHidden:YES];
}


-(IBAction)goback:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:NO];
}

-(IBAction)buttonclick:(id)sender
{
    UIButton* btn = (UIButton*)sender;
    NSInteger btntag=[btn tag];
    SpecialPeopleDetail *spd = [[SpecialPeopleDetail alloc] initWithNibName:@"SpecialPeopleDetail" bundle:nil];
    spd.spdbtntag=[NSString stringWithFormat:@"%d",btntag];
    [self.navigationController pushViewController:spd animated:NO];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
