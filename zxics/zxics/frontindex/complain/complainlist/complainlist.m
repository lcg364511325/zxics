//
//  complainlist.m
//  zxics
//
//  Created by johnson on 14-8-5.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "complainlist.h"
#import "DataService.h"
#import "AppDelegate.h"
#import "Commons.h"

@interface complainlist ()

@end

@implementation complainlist

@synthesize complaintTView;

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
    [self.UINavigationBar setBarTintColor:[UIColor colorWithRed:7.0/255.0 green:3.0/255.0 blue:164.0/255.0 alpha:1]];//设置bar背景颜色
    page=1;
    list=[[NSMutableArray alloc]initWithCapacity:5];
    
    //加载数据
    [self loaddata];
    
    //上拉刷新下拉加载提示
    [complaintTView addHeaderWithCallback:^{
        [list removeAllObjects];
        page=1;
        [self loaddata];
        [complaintTView reloadData];
        [complaintTView headerEndRefreshing];}];
    [complaintTView addFooterWithCallback:^{
        page=page+1;
        [self loaddata];
        [complaintTView reloadData];
        [complaintTView footerEndRefreshing];
    }];
}

//加载数据
-(void)loaddata
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    NSMutableDictionary * complaint = [NSMutableDictionary dictionaryWithCapacity:5];
    complaint=[DataService PostDataService:[NSString stringWithFormat:@"%@api/userConsult",myDelegate.url] postDatas:[NSString stringWithFormat:@"userid=%@&type=complaint",myDelegate.entityl.userid]];
    NSArray *array=[complaint objectForKey:@"datas"];
    [list addObjectsFromArray:array];
    
}

-(IBAction)goback:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:NO];
}

//初始化tableview数据
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [list count];
    //只有一组，数组数即为行数。
}

// tableview数据显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"complainCell";
    
    complainCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        NSArray * nib=[[NSBundle mainBundle]loadNibNamed:@"complainCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    NSDictionary *ProjectMessage = [list objectAtIndex:[indexPath row]];
    cell.titleLabel.text=[ProjectMessage objectForKey:@"title"];
    Commons *_Commons=[[Commons alloc]init];
    cell.dateLabel.text=[_Commons stringtoDate:[ProjectMessage objectForKey:@"send_date"]];
    
    NSInteger resultvalue=[[ProjectMessage objectForKey:@"dealflag"] integerValue];
    NSInteger app=[[ProjectMessage objectForKey:@"approverflag"] integerValue];
    NSString *assess=[NSString stringWithFormat:@"%@",[ProjectMessage objectForKey:@"assess"]];
    if (resultvalue==0 && app!=1) {
        cell.resultLabel.text=@"已申请";
    }else if (resultvalue==0 && app==1)
    {
        cell.resultLabel.text=@"已受理";
    }else if (resultvalue!=0 && app==1)
    {
        if (assess!=nil && ![assess isEqualToString:@"0"] && ![assess isEqualToString:@"<null>"] ) {
            cell.resultLabel.text=@"已完成";
        }else{
            cell.resultLabel.text=@"已处理";
        }
    }
    
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *ProjectMessage = [list objectAtIndex:[indexPath row]];
    complainDetail *_complainDetail=[[complainDetail alloc]init];
    _complainDetail.complaininfo=ProjectMessage;
    [self.navigationController pushViewController:_complainDetail animated:NO];
    
}


//我要投诉页面跳转
-(IBAction)complainadd:(id)sender
{
    complainAdd * _complainAdd=[[complainAdd alloc] init];
    
    [self.navigationController pushViewController:_complainAdd animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
