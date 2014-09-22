//
//  personfootprintlist.m
//  zxics
//
//  Created by johnson on 14-8-21.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "personfootprintlist.h"
#import "personfootprintCell.h"
#import "AppDelegate.h"
#import "DataService.h"
#import "Commons.h"
#import "personfootprintDetail.h"

@interface personfootprintlist ()

@end

@implementation personfootprintlist

@synthesize pfpTView;

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
    [self.UINavigationBar setBackgroundImage:[UIImage imageNamed:@"logo_bg"] forBarMetrics:UIBarMetricsDefault];    
    page=1;
    list=[[NSMutableArray alloc]initWithCapacity:5];
    
    [self loaddata];
    
    //上拉刷新下拉加载提示
    [pfpTView addHeaderWithCallback:^{
        [list removeAllObjects];
        page=1;
        [self loaddata];
        [pfpTView reloadData];
        [pfpTView headerEndRefreshing];}];
    [pfpTView addFooterWithCallback:^{
        page=page+1;
        [self loaddata];
        [pfpTView reloadData];
        [pfpTView footerEndRefreshing];
    }];
}

-(IBAction)goback:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

//加载数据
-(void)loaddata
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    NSMutableDictionary * pfp = [NSMutableDictionary dictionaryWithCapacity:5];
    pfp=[DataService PostDataService:[NSString stringWithFormat:@"%@api/findFootprint",domainser] postDatas:[NSString stringWithFormat:@"userid=%@",myDelegate.entityl.userid] forPage:page forPageSize:10];
    NSArray *pfplist=[pfp objectForKey:@"datas"];
    [list addObjectsFromArray:pfplist];
    
    //查询足迹类型
    NSMutableDictionary * type = [NSMutableDictionary dictionaryWithCapacity:1];
    type=[DataService PostDataService:[NSString stringWithFormat:@"%@api/findParameter",domainser] postDatas:@"type=trackType"];
    typelist=[type objectForKey:@"datas"];
}

//初始化tableview数据
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [list count];
    //只有一组，数组数即为行数。
}

// tableview数据显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"personfootprintCell";
    
    personfootprintCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        NSArray * nib=[[NSBundle mainBundle]loadNibNamed:@"personfootprintCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    NSDictionary *pfpdetail = [list objectAtIndex:[indexPath row]];
    
    Commons *_commons=[[Commons alloc]init];
    NSString *timestr=[NSString stringWithFormat:@"%@",[pfpdetail objectForKey:@"log_date"]];
    cell.dateLable.text=[NSString stringWithFormat:@"时间：%@",[_commons stringtoDate:timestr]];
    
    cell.detailLabel.text=[NSString stringWithFormat:@"内容：%@",[pfpdetail objectForKey:@"terminaldec"]];
    cell.terminalLabel.text=[NSString stringWithFormat:@"终端名称：%@",[pfpdetail objectForKey:@"terminalname"]];
    cell.moneyLabel.text=[NSString stringWithFormat:@"金额：%@元",[pfpdetail objectForKey:@"money"]];
    
    NSString *typevalue=[NSString stringWithFormat:@"%@",[pfpdetail objectForKey:@"type"]];
    for (NSDictionary *object in typelist) {
        NSString *objectvalue=[NSString stringWithFormat:@"%@",[object objectForKey:@"value"]];
        if ([objectvalue isEqualToString:typevalue]) {
            tname=cell.typeLabel.text=[NSString stringWithFormat:@"类型：%@",[object objectForKey:@"name"]];
        }
    }
    
    cell.stateLabel.text=[NSString stringWithFormat:@"状态：%@",[pfpdetail objectForKey:@"status"]];
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    personfootprintDetail *_personfootprintDetail=[[personfootprintDetail alloc]init];
    NSDictionary *pfpdetail = [list objectAtIndex:[indexPath row]];
    NSString *typevalue=[NSString stringWithFormat:@"%@",[pfpdetail objectForKey:@"type"]];
    for (NSDictionary *object in typelist) {
        NSString *objectvalue=[NSString stringWithFormat:@"%@",[object objectForKey:@"value"]];
        if ([objectvalue isEqualToString:typevalue]) {
            tname=[NSString stringWithFormat:@"类型：%@",[object objectForKey:@"name"]];
        }
    }
    _personfootprintDetail.pfp=pfpdetail;
    _personfootprintDetail.tname=tname;
    [self.navigationController pushViewController:_personfootprintDetail animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
