//
//  addinfo.m
//  zxics
//
//  Created by johnson on 14-8-28.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "addinfo.h"
#import "AppDelegate.h"
#import "DataService.h"

@interface addinfo ()

@end

@implementation addinfo

@synthesize titleText;

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
    
    [self setTextView];

}

//创建textview
-(void)setTextView
{
    textView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(70, 122, 239, 30)];
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
    textView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    textView.layer.borderWidth=1.0f;
    textView.layer.cornerRadius=3.0f;
    [self.view addSubview:textView];
}

//发布信息
-(IBAction)submitinfo:(id)sender
{
    if (![titleText.text isEqualToString:@""] && ![textView.text isEqualToString:@""]) {
        AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
        NSMutableDictionary * state = [NSMutableDictionary dictionaryWithCapacity:5];
        NSString *userid=@"";
        if (myDelegate.entityl) {
            userid=myDelegate.entityl.userid;
        }
        state=[DataService PostDataService:[NSString stringWithFormat:@"%@api/AddReleaseInfoApi",domainser] postDatas:[NSString stringWithFormat:@"categoryId=73&title=%@&content=%@&userid=%@",titleText.text,textView.text,userid]];
        NSString *rowString =[NSString stringWithFormat:@"%@",[state objectForKey:@"info"]];
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        [self goback:nil];
    }else{
        NSString *rowString =@"标题或内容不能为空";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
}

-(IBAction)goback:(id)sender
{
    SpecialPeopleDetail *spd = [[SpecialPeopleDetail alloc] initWithNibName:@"SpecialPeopleDetail" bundle:nil];
    spd.spdbtntag=@"0";
    [self.navigationController pushViewController:spd animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
