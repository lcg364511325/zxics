//
//  filecenterlist.m
//  zxics
//
//  Created by johnson on 14-8-13.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "filecenterlist.h"
#import "DataService.h"
#import "filecenterDetail.h"
#import "Commons.h"

@interface filecenterlist ()

@end

@implementation filecenterlist

@synthesize filecenterTView;

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
    [filecenterTView addHeaderWithCallback:^{
        [list removeAllObjects];
        page=1;
        [self loaddata];
        [filecenterTView reloadData];
        [filecenterTView headerEndRefreshing];}];
    [filecenterTView addFooterWithCallback:^{
        page=page+1;
        [self loaddata];
        [filecenterTView reloadData];
        [filecenterTView footerEndRefreshing];
    }];
    
    
    
}

//加载数据
-(void)loaddata
{
    NSMutableDictionary * spd = [NSMutableDictionary dictionaryWithCapacity:5];
    spd=[DataService PostDataService:[NSString stringWithFormat:@"%@api/releaseInfoApi",domainser] postDatas:@"categoryId=69&type=1" forPage:page forPageSize:10];
    NSArray *array=[spd objectForKey:@"datas"];
    [list addObjectsFromArray:array];

}

-(IBAction)goback:(id)sender
{
    SpecialPeople * _SpecialPeople=[[SpecialPeople alloc] init];
    
    [self.navigationController pushViewController:_SpecialPeople animated:NO];
}

//初始化tableview数据
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [list count];
    //只有一组，数组数即为行数。
}

// tableview数据显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"SpecialPeopleDetailCell";
    
    SpecialPeopleDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        NSArray * nib=[[NSBundle mainBundle]loadNibNamed:@"SpecialPeopleDetailCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    NSDictionary *detail = [list objectAtIndex:[indexPath row]];
    cell.titleLabel.text=[detail objectForKey:@"title"];
    
    
    Commons *_Commons=[[Commons alloc]init];
    cell.dateLabel.text=[_Commons stringtoDate:[detail objectForKey:@"createDate"]];
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *detail = [list objectAtIndex:[indexPath row]];
    filecenterDetail *_filecenterDetail=[[filecenterDetail alloc]init];
    _filecenterDetail.fid=[detail objectForKey:@"id"];
    [self.navigationController pushViewController:_filecenterDetail animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
