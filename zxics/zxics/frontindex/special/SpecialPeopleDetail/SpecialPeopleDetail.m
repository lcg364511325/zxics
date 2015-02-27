//
//  SpecialPeopleDetail.m
//  zxics
//
//  Created by johnson on 14-8-5.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "SpecialPeopleDetail.h"
#import "DataService.h"
#import "Commons.h"
#import "addinfo.h"

@interface SpecialPeopleDetail ()

@end

@implementation SpecialPeopleDetail

@synthesize spdbtntag;
@synthesize specialtableview;

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
        [specialtableview reloadData];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.UINavigationBar setBackgroundImage:[UIImage imageNamed:@"logo_bg"] forBarMetrics:UIBarMetricsDefault];    isfirst=1;
    page=1;
    list=[[NSMutableArray alloc]initWithCapacity:5];
    
    
    NSInteger selecttype=[spdbtntag integerValue];
    if (selecttype==0) {
        self.UINavigationItem.title=@"发布信息";
        caid=@"73";
        _addinfo.title=@"发布";
    }else if (selecttype==2)
    {
        self.UINavigationItem.title=@"知识库";
        caid=@"81";
    }else if (selecttype==3)
    {
        self.UINavigationItem.title=@"工作动态";
        caid=@"68";
    }else if (selecttype==4)
    {
        self.UINavigationItem.title=@"政策法规";
        caid=@"70";
    }else if (selecttype==5)
    {
        self.UINavigationItem.title=@"求助公告";
        caid=@"72";
    }
    
    //加载数据
    [self loaddata];
    
    //上拉刷新下拉加载提示
    [specialtableview addHeaderWithCallback:^{
        [list removeAllObjects];
        page=1;
        [self loaddata];
        [specialtableview reloadData];
        [specialtableview headerEndRefreshing];}];
    [specialtableview addFooterWithCallback:^{
        page=page+1;
        [self loaddata];
        [specialtableview reloadData];
        [specialtableview footerEndRefreshing];
    }];
}

//加载数据
-(void)loaddata
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    NSMutableDictionary * spd = [NSMutableDictionary dictionaryWithCapacity:5];
    if (myDelegate.entityl && [caid isEqualToString:@"73"]) {
        spd=[DataService PostDataService:[NSString stringWithFormat:@"%@api/releaseInfoApi",domainser] postDatas:[NSString stringWithFormat:@"categoryId=%@&memberId=%@&communityid=%@&type=1&orgId=%@",caid,myDelegate.entityl.userid,myDelegate.entityl.communityid,myDelegate.entityl.orgId] forPage:page forPageSize:10];
    }else{
        spd=[DataService PostDataService:[NSString stringWithFormat:@"%@api/releaseInfoApi",domainser] postDatas:[NSString stringWithFormat:@"categoryId=%@&type=1",caid] forPage:page forPageSize:10];
    }
    NSArray *array=[spd objectForKey:@"datas"];
    [list addObjectsFromArray:array];
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
    
    static NSString *TableSampleIdentifier = @"SpecialPeopleDetailCell";
    
    SpecialPeopleDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        NSArray * nib=[[NSBundle mainBundle]loadNibNamed:@"SpecialPeopleDetailCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    NSDictionary *detail = [list objectAtIndex:[indexPath row]];
    cell.titleLabel.text=[detail objectForKey:@"title"];
    
    Commons *_Commons=[[Commons alloc]init];
    cell.dateLabel.text=[_Commons stringtoDate:[detail objectForKey:@"createDate"]];
    
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
    NSDictionary *detail = [list objectAtIndex:[indexPath row]];
    specialPeopleIntroduce *_specialPeopleIntroduce=[[specialPeopleIntroduce alloc]init];
    _specialPeopleIntroduce.introduce=detail;
    [self.navigationController pushViewController:_specialPeopleIntroduce animated:NO];
}

//发布信息页面跳转
-(IBAction)addinfo:(id)sender
{
    addinfo *_addinfos=[[addinfo alloc]init];
    [self.navigationController pushViewController:_addinfos animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
