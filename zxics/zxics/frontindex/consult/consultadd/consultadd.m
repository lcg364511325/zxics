//
//  consultadd.m
//  zxics
//
//  Created by johnson on 14-8-11.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "consultadd.h"
#import "AppDelegate.h"
#import "DataService.h"

@interface consultadd ()

@end

@implementation consultadd

@synthesize consultTview;
@synthesize type;
@synthesize titleLabel;
@synthesize introduceLabel;
@synthesize detailLabel;
@synthesize webButton;
@synthesize comButton;


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
    type.userInteractionEnabled=NO;
    
    //初始化
    target=@"0";
    [webButton setBackgroundColor:[UIColor redColor]];
    
    [self settextviewShow:introduceLabel];
    [self settextviewShow:detailLabel];
    
    //加载报修类型
    NSMutableDictionary * infotype = [NSMutableDictionary dictionaryWithCapacity:1];
    infotype=[DataService PostDataService:[NSString stringWithFormat:@"%@api/findParameter",domainser] postDatas:@"type=consult"];
    list=[infotype objectForKey:@"datas"];
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
    [self.navigationController popViewControllerAnimated:NO];
}

//显示信息类型
-(IBAction)showtype:(id)sender
{
    consultTview.hidden=NO;
}


//选择咨询对象
-(IBAction)targetselect:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    NSInteger btntag=btn.tag;
    if (btntag==0) {
        target=@"0";
        [webButton setBackgroundColor:[UIColor redColor]];
        [comButton setBackgroundColor:[UIColor whiteColor]];
    }else if (btntag==1)
    {
        AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
        target=myDelegate.entityl.communityid;
        [comButton setBackgroundColor:[UIColor redColor]];
        [webButton setBackgroundColor:[UIColor whiteColor]];
    }
}

//提交数据
-(IBAction)submitdata:(id)sender
{
    if (![titleLabel.text isEqualToString:@""] && ![introduceLabel.text isEqualToString:@""] && ![detailLabel.text isEqualToString:@""] && typevalue!=nil) {
        AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
        NSMutableDictionary * state = [NSMutableDictionary dictionaryWithCapacity:5];
        
        state=[DataService PostDataService:[NSString stringWithFormat:@"%@api/addConsult",domainser] postDatas:[NSString stringWithFormat:@"userid=%@&communityid=%@&title=%@&descc=%@&contents=%@&subtype=%@&type=consult&receiveid=%@",myDelegate.entityl.userid,myDelegate.entityl.communityid,titleLabel.text,introduceLabel.text,detailLabel.text,typevalue,target]];
        
        status=[NSString stringWithFormat:@"%@",[state objectForKey:@"status"]];
        
        NSString *rowString =[NSString stringWithFormat:@"%@",[state objectForKey:@"info"]];
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }else{
        NSString *rowString =@"输入的内容不能为空";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if ([status isEqualToString:@"1"]) {
        
        consultlist *_consultlist=[[consultlist alloc]init];
        [self.navigationController pushViewController:_consultlist animated:NO];
    }
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
    NSUInteger row = [indexPath row];
    NSDictionary *consulttype=[list objectAtIndex:row];
    cell.textLabel.text = [consulttype objectForKey:@"name"];
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    NSDictionary *consulttype=[list objectAtIndex:row];
    type.text= [consulttype objectForKey:@"name"];
    typevalue= [consulttype objectForKey:@"value"];
    consultTview.hidden=YES;
    
}

//点击tableview以外的地方触发事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self.view];
    if (!CGRectContainsPoint([consultTview frame], pt)) {
        //to-do
        consultTview.hidden=YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
