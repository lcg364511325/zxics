//
//  succouradd.m
//  zxics
//
//  Created by johnson on 14-9-6.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "succouradd.h"
#import "AppDelegate.h"
#import "DataService.h"
#import "succourlist.h"

@interface succouradd ()

@end

@implementation succouradd

@synthesize typeText;
@synthesize userText;
@synthesize mobileText;
@synthesize emailText;
@synthesize addrText;
@synthesize titleText;
@synthesize detailText;
@synthesize typeTView;

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
    
    [self settextviewShow:detailText];
    
    [self findParameter];
}

//申请类型
-(void)findParameter
{
    NSMutableDictionary * type = [NSMutableDictionary dictionaryWithCapacity:1];
    type=[DataService PostDataService:[NSString stringWithFormat:@"%@api/findParameter",domainser] postDatas:@"type=rescueType"];
    list=[type objectForKey:@"datas"];
}

//为textview加上border
-(void)settextviewShow:(UITextView *)textview
{
    textview.layer.borderWidth=0.5;
    textview.layer.borderColor=[UIColor colorWithRed:166/255.0 green:166/255.0 blue:166/255.0 alpha:1.0f].CGColor;
    textview.layer.cornerRadius=5;
}

-(IBAction)goback:(id)sender
{
    succourlist *_succourlist=[[succourlist alloc]init];
    [self.navigationController pushViewController:_succourlist animated:NO];
}

-(IBAction)showtype:(id)sender
{
    typeTView.hidden=NO;
}

//初始化tableview数据
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [list count];
    //只有一组，数组数即为行数。
}

// tableview数据显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableSampleIdentifier];
    }
    NSDictionary *typedetail=[list objectAtIndex:[indexPath row]];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[typedetail objectForKey:@"name"]];
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *typedetail=[list objectAtIndex:[indexPath row]];
    typeText.text=[NSString stringWithFormat:@"%@",[typedetail objectForKey:@"name"]];
    value=[NSString stringWithFormat:@"%@",[typedetail objectForKey:@"value"]];
    typeTView.hidden=YES;
    
}

//点击tableview以外的地方触发事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self.view];
    if (!CGRectContainsPoint([typeTView frame], pt)) {
        //to-do
        typeTView.hidden=YES;
    }
}

//提交救助申请
-(IBAction)submitinfo:(id)sender
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    NSMutableDictionary * state = [NSMutableDictionary dictionaryWithCapacity:1];
    if (![typeText.text isEqualToString:@""] && ![userText.text isEqualToString:@""] && ![mobileText.text isEqualToString:@""] && ![emailText.text isEqualToString:@""] && ![addrText.text isEqualToString:@""] && ![titleText.text isEqualToString:@""] && ![detailText.text isEqualToString:@""]) {
        state=[DataService PostDataService:[NSString stringWithFormat:@"%@api/helpApplyApi",domainser] postDatas:[NSString stringWithFormat:@"account=%@&title=%@&contents=%@&phone=%@&email=%@&address=%@&type=%@&name=%@",myDelegate.entityl.account,titleText.text,detailText.text,mobileText.text,emailText.text,addrText.text,value,userText.text]];
        NSString *status=[NSString stringWithFormat:@"%@",[state objectForKey:@"status"]];
        
        NSString *rowString =[NSString stringWithFormat:@"%@",[state objectForKey:@"info"]];
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        if ([status isEqualToString:@"1"]) {
            [self goback:nil];
        }
    }else{
        NSString *rowString =@"输入的内容不能为空";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
