//
//  assess.m
//  zxics
//
//  Created by johnson on 14-8-15.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "assess.h"

@interface assess ()

@end

@implementation assess

@synthesize assessTextView;

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
    
    //创建textview
    [self setTextView];
}

//创建textview
-(void)setTextView
{
    HPGrowingTextView *textView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(20, 136, 280, 30)];
    textView.isScrollable = NO;
    textView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
    
	textView.minNumberOfLines = 1;
	textView.maxNumberOfLines = 6;
    // you can also set the maximum height in points with maxHeight
    // textView.maxHeight = 200.0f;
	textView.returnKeyType = UIReturnKeyGo; //just as an example
	textView.font = [UIFont systemFontOfSize:15.0f];
	textView.delegate = self;
    textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
    textView.backgroundColor = [UIColor whiteColor];
    textView.placeholder = @"请输入评价内容!";
    textView.layer.borderColor=[UIColor blueColor].CGColor;
    textView.layer.borderWidth=1.0f;
    textView.layer.cornerRadius=3.0f;
    [self.view addSubview:textView];
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
