//
//  myappraise.m
//  zxics
//
//  Created by johnson on 14-8-8.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "myappraise.h"
#import "AppDelegate.h"
#import "DataService.h"
#import "MJRefresh.h"
#import "ImageCacher.h"

@interface myappraise ()

@end

@implementation myappraise

@synthesize assessTView;
@synthesize completeButton;

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
    
    searchurl=@"mobileGoodsEvaluate";
    page=1;
    list=[[NSMutableArray alloc]initWithCapacity:5];
    btnlist=[[NSMutableArray alloc]initWithCapacity:5];
    [btnlist addObject:completeButton];
    completeButton.backgroundColor=[UIColor lightGrayColor];
    
    [self loaddata];
    
    //上拉刷新下拉加载提示
    [assessTView addHeaderWithCallback:^{
        [list removeAllObjects];
        page=1;
        [self loaddata];
        [assessTView reloadData];
        [assessTView headerEndRefreshing];}];
    [assessTView addFooterWithCallback:^{
        page=page+1;
        [self loaddata];
        [assessTView reloadData];
        [assessTView footerEndRefreshing];
    }];
}

-(void)loaddata
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    NSMutableDictionary * assess = [NSMutableDictionary dictionaryWithCapacity:5];
    assess=[DataService PostDataService:[NSString stringWithFormat:@"%@api/%@",domainser,searchurl] postDatas:[NSString stringWithFormat:@"account=%@",myDelegate.entityl.account] forPage:page forPageSize:10];
    NSArray *applist=[assess objectForKey:@"datas"];
    [list addObjectsFromArray:applist];
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
    
    static NSString *TableSampleIdentifier = @"myappraiseCell";
    
    myappraiseCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        NSArray * nib=[[NSBundle mainBundle]loadNibNamed:@"myappraiseCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    NSDictionary *appdetail = [list objectAtIndex:[indexPath row]];
    
    cell.titleLabel.text=[NSString stringWithFormat:@"%@",[appdetail objectForKey:@"name"]];
    cell.detailLabel.text=[NSString stringWithFormat:@"%@",[appdetail objectForKey:@"comments"]];
    cell.appLabel.text=[NSString stringWithFormat:@"%@",[appdetail objectForKey:@"star"]];
    
    
    NSURL *imgUrl=[NSURL URLWithString:[NSString stringWithFormat:@"%@",[appdetail objectForKey:@"goodsImg"]]];
    if (hasCachedImage(imgUrl)) {
        [cell.logoimage setImage:[UIImage imageWithContentsOfFile:pathForURL(imgUrl)]];
    }else{
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:imgUrl,@"url",cell.logoimage,@"imageView",nil];
        [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
    }
    
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(IBAction)search:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    NSInteger btntag=btn.tag;
    [btnlist addObject:btn];
    if ([btnlist count]>2) {
        [btnlist removeObjectAtIndex:0];
        UIButton *beforebtn=[btnlist objectAtIndex:0];
        beforebtn.backgroundColor=[UIColor darkGrayColor];
    }else if ([btnlist count]==2)
    {
        UIButton *beforebtn=[btnlist objectAtIndex:0];
        beforebtn.backgroundColor=[UIColor darkGrayColor];
    }
    btn.backgroundColor=[UIColor lightGrayColor];
    if (btntag==0) {
        searchurl=@"mobileGoodsEvaluate";
    }else if (btntag==1)
    {
        searchurl=@"mobileGoodsNotEvaluate";
    }
    [list removeAllObjects];
    page=1;
    [self loaddata];
    [assessTView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
