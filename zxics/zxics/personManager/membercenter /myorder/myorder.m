//
//  myorder.m
//  zxics
//
//  Created by johnson on 14-8-8.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "myorder.h"
#import "MJRefresh.h"
#import "AppDelegate.h"
#import "DataService.h"
#import "membercenter.h"

@interface myorder ()

@end

@implementation myorder

@synthesize myorderTView;

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
    oStatus=@"";
    pStatus=@"";
    page=1;
    list=[[NSMutableArray alloc]initWithCapacity:5];
    
    [self loaddata];
    
    //上拉刷新下拉加载提示
    [myorderTView addHeaderWithCallback:^{
        [list removeAllObjects];
        page=1;
        [self loaddata];
        [myorderTView reloadData];
        [myorderTView headerEndRefreshing];}];
    [myorderTView addFooterWithCallback:^{
        page=page+1;
        [self loaddata];
        [myorderTView reloadData];
        [myorderTView footerEndRefreshing];
    }];
}

-(void)loaddata
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    NSMutableDictionary * myo = [NSMutableDictionary dictionaryWithCapacity:5];
    myo=[DataService PostDataService:[NSString stringWithFormat:@"%@api/mobileMyGoodsList",domainser] postDatas:[NSString stringWithFormat:@"userid=%@&oStatus=%@&pState=%@",myDelegate.entityl.userid,oStatus,pStatus] forPage:page forPageSize:10];
    NSArray *myolist=[myo objectForKey:@"datas"];
    [list addObjectsFromArray:myolist];
    
}

-(IBAction)goback:(id)sender
{
    membercenter *_membercenter=[[membercenter alloc]init];
    [self.navigationController pushViewController:_membercenter animated:NO];
}

//初始化tableview数据
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [list count];
    //只有一组，数组数即为行数。
}

// tableview数据显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"myorderCell";
    
    myorderCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        NSArray * nib=[[NSBundle mainBundle]loadNibNamed:@"myorderCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    NSDictionary *myodetail = [list objectAtIndex:[indexPath row]];
    cell.ordernoLabel.text=[NSString stringWithFormat:@"%@",[myodetail objectForKey:@"orderSn"]];
    cell.countLabel.text=[NSString stringWithFormat:@"%@",[myodetail objectForKey:@"goodsNumber"]];
    cell.moneyLabel.text=[NSString stringWithFormat:@"¥%@",[myodetail objectForKey:@"goodsAmount"]];
    
    NSString *orderStatus=[NSString stringWithFormat:@"%@",[myodetail objectForKey:@"orderStatus"]];
    if ([orderStatus isEqualToString:@"0"]) {
        cell.stateLabel.text=@"未确认";
    }else if ([orderStatus isEqualToString:@"1"])
    {
        cell.stateLabel.text=@"确认";
    }else if ([orderStatus isEqualToString:@"2"])
    {
        cell.stateLabel.text=@"已取消";
    }else if ([orderStatus isEqualToString:@"3"])
    {
        cell.stateLabel.text=@"无效";
    }else if ([orderStatus isEqualToString:@"4"])
    {
        cell.stateLabel.text=@"退货";
    }
    
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    myorderDetail *_myorderDetail=[[myorderDetail alloc]init];
    NSDictionary *myodetail = [list objectAtIndex:[indexPath row]];
    _myorderDetail.orderid=[NSString stringWithFormat:@"%@",[myodetail objectForKey:@"orderId"]];
    [self.navigationController pushViewController:_myorderDetail animated:NO];
    
}

-(IBAction)searchtype:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    NSInteger btntag=btn.tag;
    oStatus=@"";
    pStatus=@"";
    if (btntag==0) {
        pStatus=@"0";
    }else if (btntag==1)
    {
        oStatus=@"1";
    }else if (btntag==2)
    {
        oStatus=@"2";
    }
    [list removeAllObjects];
    page=1;
    [self loaddata];
    [myorderTView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
