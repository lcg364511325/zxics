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
    fontindex * _fontindex=[[fontindex alloc] init];
    
    [self.navigationController pushViewController:_fontindex animated:NO];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
