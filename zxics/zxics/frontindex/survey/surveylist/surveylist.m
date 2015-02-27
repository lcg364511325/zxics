//
//  surveylist.m
//  zxics
//
//  Created by johnson on 14-8-5.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "surveylist.h"
#import "AppDelegate.h"
#import "DataService.h"
#import "surveyDetail.h"

@interface surveylist ()

@end

@implementation surveylist

@synthesize surveyTView;
@synthesize btntag;

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
    [self.UINavigationBar setBackgroundImage:[UIImage imageNamed:@"logo_bg"] forBarMetrics:UIBarMetricsDefault];    page=1;
    list=[[NSMutableArray alloc]initWithCapacity:5];
    
    
    //加载数据
    [self loaddata];
    
    //上拉刷新下拉加载提示
    [surveyTView addHeaderWithCallback:^{
        [list removeAllObjects];
        page=1;
        [self loaddata];
        [surveyTView reloadData];
        [surveyTView headerEndRefreshing];}];
    [surveyTView addFooterWithCallback:^{
        page=page+1;
        [self loaddata];
        [surveyTView reloadData];
        [surveyTView footerEndRefreshing];
    }];
}

-(void)loaddata
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    NSMutableDictionary * surveylist = [NSMutableDictionary dictionaryWithCapacity:5];
    NSString *communityid=@"";
    
    if (myDelegate.entityl.communityid) {
        communityid=myDelegate.entityl.communityid;
    }
    
    if ([btntag isEqualToString:@"0"]) {
        self.UINavigationItem.title=@"在线调查";
        surveylist=[DataService PostDataService:[NSString stringWithFormat:@"%@api/findSurveyList",domainser] postDatas:[NSString stringWithFormat:@"communityid=%@&type=0",communityid] forPage:page forPageSize:10];
    }else if([btntag isEqualToString:@"1"])
    {
        self.UINavigationItem.title=@"业主评价";
        surveylist=[DataService PostDataService:[NSString stringWithFormat:@"%@api/findSurveyList",domainser] postDatas:[NSString stringWithFormat:@"communityid=%@&type=1",communityid] forPage:page forPageSize:10];
    }
    
    NSArray *array=[surveylist objectForKey:@"datas"];
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
    
    static NSString *TableSampleIdentifier = @"surveylistCell";
    
    surveylistCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        NSArray * nib=[[NSBundle mainBundle]loadNibNamed:@"surveylistCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    
    NSDictionary *survey = [list objectAtIndex:[indexPath row]];
    cell.joinButton.tag=cell.resultButton.tag=[[NSString stringWithFormat:@"%@",[survey objectForKey:@"id"]] integerValue];
    cell.titleLabel.text=[NSString stringWithFormat:@"%@",[survey objectForKey:@"title"]];
    [cell.joinButton addTarget:self action:@selector(joinin:) forControlEvents:UIControlEventTouchDown];
    [cell.resultButton addTarget:self action:@selector(result:) forControlEvents:UIControlEventTouchDown];
    
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
    
}

//参与页面跳转
-(void)joinin:(UIButton *)button
{
    surveyDetail *_surveyDetail=[[surveyDetail alloc]init];
    _surveyDetail.style=@"0";
    _surveyDetail.type=btntag;
    _surveyDetail.sid=[NSString stringWithFormat:@"%d",button.tag];
    [self.navigationController pushViewController:_surveyDetail animated:NO];
}

//查看结果页面跳转
-(void)result:(UIButton *)button
{
    surveyDetail *_surveyDetail=[[surveyDetail alloc]init];
    _surveyDetail.style=@"1";
    _surveyDetail.type=btntag;
    _surveyDetail.sid=[NSString stringWithFormat:@"%d",button.tag];
    [self.navigationController pushViewController:_surveyDetail animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
