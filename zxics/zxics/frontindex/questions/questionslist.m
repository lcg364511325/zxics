//
//  questionslist.m
//  zxics
//
//  Created by johnson on 14-8-11.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "questionslist.h"
#import "questionsCell.h"
#import "DataService.h"
#import "AppDelegate.h"
#import "Commons.h"
#import "questionsDetail.h"

@interface questionslist ()

@end

@implementation questionslist

@synthesize quesTView;

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
    [quesTView addHeaderWithCallback:^{
        [list removeAllObjects];
        page=1;
        [self loaddata];
        [quesTView reloadData];
        [quesTView headerEndRefreshing];}];
    [quesTView addFooterWithCallback:^{
        page=page+1;
        [self loaddata];
        [quesTView reloadData];
        [quesTView footerEndRefreshing];
    }];
}

-(void)loaddata
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    NSMutableDictionary * cp = [NSMutableDictionary dictionaryWithCapacity:5];
    cp=[DataService PostDataService:[NSString stringWithFormat:@"%@api/findProblem",domainser] postDatas:[NSString stringWithFormat:@"categoryId=54&communityid=%@",myDelegate.entityl.communityid] forPage:page forPageSize:10];
    NSArray *array=[cp objectForKey:@"datas"];
    [list addObjectsFromArray:array];
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
    
    static NSString *TableSampleIdentifier = @"questionsCell";
    
    questionsCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        NSArray * nib=[[NSBundle mainBundle]loadNibNamed:@"questionsCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    
    NSDictionary *cpdetail = [list objectAtIndex:[indexPath row]];
    
    cell.titleLabel.text=[cpdetail objectForKey:@"title"];
    
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    questionsDetail *_questionsDetail=[[questionsDetail alloc]init];
    NSDictionary *cpdetail = [list objectAtIndex:[indexPath row]];
    _questionsDetail.qtd=cpdetail;
    [self.navigationController pushViewController:_questionsDetail animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
