//
//  consultlist.m
//  zxics
//
//  Created by johnson on 14-8-11.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "consultlist.h"
#import "consultCell.h"
#import "consultDetail.h"
#import "consultadd.h"
#import "MJRefresh.h"
#import "AppDelegate.h"
#import "DataService.h"
#import "Commons.h"

@interface consultlist ()

@end

@implementation consultlist

@synthesize consultTView;

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
        [consultTView reloadData];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.UINavigationBar setBackgroundImage:[UIImage imageNamed:@"logo_bg"] forBarMetrics:UIBarMetricsDefault];    
    isfirst=1;
    list=[[NSMutableArray alloc]initWithCapacity:5];
    
    //加载数据
    page=1;
    [self loaddata];
    
    //上拉刷新下拉加载提示
    [consultTView addHeaderWithCallback:^{
        [list removeAllObjects];
        page=1;
        [self loaddata];
        [consultTView reloadData];
        [consultTView headerEndRefreshing];}];
    [consultTView addFooterWithCallback:^{
        page=page+1;
        [self loaddata];
        [consultTView reloadData];
        [consultTView footerEndRefreshing];
    }];
}

-(void)loaddata
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    NSMutableDictionary * consult = [NSMutableDictionary dictionaryWithCapacity:5];
    consult=[DataService PostDataService:[NSString stringWithFormat:@"%@api/userConsult",domainser] postDatas:[NSString stringWithFormat:@"userid=%@&type=consult",myDelegate.entityl.userid] forPage:page forPageSize:10];
    NSArray *conlist=[consult objectForKey:@"datas"];
    [list addObjectsFromArray:conlist];
}

-(IBAction)goback:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

//新增咨询页面跳转
-(IBAction)consultadd:(id)sender
{
    consultadd *_consultadd=[[consultadd alloc]init];
    [self.navigationController pushViewController:_consultadd animated:NO];
}

//初始化tableview数据
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [list count];
    //只有一组，数组数即为行数。
}

// tableview数据显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"consultCell";
    
    consultCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        NSArray * nib=[[NSBundle mainBundle]loadNibNamed:@"consultCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    NSDictionary *consultdetail = [list objectAtIndex:[indexPath row]];
    cell.questionLabel.text=[consultdetail objectForKey:@"title"];
    
    Commons *_Commons=[[Commons alloc]init];
    cell.answerLabel.text=[_Commons stringtoDate:[consultdetail objectForKey:@"createtime"]];
    
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
    NSDictionary *consultdetail = [list objectAtIndex:[indexPath row]];
    consultDetail *_consultDetail=[[consultDetail alloc]init];
    _consultDetail.consultinfo=consultdetail;
    [self.navigationController pushViewController:_consultDetail animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
