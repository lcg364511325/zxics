//
//  lifemd.m
//  zxics
//
//  Created by johnson on 14-8-4.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "lifemd.h"
#import "DataService.h"
#import "AppDelegate.h"
#import "Commons.h"

@interface lifemd ()

@end

@implementation lifemd

@synthesize lifetable;

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
    lfmdlist=[[NSMutableArray alloc]initWithCapacity:1];
    
    //加载数据
    [self loaddata];
    
    //上拉刷新下拉加载提示
    [lifetable addHeaderWithCallback:^{
        [lfmdlist removeAllObjects];
        page=1;
        [self loaddata];
        [lifetable reloadData];
        [lifetable headerEndRefreshing];}];
    [lifetable addFooterWithCallback:^{
        page=page+1;
        [self loaddata];
        [lifetable reloadData];
        [lifetable footerEndRefreshing];
    }];}

//加载数据
-(void)loaddata
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    NSMutableDictionary * lfmd = [NSMutableDictionary dictionaryWithCapacity:5];
    if (myDelegate.entityl) {
        lfmd=[DataService PostDataService:[NSString stringWithFormat:@"%@api/lifeStewardApi",domainser] postDatas:[NSString stringWithFormat:@"communityid=%@&",myDelegate.entityl.communityid] forPage:page forPageSize:10];
    }else{
        lfmd=[DataService PostDataService:[NSString stringWithFormat:@"%@api/lifeStewardApi",domainser] postDatas:nil forPage:page forPageSize:10];
    }
    NSArray *array=[lfmd objectForKey:@"datas"];
    [lfmdlist addObjectsFromArray:array];
}

-(IBAction)goback:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

//初始化tableview数据
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [lfmdlist count];
    //只有一组，数组数即为行数。
}

// tableview数据显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"lifemdcellTableViewCell";
    
    lifemdcellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        NSArray * nib=[[NSBundle mainBundle]loadNibNamed:@"lifemdcellTableViewCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    NSDictionary *Project_communityorgs = [lfmdlist objectAtIndex:[indexPath row]];
    NSDictionary *pc=[Project_communityorgs objectForKey:@"pc"];
    cell.businessLable.text=[pc objectForKey:@"target"];
    cell.orgLabel.text=[pc objectForKey:@"name"];
    cell.telLabel.text=[pc objectForKey:@"phones"];
    cell.peopleLabel.text=[pc objectForKey:@"userName"];
    
    //时间戳转时间
    Commons *_Commons=[[Commons alloc]init];
    cell.dateLabel.text=[_Commons stringtoDate:[pc objectForKey:@"createTime"]];
    
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *Project_communityorgs = [lfmdlist objectAtIndex:[indexPath row]];
    lifemdDetail * _lifemdDetail=[[lifemdDetail alloc] init];
    _lifemdDetail.Project_communityorgs=Project_communityorgs;
    [self.navigationController pushViewController:_lifemdDetail animated:NO];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
