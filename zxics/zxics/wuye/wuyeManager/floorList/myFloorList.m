//
//  myFloorList.m
//  zxics
//
//  Created by johnson on 15-3-11.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import "myFloorList.h"
#import "AppDelegate.h"
#import "DataService.h"
#import "Commons.h"
#import "succourCell.h"

@interface myFloorList ()

@end

@implementation myFloorList

@synthesize suTView;
@synthesize delegate;
@synthesize cid;

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
    pid=@"";
    page=0;
    list=[[NSMutableArray alloc]initWithCapacity:5];
    
    //加载数据
    [self loaddata];
    
    //上拉刷新下拉加载提示
    [suTView addHeaderWithCallback:^{
        [list removeAllObjects];
        page=0;
        [self loaddata];
        [suTView reloadData];
        [suTView headerEndRefreshing];}];
    [suTView addFooterWithCallback:^{
        page=page+1;
        [self loaddata];
        [suTView reloadData];
        [suTView footerEndRefreshing];
    }];
}

-(void)loaddata
{
    NSMutableDictionary * pw = [NSMutableDictionary dictionaryWithCapacity:5];
    pw=[DataService PostDataService:[NSString stringWithFormat:@"%@api/getCommunityList",domainser] postDatas:[NSString stringWithFormat:@"type=1&pId=%@&communityid=%@",pid,cid] forPage:page forPageSize:10];
    NSArray *pwlist=[pw objectForKey:@"data"];
    [list addObjectsFromArray:pwlist];
    if([list count]==0)
    {
        NSString *rowString =@"无下级数据显示，请重新选择";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alter show];
        pid=oldpid;
        [list removeAllObjects];
        [self loaddata];
        [suTView reloadData];
    }
}

-(IBAction)goback:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

//初始化tableview数据
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [list count];
    //只有一组，数组数即为行数。
}

// tableview数据显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"succourCell";
    
    succourCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        NSArray * nib=[[NSBundle mainBundle]loadNibNamed:@"succourCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    NSDictionary *sudetail = [list objectAtIndex:[indexPath row]];
    
    cell.dateLabel.text=[NSString stringWithFormat:@"名称：%@",[sudetail objectForKey:@"name"]];
    
    cell.dealstateLabel.text=[NSString stringWithFormat:@"面积（m²）：%@",[sudetail objectForKey:@"area"]];
    
    NSString *isverify=[NSString stringWithFormat:@"%@",[sudetail objectForKey:@"type"]];
    if ([isverify isEqualToString:@"0"]) {
        isverify=@"子社区";
    }else if ([isverify isEqualToString:@"1"])
    {
        isverify=@"楼盘";
    }else if ([isverify isEqualToString:@"2"])
    {
        isverify=@"单元";
    }else if ([isverify isEqualToString:@"3"])
    {
        isverify=@"房号";
    }else
    {
        isverify=@"商铺";
    }
    cell.titleLabel.text=[NSString stringWithFormat:@"类型：%@",isverify];
    
    //设置圆角边框
    cell.borderImage.layer.cornerRadius = 5;
    cell.borderImage.layer.masksToBounds = YES;
    //设置边框及边框颜色
    cell.borderImage.layer.borderWidth = 0.8;
    cell.borderImage.layer.borderColor =[ [UIColor colorWithRed:200.0/255 green:199.0/255  blue:204.0/255 alpha:1.0f] CGColor];
    
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Commons *_Commons=[[Commons alloc]init];
    NSDictionary *sudetail = [list objectAtIndex:[indexPath row]];
    NSString *isverify=[_Commons turnNullValue:@"type" Object:sudetail];
    if ([isverify isEqualToString:@"3"]) {
        hid=[_Commons turnNullValue:@"id" Object:sudetail];
        NSString *name=[NSString stringWithFormat:@"%@",[sudetail objectForKey:@"name"]];
        [self turntoredent:name];
    }else{
        pid=[_Commons turnNullValue:@"id" Object:sudetail];
        oldpid=[_Commons turnNullValue:@"pid" Object:sudetail];
        [list removeAllObjects];
        [self loaddata];
        [suTView reloadData];
    }
    
}

//确定选择房号
-(void)turntoredent:(NSString *)cname
{
    hname=cname;
    NSString *rowString =[NSString stringWithFormat:@"确定是否选择：%@？",cname];
    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alter show];
}

//alertview响应事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        [delegate passValue:hid key:hname tag:1];
        [self.navigationController popViewControllerAnimated:NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
