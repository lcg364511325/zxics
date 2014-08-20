//
//  prowantedlist.m
//  zxics
//
//  Created by johnson on 14-8-11.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "prowantedlist.h"
#import "prowanted.h"
#import "prowantedDetail.h"
#import "AppDelegate.h"
#import "DataService.h"
#import "Commons.h"

@interface prowantedlist ()

@end

@implementation prowantedlist

@synthesize pwTView;

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
    list=[[NSMutableArray alloc]initWithCapacity:5];
    
    //加载数据
    [self loaddata];
    
    //上拉刷新下拉加载提示
    [pwTView addHeaderWithCallback:^{
        [list removeAllObjects];
        page=1;
        [self loaddata];
        [pwTView reloadData];
        [pwTView headerEndRefreshing];}];
    [pwTView addFooterWithCallback:^{
        page=page+1;
        [self loaddata];
        [pwTView reloadData];
        [pwTView footerEndRefreshing];
    }];
}

-(void)loaddata
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    NSMutableDictionary * pw = [NSMutableDictionary dictionaryWithCapacity:5];
    pw=[DataService PostDataService:[NSString stringWithFormat:@"%@api/mobileNeedRentAndBuy",myDelegate.url] postDatas:nil forPage:page forPageSize:10];
    NSArray *pwlist=[pw objectForKey:@"datas"];
    [list addObjectsFromArray:pwlist];
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
    
    static NSString *TableSampleIdentifier = @"prowanted";
    
    prowanted *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        NSArray * nib=[[NSBundle mainBundle]loadNibNamed:@"prowanted" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    NSDictionary *pwdetail = [list objectAtIndex:[indexPath row]];
    cell.titleLabel.text=[pwdetail objectForKey:@"title"];
    Commons *_Commons=[[Commons alloc]init];
    NSString *timestr=[NSString stringWithFormat:@"%@",[pwdetail objectForKey:@"createtime"]];
    cell.dateLabel.text=[_Commons stringtoDate:timestr];
    
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    prowantedDetail *_prowantedDetail=[[prowantedDetail alloc]init];
    [self.navigationController pushViewController:_prowantedDetail animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
