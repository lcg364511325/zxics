//
//  cplist.m
//  zxics
//
//  Created by johnson on 14-8-5.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "cplist.h"
#import "DataService.h"
#import "AppDelegate.h"
#import "Commons.h"

@interface cplist ()

@end

@implementation cplist

@synthesize btntag;
@synthesize cpTView;

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
    
    NSInteger selecttype=[btntag integerValue];
    if (selecttype==0) {
        self.UINavigationItem.title=@"社区活动";
        cid=@"79";
    }else if (selecttype==1)
    {
        self.UINavigationItem.title=@"物业通知";
        cid=@"80";
    }
    
    //加载数据
    [self loaddata];
    
    //上拉刷新下拉加载提示
    [cpTView addHeaderWithCallback:^{
        [list removeAllObjects];
        page=1;
        [self loaddata];
        [cpTView reloadData];
        [cpTView headerEndRefreshing];}];
    [cpTView addFooterWithCallback:^{
        page=page+1;
        [self loaddata];
        [cpTView reloadData];
        [cpTView footerEndRefreshing];
    }];
}

//加载数据
-(void)loaddata
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    NSMutableDictionary * cp = [NSMutableDictionary dictionaryWithCapacity:5];
    cp=[DataService PostDataService:[NSString stringWithFormat:@"%@api/findProblem",domainser] postDatas:[NSString stringWithFormat:@"categoryId=%@&communityid=%@",cid,myDelegate.entityl.communityid] forPage:page forPageSize:10];
    NSArray *array=[cp objectForKey:@"datas"];
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
    
    static NSString *TableSampleIdentifier = @"cplistCell";
    
    cplistCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        NSArray * nib=[[NSBundle mainBundle]loadNibNamed:@"cplistCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    NSDictionary *cpdetail = [list objectAtIndex:[indexPath row]];
    
    Commons *_commons=[[Commons alloc]init];
    cell.dataLabel.text=[_commons stringtoDate:[cpdetail objectForKey:@"createDate"]];
    cell.titleLabel.text=[cpdetail objectForKey:@"title"];
    
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
    cpdetali *_cpdetali=[[cpdetali alloc]init];
    NSDictionary *cpdetail = [list objectAtIndex:[indexPath row]];
    _cpdetali.cid=cid;
    _cpdetali.cpd=cpdetail;
    [self.navigationController pushViewController:_cpdetali animated:NO];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
