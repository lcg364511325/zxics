//
//  succourlist.m
//  zxics
//
//  Created by johnson on 14-9-5.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "succourlist.h"
#import "DataService.h"
#import "AppDelegate.h"
#import "succourCell.h"
#import "Commons.h"
#import "succourDetail.h"
#import "succouradd.h"
#import "fontindex.h"

@interface succourlist ()

@end

@implementation succourlist

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
    page=1;
    list=[[NSMutableArray alloc]initWithCapacity:5];
    
    //加载数据
    [self loaddata];
    
    //上拉刷新下拉加载提示
    [suTView addHeaderWithCallback:^{
        [list removeAllObjects];
        page=1;
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
    pw=[DataService PostDataService:[NSString stringWithFormat:@"%@api/myHelpApi",domainser] postDatas:[NSString stringWithFormat:@"account=%@",myDelegate.entityl.account] forPage:page forPageSize:10];
    NSArray *pwlist=[pw objectForKey:@"datas"];
    [list addObjectsFromArray:pwlist];
}

-(IBAction)goback:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
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
    
    cell.titleLabel.text=[NSString stringWithFormat:@"标题：%@",[sudetail objectForKey:@"title"]];
    
    Commons *_Commons=[[Commons alloc]init];
    NSString *timestr=[sudetail objectForKey:@"createtime"];
    cell.dateLabel.text=[NSString stringWithFormat:@"发起时间：%@",[_Commons stringtoDate:timestr]];
    
    NSString *dealflag=[NSString stringWithFormat:@"%@",[sudetail objectForKey:@"dealflag"]];
    NSString *approverflag=[NSString stringWithFormat:@"%@",[sudetail objectForKey:@"approverflag"]];
    id rank=[sudetail objectForKey:@"rank"];
    if ([dealflag isEqualToString:@"0"] && ![approverflag isEqualToString:@"1"]) {
        cell.dealstateLabel.text=@"处理结果：已申请";
    }else if ([dealflag isEqualToString:@"0"] && [approverflag isEqualToString:@"1"])
    {
        cell.dealstateLabel.text=@"处理结果：已受理";
    }else if (rank!=[NSNull null] && ![[NSString stringWithFormat:@"%@",rank] isEqualToString:@"0"])
    {
        cell.dealstateLabel.text=@"处理结果：已完成";
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
    succourDetail *_succourDetail=[[succourDetail alloc]init];
    _succourDetail.sud=sudetail;
    [self.navigationController pushViewController:_succourDetail animated:NO];
}


//申请救助
-(IBAction)addsuccour:(id)sender
{
    succouradd *_succouradd=[[succouradd alloc]init];
    [self.navigationController pushViewController:_succouradd animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
