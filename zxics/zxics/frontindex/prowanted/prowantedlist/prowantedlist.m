//
//  prowantedlist.m
//  zxics
//
//  Created by johnson on 14-8-11.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "prowantedlist.h"
#import "prowanted.h"
#import "prowantedDetail.h"
#import "DataService.h"
#import "Commons.h"
#import "addproWanted.h"

@interface prowantedlist ()

@end

@implementation prowantedlist

@synthesize pwTView;

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
    [self.UINavigationBar setBackgroundImage:[UIImage imageNamed:@"logo_bg"] forBarMetrics:UIBarMetricsDefault];
    
    page=1;
    list=[[NSMutableArray alloc]initWithCapacity:5];
    
    //加载数据
    [self loaddata];
    
    //上拉刷新下拉加载提示
    [pwTView addHeaderWithCallback:^{
        [list removeAllObjects];
        page=1;
        [self loaddata];
        [pwTView reloadData];
        [pwTView headerEndRefreshing];}];
    [pwTView addFooterWithCallback:^{
        page=page+1;
        [self loaddata];
        [pwTView reloadData];
        [pwTView footerEndRefreshing];
    }];
}

-(void)loaddata
{
    NSMutableDictionary * pw = [NSMutableDictionary dictionaryWithCapacity:5];
    pw=[DataService PostDataService:[NSString stringWithFormat:@"%@api/mobileNeedRentAndBuy",domainser] postDatas:nil forPage:page forPageSize:10];
    NSArray *pwlist=[pw objectForKey:@"datas"];
    [list addObjectsFromArray:pwlist];
}


//添加页面跳转
-(IBAction)addprowanted:(id)sender
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    if (myDelegate.entityl) {
        
        addproWanted *_addproWanted=[[addproWanted alloc]init];
        [self.navigationController pushViewController:_addproWanted animated:NO];
    }else{
        NSString *rowString =@"请先登录！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
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
    
    static NSString *TableSampleIdentifier = @"prowanted";
    
    prowanted *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        NSArray * nib=[[NSBundle mainBundle]loadNibNamed:@"prowanted" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    NSDictionary *pwdetail = [list objectAtIndex:[indexPath row]];
    cell.titleLabel.text=[pwdetail objectForKey:@"title"];
    Commons *_Commons=[[Commons alloc]init];
    NSString *timestr=[NSString stringWithFormat:@"%@",[pwdetail objectForKey:@"createtime"]];
    cell.dateLabel.text=[_Commons stringtoDate:timestr];
    
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
    prowantedDetail *_prowantedDetail=[[prowantedDetail alloc]init];
    NSDictionary *pwdetail = [list objectAtIndex:[indexPath row]];
    _prowantedDetail.pwd=pwdetail;
    [self.navigationController pushViewController:_prowantedDetail animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
