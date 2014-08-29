//
//  consumelist.m
//  zxics
//
//  Created by johnson on 14-8-7.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "consumelist.h"
#import "AppDelegate.h"
#import "DataService.h"
#import "Commons.h"
#import "personfootprintDetail.h"

@interface consumelist ()

@end

@implementation consumelist

@synthesize btntag;
@synthesize consumeTView;

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
    NSInteger buttonselect=[btntag integerValue];
    if (buttonselect==0) {
        self.UINavigationItem.title=@"消费查询";
        searchtype=@"consume";
    }else if (buttonselect==1)
    {
        self.UINavigationItem.title=@"停车记录";
        searchtype=@"park";
    }
    
    page=1;
    list=[[NSMutableArray alloc]initWithCapacity:5];
    
    [self loaddata];
    
    //上拉刷新下拉加载提示
    [consumeTView addHeaderWithCallback:^{
        [list removeAllObjects];
        page=1;
        [self loaddata];
        [consumeTView reloadData];
        [consumeTView headerEndRefreshing];}];
    [consumeTView addFooterWithCallback:^{
        page=page+1;
        [self loaddata];
        [consumeTView reloadData];
        [consumeTView footerEndRefreshing];
    }];
}

//加载数据
-(void)loaddata
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    NSMutableDictionary * pfp = [NSMutableDictionary dictionaryWithCapacity:5];
    pfp=[DataService PostDataService:[NSString stringWithFormat:@"%@api/findFootprint",domainser] postDatas:[NSString stringWithFormat:@"userid=%@&type=%@",myDelegate.entityl.userid,searchtype] forPage:page forPageSize:10];
    NSArray *pfplist=[pfp objectForKey:@"datas"];
    [list addObjectsFromArray:pfplist];
    
    //查询足迹类型
    NSMutableDictionary * type = [NSMutableDictionary dictionaryWithCapacity:1];
    type=[DataService PostDataService:[NSString stringWithFormat:@"%@api/findParameter",domainser] postDatas:@"type=trackType"];
    typelist=[type objectForKey:@"datas"];
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
    
    static NSString *TableSampleIdentifier = @"consumelistCell";
    
    consumelistCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        NSArray * nib=[[NSBundle mainBundle]loadNibNamed:@"consumelistCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    NSDictionary *pfpdetail = [list objectAtIndex:[indexPath row]];
    
    Commons *_commons=[[Commons alloc]init];
    NSString *timestr=[NSString stringWithFormat:@"%@",[pfpdetail objectForKey:@"log_date"]];
    cell.dateLable.text=[NSString stringWithFormat:@"%@",[_commons stringtoDate:timestr]];
    
    cell.detailLabel.text=[NSString stringWithFormat:@"%@",[pfpdetail objectForKey:@"terminaldec"]];
    cell.terminalLabel.text=[NSString stringWithFormat:@"%@",[pfpdetail objectForKey:@"terminalname"]];
    
    NSString *subtype=[NSString stringWithFormat:@"%@",[pfpdetail objectForKey:@"subtype"]];
    if ([subtype isEqualToString:@"支出"]) {
        cell.moneyLabel.text=[NSString stringWithFormat:@"-%@元",[pfpdetail objectForKey:@"money"]];
    }else if ([subtype isEqualToString:@"支入"])
    {
        cell.moneyLabel.text=[NSString stringWithFormat:@"+%@元",[pfpdetail objectForKey:@"money"]];
    }
    
    NSString *typevalue=[NSString stringWithFormat:@"%@",[pfpdetail objectForKey:@"type"]];
    for (NSDictionary *object in typelist) {
        NSString *objectvalue=[NSString stringWithFormat:@"%@",[object objectForKey:@"value"]];
        if ([objectvalue isEqualToString:typevalue]) {
            tname=[NSString stringWithFormat:@"%@",[object objectForKey:@"name"]];
        }
    }
    
    cell.stateLabel.text=[NSString stringWithFormat:@"%@",[pfpdetail objectForKey:@"status"]];
    
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
