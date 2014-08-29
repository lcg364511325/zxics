//
//  floorlist.m
//  zxics
//
//  Created by johnson on 14-8-9.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "floorlist.h"
#import "MJRefresh.h"
#import "DataService.h"

@interface floorlist ()

@end

@implementation floorlist

@synthesize floorTView;
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
    [self.UINavigationBar setBarTintColor:[UIColor colorWithRed:7.0/255.0 green:3.0/255.0 blue:164.0/255.0 alpha:1]];//设置bar背景颜色
    
    page=1;
    list=[[NSMutableArray alloc]initWithCapacity:1];
    
    //加载数据
    [self loaddata];
    
    //上拉刷新下拉加载提示
    [floorTView addHeaderWithCallback:^{
        [list removeAllObjects];
        page=1;
        [self loaddata];
        [floorTView reloadData];
        [floorTView headerEndRefreshing];}];
    [floorTView addFooterWithCallback:^{
        page=page+1;
        [self loaddata];
        [floorTView reloadData];
        [floorTView footerEndRefreshing];
    }];
}

-(void)loaddata
{
    NSMutableDictionary * floor = [NSMutableDictionary dictionaryWithCapacity:5];
    floor=[DataService PostDataService:[NSString stringWithFormat:@"%@api/communityRoomList",domainser] postDatas:[NSString stringWithFormat:@"communityid=%@",cid] forPage:page forPageSize:10];
    NSArray *floorlist=[floor objectForKey:@"datas"];
    [list addObjectsFromArray:floorlist];
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
    
    static NSString *TableSampleIdentifier = @"communityCell";
    
    communityCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        NSArray * nib=[[NSBundle mainBundle]loadNibNamed:@"communityCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    
    NSDictionary *floordetail = [list objectAtIndex:[indexPath row]];
    
    NSString *type=[NSString stringWithFormat:@"%@",[floordetail objectForKey:@"type"]];
    if ([type isEqualToString:@"0"]) {
        cell.nameLabel.text=@"类型：子社区";
    }else if ([type isEqualToString:@"1"])
    {
        cell.nameLabel.text=@"类型：楼盘";
    }else if ([type isEqualToString:@"2"])
    {
        cell.nameLabel.text=@"类型：单元";
    }else if ([type isEqualToString:@"3"])
    {
        cell.nameLabel.text=@"类型：房屋";
    }else if ([type isEqualToString:@"4"])
    {
        cell.nameLabel.text=@"类型：商铺";
    }
    cell.addrLabel.text=[NSString stringWithFormat:@"楼盘：%@",[floordetail objectForKey:@"communityname"]];
    cell.isidentifyLabel.text=[NSString stringWithFormat:@"面积：%@",[floordetail objectForKey:@"area"]];
    
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"确定是否申请？" message:@"是否申请加入本社区？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    [alertview show];
    NSDictionary *floordetail = [list objectAtIndex:[indexPath row]];
    fid=[NSString stringWithFormat:@"%@",[floordetail objectForKey:@"id"]];
}

//alertview触发事件
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
        NSMutableDictionary * state = [NSMutableDictionary dictionaryWithCapacity:5];
        state=[DataService PostDataService:[NSString stringWithFormat:@"%@api/communityAdd",domainser] postDatas:[NSString stringWithFormat:@"userid=%@&account=%@&communityid=%@&LPid=%@",myDelegate.entityl.userid,myDelegate.entityl.account,cid,fid]];
        NSString *rowString =[NSString stringWithFormat:@"%@",[state objectForKey:@"info"]];
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alter.delegate=self;
        [alter show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
