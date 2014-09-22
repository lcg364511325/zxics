//
//  Vicecardadd.m
//  zxics
//
//  Created by johnson on 14-8-9.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "Vicecardadd.h"
#import "AppDelegate.h"
#import "DataService.h"

@interface Vicecardadd ()

@end

@implementation Vicecardadd

@synthesize cardnoText;
@synthesize personnoText;

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

//副卡添加
-(IBAction)addvicecard:(id)sender
{
    if (![cardnoText.text isEqualToString:@""] && ![personnoText.text isEqualToString:@""]) {
        AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
        NSMutableDictionary * state = [NSMutableDictionary dictionaryWithCapacity:5];
        state=[DataService PostDataService:[NSString stringWithFormat:@"%@api/addOtherKa",domainser] postDatas:[NSString stringWithFormat:@"userid=%@&account=%@&codeid=%@",myDelegate.entityl.userid,cardnoText.text,personnoText.text]];
        NSString *rowString =[NSString stringWithFormat:@"%@",[state objectForKey:@"info"]];
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alter.delegate=self;
        [alter show];
    }else{
        NSString *rowString =@"内容不能为空";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alter.delegate=self;
        [alter show];
    }
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
