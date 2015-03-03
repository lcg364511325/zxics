//
//  residentManager.m
//  zxics
//
//  Created by johnson on 15-3-3.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import "residentManager.h"
#import "succourlist.h"
#import "DataService.h"
#import "AppDelegate.h"
#import "succourCell.h"
#import "Commons.h"
#import "residentInfo.h"

@interface residentManager ()

@end

@implementation residentManager

@synthesize suTView;

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
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    NSMutableDictionary * pw = [NSMutableDictionary dictionaryWithCapacity:5];
    pw=[DataService PostDataService:[NSString stringWithFormat:@"%@api/getCommunityList",domainser] postDatas:[NSString stringWithFormat:@"type=0&oId=%@&cIds=%@",myDelegate.entityl.orgId,myDelegate.entityl.communityid] forPage:page forPageSize:10];
    NSArray *pwlist=[pw objectForKey:@"data"];
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
    
    static NSString *TableSampleIdentifier = @"succourCell";
    
    succourCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        NSArray * nib=[[NSBundle mainBundle]loadNibNamed:@"succourCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    NSDictionary *sudetail = [list objectAtIndex:[indexPath row]];
    
    cell.titleLabel.text=[NSString stringWithFormat:@"名称：%@",[sudetail objectForKey:@"name"]];
    
    cell.dateLabel.text=[NSString stringWithFormat:@"地址：%@",[sudetail objectForKey:@"addr"]];
    
    NSString *isverify=[NSString stringWithFormat:@"%@",[sudetail objectForKey:@"isverify"]];
    if ([isverify isEqualToString:@"0"]) {
        cell.dealstateLabel.text=@"是否认证：否";
    }else if ([isverify isEqualToString:@"1"])
    {
        cell.dealstateLabel.text=@"是否认证：否";
    }else if ([isverify isEqualToString:@"2"])
    {
        cell.dealstateLabel.text=@"是否认证：是";
    }else if ([isverify isEqualToString:@"1"])
    {
        cell.dealstateLabel.text=@"是否认证：否";
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
    
    comid=[NSString stringWithFormat:@"%@",[sudetail objectForKey:@"id"]];
    NSString *name=[NSString stringWithFormat:@"%@",[sudetail objectForKey:@"name"]];
    [self turntoredent:name];
    
}

//退出登录
-(void)turntoredent:(NSString *)cname
{
    NSString *rowString =[NSString stringWithFormat:@"确定是否选择：%@？",cname];
    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alter show];
}

//alertview响应事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        residentInfo *_succourDetail=[[residentInfo alloc]init];
        _succourDetail.cid=comid;
        [self.navigationController pushViewController:_succourDetail animated:NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
