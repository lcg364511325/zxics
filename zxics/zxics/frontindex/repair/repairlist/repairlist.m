//
//  repairlist.m
//  zxics
//
//  Created by johnson on 14-8-6.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "repairlist.h"
#import "DataService.h"
#import "AppDelegate.h"
#import "Commons.h"
#import "repairDetail.h"

@interface repairlist ()

@end

@implementation repairlist

@synthesize repairTView;
@synthesize allButton;

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
    [self.navigationController setNavigationBarHidden:YES];
    [self.UINavigationBar setBackgroundImage:[UIImage imageNamed:@"logo_bg"] forBarMetrics:UIBarMetricsDefault];
    source=@"";//初始化状态为全部
    list=[[NSMutableArray alloc]initWithCapacity:5];
    btnlist=[[NSMutableArray alloc]initWithCapacity:5];
    [btnlist addObject:allButton];
    
    //加载数据
    page=1;
    [self loaddata];
    
    //上拉刷新下拉加载提示
    [repairTView addHeaderWithCallback:^{
        [list removeAllObjects];
        page=1;
        [self loaddata];
        [repairTView reloadData];
        [repairTView headerEndRefreshing];}];
    [repairTView addFooterWithCallback:^{
        page=page+1;
        [self loaddata];
        [repairTView reloadData];
        [repairTView footerEndRefreshing];
    }];
}

//加载数据
-(void)loaddata
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    NSMutableDictionary * repair = [NSMutableDictionary dictionaryWithCapacity:5];
    
    repair=[DataService PostDataService:[NSString stringWithFormat:@"%@/api/propertyMaintainApi",domainser] postDatas:[NSString stringWithFormat:@"userid=%@&communityid=%@&source=%@",myDelegate.entityl.userid,myDelegate.entityl.communityid,source] forPage:page forPageSize:10];
    NSArray *array=[repair objectForKey:@"datas"];
    [list addObjectsFromArray:array];
}


//改变不同状态修改数据
-(IBAction)changestate:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    NSInteger btntag=btn.tag;
    [btnlist addObject:btn];
    if ([btnlist count]>2) {
        [btnlist removeObjectAtIndex:0];
        UIButton *beforebtn=[btnlist objectAtIndex:0];
        [beforebtn setBackgroundImage:[UIImage imageNamed:@"unseletedBtn"] forState:UIControlStateNormal];
    }else if ([btnlist count]==2)
    {
        UIButton *beforebtn=[btnlist objectAtIndex:0];
        [beforebtn setBackgroundImage:[UIImage imageNamed:@"unseletedBtn"] forState:UIControlStateNormal];
    }
    [btn setBackgroundImage:[UIImage imageNamed:@"selectedBtn"] forState:UIControlStateNormal];
    source=[NSString stringWithFormat:@"%d",btntag];
    if (btntag==5) {
        source=@"";
    }
    [list removeAllObjects];
    page=1;
    [self loaddata];
    [repairTView reloadData];
}

-(IBAction)goback:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(IBAction)repairadd:(id)sender
{
    repairadd *_repairadd=[[repairadd alloc]init];
    [self.navigationController pushViewController:_repairadd animated:NO];
}

//初始化tableview数据
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [list count];
    //只有一组，数组数即为行数。
}

// tableview数据显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"repairlistCell";
    
    repairlistCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        NSArray * nib=[[NSBundle mainBundle]loadNibNamed:@"repairlistCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    NSDictionary *repair = [list objectAtIndex:[indexPath row]];
    NSDictionary *pc=[repair objectForKey:@"pc"];
    cell.titleLabel.text=[pc objectForKey:@"title"];
    
    Commons *_Commons=[[Commons alloc]init];
    cell.dateLabel.text=[_Commons stringtoDate:[pc objectForKey:@"createtime"]];
    
    NSInteger repairsource=[[NSString stringWithFormat:@"%@",[pc objectForKey:@"source"]] integerValue];
    NSString *status;
    if(repairsource==0)
    {
        status=@"未处理";
    }else if(repairsource==1)
    {
        status=@"已受理";
    }else if(repairsource==2)
    {
        status=@"已派员";
    }else if(repairsource==3)
    {
        status=@"维修完成";
    }else if(repairsource==4)
    {
        status=@"关闭";
    }
    cell.rateLabel.text=status;
    
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
    repairDetail *_repairDetail=[[repairDetail alloc]init];
    NSDictionary *repair = [list objectAtIndex:[indexPath row]];
    NSDictionary *pc=[repair objectForKey:@"pc"];
    _repairDetail.re=pc;
    _repairDetail.resultname=[NSString stringWithFormat:@"%@",[repair objectForKey:@"rankName"]];
    [self.navigationController pushViewController:_repairDetail animated:NO];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
