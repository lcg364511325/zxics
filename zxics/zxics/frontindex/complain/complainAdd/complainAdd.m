//
//  complainAdd.m
//  zxics
//
//  Created by johnson on 14-8-5.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "complainAdd.h"
#import "DataService.h"
#import "AppDelegate.h"
#import "complainlist.h"

@interface complainAdd ()

@end

@implementation complainAdd

@synthesize list;
@synthesize complaintoTview;
@synthesize complaintoText;
@synthesize titleText;
@synthesize introduceText;
@synthesize detailsText;

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
    
    NSArray *array = [[NSArray alloc] initWithObjects:@"网站服务", @"商铺服务",
                      @"物业服务", nil];
    self.list=array;
    complaintoTview.hidden=YES;
    complaintoText.userInteractionEnabled=NO;
    complaintoText.text=@"网站服务";
    
    [self settextviewShow:titleText];
    [self settextviewShow:introduceText];
    [self settextviewShow:detailsText];
}

//为textview加上border
-(void)settextviewShow:(UITextView *)textview
{
    textview.layer.borderWidth=0.5;
    textview.layer.borderColor=[UIColor colorWithRed:166/255.0 green:166/255.0 blue:166/255.0 alpha:1.0f].CGColor;
    textview.layer.cornerRadius=5;
}

-(IBAction)submitcomplain:(id)sender
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    NSMutableDictionary * state = [NSMutableDictionary dictionaryWithCapacity:5];
    NSString *subtype=nil;
    
    if ([complaintoText.text isEqualToString:@"网站服务"]) {
        subtype=@"0";
    }else if ([complaintoText.text isEqualToString:@"商铺服务"])
    {
        subtype=@"1";
    }else if ([complaintoText.text isEqualToString:@"物业服务"])
    {
        subtype=@"2";
    }
    
    
    if (myDelegate.entityl) {
        state=[DataService PostDataService:[NSString stringWithFormat:@"%@api/complaintAddApi",domainser] postDatas:[NSString stringWithFormat:@"userid=%@&communityid=%@&title=%@&descc=%@&contents=%@&type=complaint&subtype=%@",myDelegate.entityl.userid,myDelegate.entityl.communityid,titleText.text,introduceText.text,detailsText.text,subtype]];
        
        status=[NSString stringWithFormat:@"%@",[state objectForKey:@"status"]];
        
        NSString *rowString =[NSString stringWithFormat:@"%@",[state objectForKey:@"info"]];
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
}


-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if ([status isEqualToString:@"1"]) {
        
        complainlist *_complainlist=[[complainlist alloc]init];
        [self.navigationController pushViewController:_complainlist animated:NO];
    }
}

//显示投诉对象下拉框
-(IBAction)selectwho:(id)sender
{
    complaintoTview.hidden=NO;
}

-(IBAction)goback:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

//初始化tableview数据
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.list count];
    //只有一组，数组数即为行数。
}

// tableview数据显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableSampleIdentifier];
    }
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [self.list objectAtIndex:row];
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *rowString = [self.list objectAtIndex:[indexPath row]];
    complaintoText.text=rowString;
    complaintoTview.hidden=YES;
    
}

//点击tableview以外的地方触发事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self.view];
    if (!CGRectContainsPoint([complaintoTview frame], pt)) {
        //to-do
        complaintoTview.hidden=YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
