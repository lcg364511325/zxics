//
//  conservationSearch.m
//  zxics
//
//  Created by johnson on 15-3-10.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import "conservationSearch.h"

@interface conservationSearch ()

@end

@implementation conservationSearch

@synthesize nameText;
@synthesize cardnoText;
@synthesize mobileText;
@synthesize stimeText;
@synthesize etimeText;
@synthesize delegate;

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
    [self.UINavigationBar setBackgroundImage:[UIImage imageNamed:@"logo_bg"] forBarMetrics:UIBarMetricsDefault];
}

//选择日期
- (IBAction)pickerAction:(id)sender{
    // Here we need to pass a full frame
    CustomIOS7AlertView *alertView = [[CustomIOS7AlertView alloc] init];
    UIButton *btn=(UIButton *)sender;
    timetype=btn.tag;
    
    // Add some custom content to the alert view
    [alertView setContainerView:[self createDemoView]];
    
    // Modify the parameters
    [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"确定", @"取消", nil]];
    [alertView setDelegate:self];
    
    [alertView setUseMotionEffects:true];
    
    // And launch the dialog
    [alertView show];
}

- (void)customIOS7dialogButtonTouchUpInside: (CustomIOS7AlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        [alertView close];
    }else if (buttonIndex==0)
    {
        NSString *dateFromData = [NSString stringWithFormat:@"%@",datePickerView.date];
        NSString *date = [dateFromData substringWithRange:NSMakeRange(0, 10)];
        if (timetype==0) {
            stimeText.text=date;
        }else{
            etimeText.text=date;
        }
        
        [alertView close];
    }
}

//日历选择
- (UIView *)createDemoView
{
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    
    datePickerView = [[UIDatePicker alloc] init];
    datePickerView.frame=CGRectMake(0, 10, 300, 216);
    datePickerView.locale=locale;
	datePickerView.autoresizingMask = UIViewAutoresizingNone;
	datePickerView.datePickerMode = UIDatePickerModeDate;
    [demoView addSubview:datePickerView];
    
    return demoView;
}

//返回值
-(IBAction)returnValueToSearch:(id)sender
{
    NSDictionary *myTypeDict = [NSDictionary dictionaryWithObjectsAndKeys:nameText.text,@"name",cardnoText.text,@"cardno",mobileText.text,@"mobile",stimeText.text,@"stime",etimeText.text,@"etime",nil];
    [delegate passDictionaryValue:myTypeDict key:nil tag:2];
    [self.navigationController popViewControllerAnimated:NO];
}


//后退
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
