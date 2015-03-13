//
//  chargeQPersonList.m
//  zxics
//
//  Created by johnson on 15-3-13.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import "chargeQPersonList.h"
#import "DataService.h"
#import "AppDelegate.h"
#import "Commons.h"
#import "staffSearchCell.h"
#import "residentManager.h"
#import "chargeQueryDetail.h"

@interface chargeQPersonList ()

@end

@implementation chargeQPersonList

@synthesize suTView;
@synthesize cnoText;
@synthesize cpersonText;

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
        page=0;
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

//传递值
-(void)passValue:(NSString *)value key:(NSString *)key tag:(NSInteger)tag
{
    cid=value;
    [self loaddata];
    [suTView reloadData];
}

-(void)loaddata
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    NSMutableDictionary * pw = [NSMutableDictionary dictionaryWithCapacity:5];
    pw=[DataService PostDataService:[NSString stringWithFormat:@"%@api/getChargeList",domainser] postDatas:[NSString stringWithFormat:@"key=wjsnmnb&userid=%@&sqid=%@&fkr=%@&sfbh=%@",myDelegate.entityl.userid,cid,cpersonText.text,cnoText.text] forPage:page forPageSize:10];
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
    
    static NSString *TableSampleIdentifier = @"staffSearchCell";
    
    staffSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        NSArray * nib=[[NSBundle mainBundle]loadNibNamed:@"staffSearchCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    NSDictionary *sudetail = [list objectAtIndex:[indexPath row]];
    Commons *_Commons=[[Commons alloc]init];
    
    NSString *cnoStr=[_Commons turnNullValue:@"receivecode" Object:sudetail];
    cell.cnameLable.text=[NSString stringWithFormat:@"编号：%@",cnoStr];
    cell.cnameLable.font=[UIFont systemFontOfSize:12.0f];
    
    NSString *floorSrt=[_Commons turnNullValue:@"name" Object:sudetail];
    cell.nameLable.text=[NSString stringWithFormat:@"楼盘：%@",floorSrt];
    
    NSString *payuserStr=[_Commons turnNullValue:@"payusername" Object:sudetail];
    cell.cardnoLable.text=[NSString stringWithFormat:@"付款人：%@",payuserStr];
    
    NSString *chargecountStr=[_Commons turnNullValue:@"chargecount" Object:sudetail];
    cell.mobilelable.text=[NSString stringWithFormat:@"总金额：%@",chargecountStr];
    
    NSString *receivedateStr=[_Commons turnNullValue:@"receivedate" Object:sudetail];
    if (![receivedateStr isEqualToString:@""]) {
        receivedateStr=[_Commons stringtoDateforsecond:receivedateStr];
    }
    cell.floornameLable.text=[NSString stringWithFormat:@"收款时间：%@",receivedateStr];
    
    
    
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *sudetail = [list objectAtIndex:[indexPath row]];
    chargeQueryDetail *_wuyeNoticeDetail=[[chargeQueryDetail alloc]init];
    _wuyeNoticeDetail.rdetail=sudetail;
    [self.navigationController pushViewController:_wuyeNoticeDetail animated:NO];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [cnoText resignFirstResponder];
    [cpersonText resignFirstResponder];
}

-(IBAction)searchCharge:(id)sender
{
    [list removeAllObjects];
    [self loaddata];
    [suTView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
