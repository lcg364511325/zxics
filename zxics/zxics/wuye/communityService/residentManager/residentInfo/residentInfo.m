//
//  residentInfo.m
//  zxics
//
//  Created by johnson on 15-3-3.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import "residentInfo.h"
#import "DataService.h"
#import "AppDelegate.h"
#import "Commons.h"
#import "residentMCell.h"
#import "residentDetail.h"

@interface residentInfo ()

@end

@implementation residentInfo

@synthesize suTView;
@synthesize cid;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    if (isfirst==1) {
        isfirst=0;
    }else{
        [list removeAllObjects];
        page=1;
        [self loaddata];
        [suTView reloadData];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController setNavigationBarHidden:YES];
    [self.UINavigationBar setBackgroundImage:[UIImage imageNamed:@"logo_bg"] forBarMetrics:UIBarMetricsDefault];
    isfirst=1;
    page=0;
    list=[[NSMutableArray alloc]initWithCapacity:5];
    
    //加载数据
    [self loaddata];
    
    //上拉刷新下拉加载提示
    [suTView addHeaderWithCallback:^{
        [list removeAllObjects];
        page=0;
        [self loaddata];
        [suTView reloadData];
        [suTView headerEndRefreshing];}];
    [suTView addFooterWithCallback:^{
        page=page+1;
        [self loaddata];
        [suTView reloadData];
        [suTView footerEndRefreshing];
    }];
}

-(void)loaddata
{
    NSMutableDictionary * pw = [NSMutableDictionary dictionaryWithCapacity:5];
    pw=[DataService PostDataService:[NSString stringWithFormat:@"%@api/findOwnerResidentList",domainser] postDatas:[NSString stringWithFormat:@"communityId=%@",cid] forPage:page forPageSize:10];
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
    
    static NSString *TableSampleIdentifier = @"residentMCell";
    
    residentMCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        NSArray * nib=[[NSBundle mainBundle]loadNibNamed:@"residentMCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    NSDictionary *sudetail = [list objectAtIndex:[indexPath row]];
    
    NSString *name=[NSString stringWithFormat:@"名称：%@",[sudetail objectForKey:@"name"]];
    if (![name isEqualToString:@"手机名称：<null>"]) {
        cell.nameLabal.text=name;
    }
    
    NSString *mobile=[NSString stringWithFormat:@"手机号码：%@",[sudetail objectForKey:@"mobile"]];
    if (![mobile isEqualToString:@"手机号码：<null>"]) {
        cell.mobileLabel.text=mobile;
    }
    
    
    NSString *isverify=[NSString stringWithFormat:@"地址：%@",[sudetail objectForKey:@"addr"]];
    if (![isverify isEqualToString:@"地址：<null>"]) {
        cell.addrLabal.text=isverify;
    }
    
    
    //设置圆角边框
    cell.borderImage.layer.cornerRadius = 5;
    cell.borderImage.layer.masksToBounds = YES;
    //设置边框及边框颜色
    cell.borderImage.layer.borderWidth = 0.8;
    cell.borderImage.layer.borderColor =[ [UIColor colorWithRed:200.0/255 green:199.0/255  blue:204.0/255 alpha:1.0f] CGColor];
    
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *sudetail = [list objectAtIndex:[indexPath row]];
    NSString *uid=[NSString stringWithFormat:@"%@",[sudetail objectForKey:@"id"]];
    residentDetail *_succourDetail=[[residentDetail alloc]init];
    _succourDetail.uid=uid;
    [self.navigationController pushViewController:_succourDetail animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
