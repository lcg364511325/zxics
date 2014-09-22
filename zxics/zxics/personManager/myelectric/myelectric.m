//
//  myelectric.m
//  zxics
//
//  Created by johnson on 14-9-5.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "myelectric.h"
#import "AppDelegate.h"
#import "DataService.h"
#import "myelectricCell.h"
#import "Commons.h"
#import "myelectricDetail.h"
#import "addelectric.h"
#import "personIndex.h"


@interface myelectric ()

@end

@implementation myelectric

@synthesize meTView;

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
    list=[[NSMutableArray alloc]initWithCapacity:1];
    
    //加载数据
    [self loaddata];
    
    //上拉刷新下拉加载提示
    [meTView addHeaderWithCallback:^{
        [list removeAllObjects];
        page=1;
        [self loaddata];
        [meTView reloadData];
        [meTView headerEndRefreshing];}];
    [meTView addFooterWithCallback:^{
        page=page+1;
        [self loaddata];
        [meTView reloadData];
        [meTView footerEndRefreshing];
    }];
}

-(void)loaddata
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    NSMutableDictionary * com = [NSMutableDictionary dictionaryWithCapacity:5];
    com=[DataService PostDataService:[NSString stringWithFormat:@"%@api/findGenerating",domainser] postDatas:[NSString stringWithFormat:@"userid=%@",myDelegate.entityl.userid] forPage:page forPageSize:10];
    NSArray *comlist=[com objectForKey:@"datas"];
    [list addObjectsFromArray:comlist];
    
}

-(IBAction)goback:(id)sender
{
    personIndex *_personIndex=[[personIndex alloc]init];
    [self.navigationController pushViewController:_personIndex animated:NO];
}

//初始化tableview数据
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [list count];
    //只有一组，数组数即为行数。
}

// tableview数据显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"myelectricCell";
    
    myelectricCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        NSArray * nib=[[NSBundle mainBundle]loadNibNamed:@"myelectricCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    
    NSDictionary *myelectricdetail = [list objectAtIndex:[indexPath row]];
    cell.comLabel.text=[NSString stringWithFormat:@"社区名称：%@",[myelectricdetail objectForKey:@"community_name"]];
    
    cell.countLabel.text=[NSString stringWithFormat:@"发电量：%.1fkcal",[[myelectricdetail objectForKey:@"generating"] floatValue]];
    
    Commons *_Commons=[[Commons alloc]init];
    NSString *timestr=[myelectricdetail objectForKey:@"createtime"];
    cell.dateLabel.text=[NSString stringWithFormat:@"上传时间：%@",[_Commons stringtoDate:timestr]];
    
    timestr=[myelectricdetail objectForKey:@"apptime"];
    cell.appdateLabel.text=[NSString stringWithFormat:@"审核时间：%@",[_Commons stringtoDate:timestr]];
    
    id state=[myelectricdetail objectForKey:@"type"];
    NSString *type=[NSString stringWithFormat:@"%@",[myelectricdetail objectForKey:@"type"]];
    if (state==[NSNull null] || [type isEqualToString:@"0"]) {
        cell.stateLabel.text=@"状态：提交";
    }else if ([type isEqualToString:@"1"])
    {
        cell.stateLabel.text=@"状态：审核";
    }else if ([type isEqualToString:@"2"])
    {
        cell.stateLabel.text=@"状态：退回";
    }else if ([type isEqualToString:@"3"])
    {
        cell.stateLabel.text=@"状态：取消";
    }
    
    id appaccount=[myelectricdetail objectForKey:@"appaccount"];
    if (appaccount==[NSNull null]) {
        cell.appuserLabel.text=@"审核人：";
    }else{
        cell.appuserLabel.text=[NSString stringWithFormat:@"审核人：%@",[myelectricdetail objectForKey:@"appaccount"]];    }
    
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    myelectricDetail *_myelectricDetail=[[myelectricDetail alloc]init];
    NSDictionary *comdetail = [list objectAtIndex:[indexPath row]];
    _myelectricDetail.me=comdetail;
    [self.navigationController pushViewController:_myelectricDetail animated:NO];
}

//新增发电
-(IBAction)addelectric:(id)sender
{
    addelectric *_addelectric=[[addelectric alloc]init];
    [self.navigationController pushViewController:_addelectric animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
