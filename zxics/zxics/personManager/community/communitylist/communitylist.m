//
//  communitylist.m
//  zxics
//
//  Created by johnson on 14-8-9.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "communitylist.h"
#import "MJRefresh.h"
#import "DataService.h"
#import "floorlist.h"

@interface communitylist ()

@end

@implementation communitylist

@synthesize comTView;

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
    [comTView addHeaderWithCallback:^{
        [list removeAllObjects];
        page=1;
        [self loaddata];
        [comTView reloadData];
        [comTView headerEndRefreshing];}];
    [comTView addFooterWithCallback:^{
        page=page+1;
        [self loaddata];
        [comTView reloadData];
        [comTView footerEndRefreshing];
    }];
}

-(void)loaddata
{
    NSMutableDictionary * com = [NSMutableDictionary dictionaryWithCapacity:5];
    com=[DataService PostDataService:[NSString stringWithFormat:@"%@api/mobileCommunityList",domainser] postDatas:nil forPage:page forPageSize:10];
    NSArray *comlist=[com objectForKey:@"datas"];
    [list addObjectsFromArray:comlist];
    
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
    
    static NSString *TableSampleIdentifier = @"communityCell";
    
    communityCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        NSArray * nib=[[NSBundle mainBundle]loadNibNamed:@"communityCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    
    NSDictionary *comdetail = [list objectAtIndex:[indexPath row]];
    
    cell.nameLabel.text=[NSString stringWithFormat:@"名称：%@",[comdetail objectForKey:@"name"]];
    cell.addrLabel.text=[NSString stringWithFormat:@"地址：%@",[comdetail objectForKey:@"addr"]];
    NSString *isverify=[NSString stringWithFormat:@"%@",[comdetail objectForKey:@"isverify"]];
    if ([isverify isEqualToString:@"0"]) {
        cell.isidentifyLabel.text=@"是否认证：否";
    }else if ([isverify isEqualToString:@"1"])
    {
        cell.isidentifyLabel.text=@"是否认证：申请中";
    }
    else if ([isverify isEqualToString:@"2"])
    {
        cell.isidentifyLabel.text=@"是否认证：认证通过";
    }
    else if ([isverify isEqualToString:@"3"])
    {
        cell.isidentifyLabel.text=@"是否认证：认证不通过";
    }
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    floorlist *_floorlist=[[floorlist alloc]init];
    NSDictionary *comdetail = [list objectAtIndex:[indexPath row]];
    _floorlist.cid=[NSString stringWithFormat:@"%@",[comdetail objectForKey:@"id"]];
    [self.navigationController pushViewController:_floorlist animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
