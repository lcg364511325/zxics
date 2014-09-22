//
//  arrearagecheck.m
//  zxics
//
//  Created by johnson on 14-8-7.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "arrearagecheck.h"
#import "MJRefresh.h"
#import "AppDelegate.h"
#import "DataService.h"
#import "Commons.h"

@interface arrearagecheck ()

@end

@implementation arrearagecheck

@synthesize btntag;
@synthesize aacTView;

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
    [self.UINavigationBar setBackgroundImage:[UIImage imageNamed:@"logo_bg"] forBarMetrics:UIBarMetricsDefault];    NSInteger buttonselect=[btntag integerValue];
    if (buttonselect==0) {
        self.UINavigationItem.title=@"欠费查询";
        paystate=btntag;
    }else if (buttonselect==1)
    {
        self.UINavigationItem.title=@"缴费查询";
        paystate=@"";
    }
    
    page=1;
    list=[[NSMutableArray alloc]initWithCapacity:5];
    
    [self loaddata];
    
    //上拉刷新下拉加载提示
    [aacTView addHeaderWithCallback:^{
        [list removeAllObjects];
        page=1;
        [self loaddata];
        [aacTView reloadData];
        [aacTView headerEndRefreshing];}];
    [aacTView addFooterWithCallback:^{
        page=page+1;
        [self loaddata];
        [aacTView reloadData];
        [aacTView footerEndRefreshing];
    }];
}

//加载数据
-(void)loaddata
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    NSMutableDictionary * acc = [NSMutableDictionary dictionaryWithCapacity:5];
    acc=[DataService PostDataService:[NSString stringWithFormat:@"%@api/findPayment",domainser] postDatas:[NSString stringWithFormat:@"userid=%@&palystate=%@&sqid=%@",myDelegate.entityl.userid,paystate,myDelegate.entityl.communityid] forPage:page forPageSize:10];
    NSArray *accarray=[acc objectForKey:@"datas"];
    [list addObjectsFromArray:accarray];
    
    //查询收费类型
    NSMutableDictionary * type = [NSMutableDictionary dictionaryWithCapacity:1];
    type=[DataService PostDataService:[NSString stringWithFormat:@"%@api/findParameter",domainser] postDatas:@"type=payParame"];
    typelist=[type objectForKey:@"datas"];
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
    
    static NSString *TableSampleIdentifier = @"arrearageCell";
    
    arrearageCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        NSArray * nib=[[NSBundle mainBundle]loadNibNamed:@"arrearageCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    NSDictionary *accdetail = [list objectAtIndex:[indexPath row]];
    NSDictionary *pc=[accdetail objectForKey:@"pc"];
    
    cell.noLabel.text=[pc objectForKey:@"chargecode"];
    
    Commons *_commons=[[Commons alloc]init];
    NSString *timestr=[NSString stringWithFormat:@"%@",[pc objectForKey:@"starttime"]];
    cell.startTLabel.text=[_commons stringtoDate:timestr];
    
    timestr=[NSString stringWithFormat:@"%@",[pc objectForKey:@"endtime"]];
    cell.endTLabel.text=[_commons stringtoDate:timestr];
    
    
    NSString *typevalue=[NSString stringWithFormat:@"%@",[pc objectForKey:@"type"]];
    for (NSDictionary *object in typelist) {
        NSString *objectvalue=[NSString stringWithFormat:@"%@",[object objectForKey:@"value"]];
        if ([objectvalue isEqualToString:typevalue]) {
            tname=cell.typeLabel.text=[object objectForKey:@"name"];
        }
    }
    cell.moneyLabel.text=[NSString stringWithFormat:@"%@元",[pc objectForKey:@"charge"]];
    
    NSString *palystate=[NSString stringWithFormat:@"%@",[pc objectForKey:@"palystate"]];
    if ([palystate isEqualToString:@"0"]) {
        cell.stateLabel.text=@"欠费";
    }else if ([palystate isEqualToString:@"1"])
    {
        cell.stateLabel.text=@"已交";
    }
    
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    arrearageDetail *_arrearageDetail=[[arrearageDetail alloc]init];
    NSDictionary *accdetail = [list objectAtIndex:[indexPath row]];
    _arrearageDetail.acc=accdetail;
    _arrearageDetail.tname=tname;
    [self.navigationController pushViewController:_arrearageDetail animated:NO];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
