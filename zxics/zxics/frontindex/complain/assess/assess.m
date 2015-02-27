//
//  assess.m
//  zxics
//
//  Created by johnson on 14-8-15.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "assess.h"
#import "DataService.h"
#import "complainlist.h"

@interface assess ()

@end

@implementation assess

@synthesize mid;

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
    btnlist=[[NSMutableArray alloc]initWithCapacity:5];
    
    //创建textview
    [self setTextView];
}

//创建textview
-(void)setTextView
{
    textView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(20, 136, 280, 30)];
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
    textView.layer.borderColor=[UIColor colorWithRed:200.0/255 green:199.0/255  blue:204.0/255 alpha:1.0f].CGColor;
    textView.layer.borderWidth=1.0f;
    textView.layer.cornerRadius=3.0f;
    [self.view addSubview:textView];
}

-(IBAction)goback:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}


//获得评分
-(IBAction)setassessvalue:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    assessvalue=[NSString stringWithFormat:@"%d",btn.tag];
    [btnlist addObject:btn];
    if ([btnlist count]>2) {
        [btnlist removeObjectAtIndex:0];
        UIButton *beforebtn=[btnlist objectAtIndex:0];
        [beforebtn setImage:[UIImage imageNamed:@"noselect"] forState:UIControlStateNormal];
    }else if ([btnlist count]==2)
    {
        UIButton *beforebtn=[btnlist objectAtIndex:0];
        [beforebtn setImage:[UIImage imageNamed:@"noselect"] forState:UIControlStateNormal];
    }
    [btn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
}


//提交评价
-(IBAction)submitassess:(id)sender
{
    NSMutableDictionary * state = [NSMutableDictionary dictionaryWithCapacity:5];
    state=[DataService PostDataService:[NSString stringWithFormat:@"%@api/ComplaintEvaluateInfo",domainser] postDatas:[NSString stringWithFormat:@"id=%@&text=%@&rank=%@",mid,textView.text,assessvalue]];
    NSString *status=[NSString stringWithFormat:@"%@",[state objectForKey:@"status"]];
    
    NSString *rowString =[NSString stringWithFormat:@"%@",[state objectForKey:@"info"]];
    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alter show];
    if ([status isEqualToString:@"1"]) {
        complainlist *_complainlist=[[complainlist alloc]init];
        [self.navigationController pushViewController:_complainlist animated:NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
