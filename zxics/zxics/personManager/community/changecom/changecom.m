//
//  changecom.m
//  zxics
//
//  Created by johnson on 14-8-9.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "changecom.h"
#import "MJRefresh.h"
#import "AppDelegate.h"
#import "DataService.h"
#import "personInfo.h"

@interface changecom ()

@end

@implementation changecom

@synthesize changecomTView;
@synthesize comLabel;
@synthesize ispersoninfo;

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
    [changecomTView addHeaderWithCallback:^{
        [list removeAllObjects];
        page=1;
        [self loaddata];
        [changecomTView reloadData];
        [changecomTView headerEndRefreshing];}];
    [changecomTView addFooterWithCallback:^{
        page=page+1;
        [self loaddata];
        [changecomTView reloadData];
        [changecomTView footerEndRefreshing];
    }];
}
    

//加载数据
-(void)loaddata
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    NSMutableDictionary * comlist = [NSMutableDictionary dictionaryWithCapacity:5];
    comlist=[DataService PostDataService:[NSString stringWithFormat:@"%@api/findCommunityList",myDelegate.url] postDatas:[NSString stringWithFormat:@"userid=%@",myDelegate.entityl.userid] forPage:page forPageSize:10];
    NSArray *com=[comlist objectForKey:@"datas"];
    [list addObjectsFromArray:com];
    
    //当前社区名称
    comLabel.text=myDelegate.entityl.communityName;
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
    
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableSampleIdentifier];
    }
    NSUInteger row = [indexPath row];
    NSDictionary *retype=[list objectAtIndex:row];
    cell.textLabel.text = [retype objectForKey:@"name"];
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    NSUInteger row = [indexPath row];
    NSDictionary *retype=[list objectAtIndex:row];
    myDelegate.entityl.communityid=[retype objectForKey:@"id"];
    myDelegate.entityl.communityName=[retype objectForKey:@"name"];
    NSString *rowString =@"切换成功";
    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alter show];
    if ([ispersoninfo isEqualToString:@"1"]) {
        personInfo *_personInfo=[[personInfo alloc]init];
        [self.navigationController pushViewController:_personInfo animated:NO];
    }else
    {
        [self loaddata];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
