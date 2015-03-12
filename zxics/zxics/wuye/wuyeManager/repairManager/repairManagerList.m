//
//  repairManagerList.m
//  zxics
//
//  Created by johnson on 15-3-11.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import "repairManagerList.h"
#import "AppDelegate.h"
#import "DataService.h"
#import "Commons.h"
#import "succourCell.h"
#import "residentManager.h"
#import "repairManagerDetail.h"

@interface repairManagerList ()

@end

@implementation repairManagerList

@synthesize suTView;
@synthesize firstBtn;
@synthesize secondBtn;
@synthesize thirdBtn;
@synthesize fourthBtn;

-(void)viewWillAppear:(BOOL)animated
{
    if (isfirst==1) {
        isfirst=0;
    }else{
        [list removeAllObjects];
        page=0;
        [self loaddata];
        [suTView reloadData];
    }
}

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
    
    isfirst=1;
    type=@"0";
    page=0;
    list=[[NSMutableArray alloc]initWithCapacity:5];
    btnlist=[NSArray arrayWithObjects:firstBtn,secondBtn,thirdBtn,fourthBtn, nil];
    
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
    
    residentManager *_residentManager=[[residentManager alloc]init];
    _residentManager.delegate=self;
    _residentManager.type=@"1";
    [self.navigationController pushViewController:_residentManager animated:NO];
}

-(void)loaddata
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    NSMutableDictionary * pw = [NSMutableDictionary dictionaryWithCapacity:5];
    pw=[DataService PostDataService:[NSString stringWithFormat:@"%@api/getRepairsList",domainser] postDatas:[NSString stringWithFormat:@"key=wjsnmnb&userid=%@&source=%@&sqid=%@",myDelegate.entityl.userid,type,cid] forPage:page forPageSize:10];
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
    
    static NSString *TableSampleIdentifier = @"succourCell";
    
    succourCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        NSArray * nib=[[NSBundle mainBundle]loadNibNamed:@"succourCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    NSDictionary *sudetail = [list objectAtIndex:[indexPath row]];
    Commons *_Commons=[[Commons alloc]init];
    
    //标题
    NSString *titleStr=[_Commons turnNullValue:@"title" Object:sudetail];
    cell.titleLabel.text=titleStr;
    cell.titleLabel.font=[UIFont boldSystemFontOfSize:15.0f];
    
    //类型
    NSString *pnameStr=[_Commons turnNullValue:@"parameter_name" Object:sudetail];
    cell.dateLabel.text=pnameStr;
    cell.dateLabel.textColor=[UIColor lightGrayColor];
    
    //日期
    NSString *timeStr=[_Commons turnNullValue:@"add_date" Object:sudetail];
    timeStr=[_Commons stringtoDateforsecond:timeStr];
    cell.dealstateLabel.text=timeStr;
    cell.dealstateLabel.textColor=[UIColor lightGrayColor];
    
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *sudetail = [list objectAtIndex:[indexPath row]];
    repairManagerDetail *_wuyeNoticeDetail=[[repairManagerDetail alloc]init];\
    _wuyeNoticeDetail.rdetail=sudetail;
    [self.navigationController pushViewController:_wuyeNoticeDetail animated:NO];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    succourCell *cell = (succourCell *)[self tableView:suTView cellForRowAtIndexPath:indexPath];
    CGFloat height=cell.borderImage.frame.size.height+6;
    return height;
}

//传递值
-(void)passValue:(NSString *)value key:(NSString *)key tag:(NSInteger)tag
{
    cid=value;
    [self loaddata];
    [suTView reloadData];
}

-(IBAction)changetype:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    type=[NSString stringWithFormat:@"%d",btn.tag];
    [list removeAllObjects];
    [self loaddata];
    [suTView reloadData];
    for (UIButton *oldbtn in btnlist) {
        if (btn==oldbtn) {
            [btn setBackgroundImage:[UIImage imageNamed:@"selectedBtn"] forState:UIControlStateNormal];
        }else
        {
            [oldbtn setBackgroundImage:[UIImage imageNamed:@"unseletedBtn"] forState:UIControlStateNormal];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
