//
//  assess.m
//  zxics
//
//  Created by johnson on 14-8-15.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "assess.h"
#import "RadioBox.h"
#import "RadioGroup.h"

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
    
    //创建Radiao
    [self setRadiao];
}

//创建Radiao
-(void)setRadiao
{
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(20, 70, 280, 20)];
    lable.font=[UIFont systemFontOfSize:14.0f];
    [lable setTintColor:[UIColor blackColor]];
    lable.text=@"请选择评分";
     
    
    //代码实现
    RadioBox *radiobox1 = [[RadioBox alloc] initWithFrame:CGRectMake(0, 0, 40, 10)];
    RadioBox *radiobox2 = [[RadioBox alloc] initWithFrame:CGRectMake(60, 0, 40, 10)];
    RadioBox *radiobox3 = [[RadioBox alloc] initWithFrame:CGRectMake(120, 0, 40, 10)];
    RadioBox *radiobox4 = [[RadioBox alloc] initWithFrame:CGRectMake(180, 0, 40, 10)];
    RadioBox *radiobox5 = [[RadioBox alloc] initWithFrame:CGRectMake(240, 0, 40, 10)];
    
    radiobox1.text = @"1";
    radiobox2.text = @"2";
    radiobox3.text = @"3";
    radiobox4.text = @"4";
    radiobox5.text = @"5";
    
    radiobox1.value = 1;
    radiobox2.value = 2;
    radiobox3.value = 3;
    radiobox4.value = 4;
    radiobox5.value = 5;
    
    NSArray *controls = [NSArray arrayWithObjects:radiobox1,radiobox2,radiobox3,radiobox4,radiobox5, nil];
    
    RadioGroup * radioGroup1 = [[RadioGroup alloc] initWithFrame:CGRectMake(20, 100, 320, 30) WithControl:controls];
    
    [radioGroup1 addSubview:radiobox1];
    [radioGroup1 addSubview:radiobox2];
    [radioGroup1 addSubview:radiobox3];
    [radioGroup1 addSubview:radiobox4];
    [radioGroup1 addSubview:radiobox5];
    
    radioGroup1.textFont = [UIFont systemFontOfSize:14.0];
    radioGroup1.selectValue = 5;
    
    [self.view addSubview:lable];
    [self.view addSubview:radioGroup1];
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
