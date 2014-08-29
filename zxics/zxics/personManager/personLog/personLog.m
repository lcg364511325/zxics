//
//  personLog.m
//  zxics
//
//  Created by johnson on 14-8-7.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "personLog.h"
#import "AppDelegate.h"
#import "DataService.h"
#import "Commons.h"

@interface personLog ()

@end

@implementation personLog

@synthesize UINavigationBar;
@synthesize personlogTView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)goback:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.UINavigationBar setBarTintColor:[UIColor colorWithRed:7.0/255.0 green:3.0/255.0 blue:164.0/255.0 alpha:1]];//设置bar背景颜色
    
    page=1;
    list=[[NSMutableArray alloc]initWithCapacity:1];
    
    //加载数据
    [self loaddata];
    
    //上拉刷新下拉加载提示
    [personlogTView addHeaderWithCallback:^{
        [list removeAllObjects];
        page=1;
        [self loaddata];
        [personlogTView reloadData];
        [personlogTView headerEndRefreshing];}];
    [personlogTView addFooterWithCallback:^{
        page=page+1;
        [self loaddata];
        [personlogTView reloadData];
        [personlogTView footerEndRefreshing];
    }];
}

//加载数据
-(void)loaddata
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    NSMutableDictionary * perlog = [NSMutableDictionary dictionaryWithCapacity:5];
    perlog=[DataService PostDataService:[NSString stringWithFormat:@"%@api/findLog",domainser] postDatas:[NSString stringWithFormat:@"account=%@",myDelegate.entityl.account] forPage:page forPageSize:10];
    NSArray *perloglist=[perlog objectForKey:@"datas"];
    [list addObjectsFromArray:perloglist];
}


//初始化tableview数据
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [list count];
    //只有一组，数组数即为行数。
}

// tableview数据显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"personlogCellTableViewCell";
    
    personlogCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        NSArray * nib=[[NSBundle mainBundle]loadNibNamed:@"personlogCellTableViewCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    
     NSDictionary *perlogdetail = [list objectAtIndex:[indexPath row]];
    cell.detailLabel.text=[perlogdetail objectForKey:@"datail"];
    NSString *type=[NSString stringWithFormat:@"%@",[perlogdetail objectForKey:@"type"]];
    if ([type isEqualToString:@"1"]) {
        cell.typeLabel.text=@"前台";
    }else{
        cell.typeLabel.text=@"后台";
    }
    
    NSString *usertype=[NSString stringWithFormat:@"%@",[perlogdetail objectForKey:@"usertype"]];
    if ([usertype isEqualToString:@"0"]) {
        cell.personLabel.text=@"管理员";
    }else{
        cell.personLabel.text=@"客户";
    }
    
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    cell.accountLabel.text=myDelegate.entityl.account;
    
    Commons *_Commons=[[Commons alloc]init];
    NSString *timestr=[NSString stringWithFormat:@"%@",[perlogdetail objectForKey:@"create_time"]];
    cell.dateLabel.text=[_Commons stringtoDate:timestr];
    
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    personLogDetail *_personLogDetail=[[personLogDetail alloc]init];
    NSDictionary *perlogdetail = [list objectAtIndex:[indexPath row]];
    _personLogDetail.psd=perlogdetail;
    [self.navigationController pushViewController:_personLogDetail animated:NO];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
