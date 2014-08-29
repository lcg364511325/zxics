//
//  ViewController.m
//  zxics
//
//  Created by johnson on 14-8-9.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "DataService.h"
#import "MJRefresh.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize vicecTView;
@synthesize cardnoLabel;

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
    [vicecTView addHeaderWithCallback:^{
        [list removeAllObjects];
        page=1;
        [self loaddata];
        [vicecTView reloadData];
        [vicecTView headerEndRefreshing];}];
    [vicecTView addFooterWithCallback:^{
        page=page+1;
        [self loaddata];
        [vicecTView reloadData];
        [vicecTView footerEndRefreshing];
    }];
}

-(void)loaddata
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    NSMutableDictionary * vc = [NSMutableDictionary dictionaryWithCapacity:5];
    vc=[DataService PostDataService:[NSString stringWithFormat:@"%@api/findOtherKa",domainser] postDatas:[NSString stringWithFormat:@"userid=%@",myDelegate.entityl.userid] forPage:page forPageSize:10];
    NSArray *vclist=[vc objectForKey:@"datas"];
    [list addObjectsFromArray:vclist];
    
    cardnoLabel.text=[NSString stringWithFormat:@"%@",[vc objectForKey:@"thisUserKa"]];
    
    
}

-(IBAction)goback:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

//新增副卡页面跳转
-(IBAction)Vicecardadd:(id)sender
{
    Vicecardadd *_Vicecardadd=[[Vicecardadd alloc]init];
    [self.navigationController pushViewController:_Vicecardadd animated:NO];
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
    NSDictionary *vcdetail = [list objectAtIndex:[indexPath row]];
    
    cell.nameLabel.text=[NSString stringWithFormat:@"名称：%@",[vcdetail objectForKey:@"name"]];
    cell.addrLabel.text=[NSString stringWithFormat:@"账号：%@",[vcdetail objectForKey:@"account"]];
    cell.isidentifyLabel.text=[NSString stringWithFormat:@"卡号：%@",[vcdetail objectForKey:@"cardcode"]];
    
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    VicecardDetail *_VicecardDetail=[[VicecardDetail alloc]init];
    NSDictionary *vcdetail = [list objectAtIndex:[indexPath row]];
    _VicecardDetail.vcdetail=vcdetail;
    [self.navigationController pushViewController:_VicecardDetail animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
