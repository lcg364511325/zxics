//
//  download.m
//  zxics
//
//  Created by johnson on 14-8-11.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "download.h"
#import "MJRefresh.h"
#import "DataService.h"
#import "AppDelegate.h"
#import "ImageCacher.h"

@interface download ()

@end

@implementation download

@synthesize downloadTView;

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
    cid=@"57";
    page=1;
    list=[[NSMutableArray alloc]initWithCapacity:5];
    
    //加载数据
    [self loaddata];
    
    //上拉刷新下拉加载提示
    [downloadTView addHeaderWithCallback:^{
        [list removeAllObjects];
        page=1;
        [self loaddata];
        [downloadTView reloadData];
        [downloadTView headerEndRefreshing];}];
    [downloadTView addFooterWithCallback:^{
        page=page+1;
        [self loaddata];
        [downloadTView reloadData];
        [downloadTView footerEndRefreshing];
    }];
}

//查询数据
-(void)loaddata
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    NSMutableDictionary * down = [NSMutableDictionary dictionaryWithCapacity:5];
    down=[DataService PostDataService:[NSString stringWithFormat:@"%@api/softwareDown",domainser] postDatas:[NSString stringWithFormat:@"communityid=%@&categoryId=%@",myDelegate.entityl.communityid,cid] forPage:page forPageSize:10];
    NSArray *downlist=[down objectForKey:@"datas"];
    [list addObjectsFromArray:downlist];
}

//切换类型
-(IBAction)changetype:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    NSInteger btntag=btn.tag;
    cid=[NSString stringWithFormat:@"%d",btntag];
    [list removeAllObjects];
    page=1;
    [self loaddata];
    [downloadTView reloadData];
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
    
    static NSString *TableSampleIdentifier = @"downloadCell";
    
    downloadCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        NSArray * nib=[[NSBundle mainBundle]loadNibNamed:@"downloadCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    
    NSDictionary *Projectdownload = [list objectAtIndex:[indexPath row]];
    
    cell.titleLabel.text=[Projectdownload objectForKey:@"title"];
    cell.sizeLabel.text=[NSString stringWithFormat:@"%@MB",[Projectdownload objectForKey:@"filesize"]];
    
    cell.downloadButton.tag=[indexPath row];
    [cell.downloadButton addTarget:self action:@selector(downloadapp:) forControlEvents:UIControlEventTouchDown];
    
    NSString *url=[NSString stringWithFormat:@"%@%@",domainser,[Projectdownload objectForKey:@"headurl"]];
    NSURL *imgUrl=[NSURL URLWithString:url];
    if (hasCachedImage(imgUrl)) {
        [cell.applogo setImage:[UIImage imageWithContentsOfFile:pathForURL(imgUrl)]];
    }else{
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:imgUrl,@"url",cell.applogo,@"imageView",nil];
        [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
    }
    
    
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)downloadapp:(UIButton *)button
{
    NSDictionary *Projectdownload = [list objectAtIndex:button.tag];
    NSString *url=[NSString stringWithFormat:@"%@f/downLoadFile.shtml?fileName=%@",domainser,[Projectdownload objectForKey:@"filepath"]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
