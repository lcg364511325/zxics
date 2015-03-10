//
//  staffSearchList.m
//  zxics
//
//  Created by johnson on 15-3-10.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import "staffSearchList.h"
#import "staffSearchCell.h"
#import "AppDelegate.h"
#import "DataService.h"
#import "Commons.h"
#import "staffSearchType.h"

@interface staffSearchList ()

@end

@implementation staffSearchList

@synthesize suTView;

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
    
    searchtype=@"1";
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
    NSString *param=[NSString stringWithFormat:@"type=%@&front_communityid=%@",searchtype,myDelegate.entityl.communityid];
    if ([searchtype isEqualToString:@"1"]) {
        param=[NSString stringWithFormat:@"%@&name=%@&codeid=%@&mobile=%@",param,name,codeid,mobile];
    }else if([searchtype isEqualToString:@"2"]){
        param=[NSString stringWithFormat:@"%@&username=%@&cardcode=%@&account=%@",param,username,cardcode,account];
    }else if([searchtype isEqualToString:@"3"])
    {
        param=[NSString stringWithFormat:@"%@&communityid=%@&floorid=%@",param,communityid,floorid];
    }
    
    pw=[DataService PostDataService:[NSString stringWithFormat:@"%@api/findRycxMobileApi",domainser] postDatas:param forPage:page forPageSize:10];
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
    
    static NSString *TableSampleIdentifier = @"staffSearchCell";
    
    staffSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        NSArray * nib=[[NSBundle mainBundle]loadNibNamed:@"staffSearchCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    NSDictionary *sudetail = [list objectAtIndex:[indexPath row]];
    Commons *_Commons=[[Commons alloc]init];
    
    //社区
    NSString *cname=[_Commons turnNullValue:@"cname" Object:sudetail];
    cell.cnameLable.text=cname;
    
    //姓名
    NSString *pname=[_Commons turnNullValue:@"pname" Object:sudetail];
    cell.nameLable.text=pname;
    
    //身份证号
    NSString *codeidStr=[_Commons turnNullValue:@"codeid" Object:sudetail];
    cell.cardnoLable.text=codeidStr;
    
    //手机号
    NSString *mobileStr=[_Commons turnNullValue:@"mobile" Object:sudetail];
    cell.mobilelable.text=mobileStr;
    
    //房号名称
    NSString *roomName=[_Commons turnNullValue:@"roomName" Object:sudetail];
    cell.floornameLable.text=roomName;
    
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Commons *_Commons=[[Commons alloc]init];
    NSDictionary *sudetail = [list objectAtIndex:[indexPath row]];
//    shopMlistDetail *_wuyeNoticeDetail=[[shopMlistDetail alloc]init];
//    NSString *caid=[_Commons turnNullValue:@"id" Object:sudetail];
//    _wuyeNoticeDetail.pid=caid;
//    [self.navigationController pushViewController:_wuyeNoticeDetail animated:NO];
}

-(IBAction)setSearchType:(id)sender
{
    staffSearchType *_staffSearchType=[[staffSearchType alloc]init];
    _staffSearchType.type=searchtype;
    [self.navigationController pushViewController:_staffSearchType animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
