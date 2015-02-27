//
//  rentorshelllist.m
//  zxics
//
//  Created by johnson on 14-8-11.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "rentorshelllist.h"
#import "rentorshellCell.h"
#import "rentorshellDetail.h"
#import "DataService.h"
#import "ImageCacher.h"

@interface rentorshelllist ()

@end

@implementation rentorshelllist

@synthesize btntag;
@synthesize rsTView;

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
        self.UINavigationItem.title=@"物业出售";
    }else if (selecttype==1)
    {
        self.UINavigationItem.title=@"物业出租";
    }
    
    //加载数据
    [self loaddata];
    
    //上拉刷新下拉加载提示
    [rsTView addHeaderWithCallback:^{
        [list removeAllObjects];
        page=1;
        [self loaddata];
        [rsTView reloadData];
        [rsTView headerEndRefreshing];}];
    [rsTView addFooterWithCallback:^{
        page=page+1;
        [self loaddata];
        [rsTView reloadData];
        [rsTView footerEndRefreshing];
    }];
}

//加载数据
-(void)loaddata
{
    NSMutableDictionary * rs = [NSMutableDictionary dictionaryWithCapacity:5];
    rs=[DataService PostDataService:[NSString stringWithFormat:@"%@api/mobileTenementsSell",domainser] postDatas:[NSString stringWithFormat:@"subtype=%@",btntag] forPage:page forPageSize:10];
    NSArray *rslist=[rs objectForKey:@"datas"];
    [list addObjectsFromArray:rslist];
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
    
    static NSString *TableSampleIdentifier = @"rentorshellCell";
    
    rentorshellCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        NSArray * nib=[[NSBundle mainBundle]loadNibNamed:@"rentorshellCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    NSDictionary *rsdetail = [list objectAtIndex:[indexPath row]];
    
    cell.titleLabel.text=[rsdetail objectForKey:@"title"];
    
    id addr=[rsdetail objectForKey:@"homeaddress"];
    if (addr!=[NSNull null]) {
        cell.addrLabel.text=[NSString stringWithFormat:@"地址：%@",[rsdetail objectForKey:@"homeaddress"]];
    }
    
    id doorsi=[rsdetail objectForKey:@"doorsi"];
    id doorti=[rsdetail objectForKey:@"doorti"];
    id doorwa=[rsdetail objectForKey:@"doorwa"];
    if (doorwa!=[NSNull null] && doorti!=[NSNull null] && doorsi!=[NSNull null]) {
        cell.detailLabel.text=[NSString stringWithFormat:@"%@室%@厅%@卫",doorsi,doorti,doorwa];
    }
    
    if ([btntag isEqualToString:@"0"]) {
        cell.moneyLabel.text=[NSString stringWithFormat:@"%@万元",[rsdetail objectForKey:@"rent"]];
    }else
    {
        cell.moneyLabel.text=[NSString stringWithFormat:@"%@元/月",[rsdetail objectForKey:@"rent"]];
    }
    
    NSString *url=[NSString stringWithFormat:@"%@%@",domainser,[rsdetail objectForKey:@"headurl"]];
    NSURL *imgUrl=[NSURL URLWithString:url];
    if (hasCachedImage(imgUrl)) {
        [cell.logo setImage:[UIImage imageWithContentsOfFile:pathForURL(imgUrl)]];
    }else{
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:imgUrl,@"url",cell.logo,@"imageView",nil];
        [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
    }
    
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
    rentorshellDetail *_rentorshellDetail=[[rentorshellDetail alloc]init];
    NSDictionary *rsdetail = [list objectAtIndex:[indexPath row]];
    _rentorshellDetail.rsd=rsdetail;
    _rentorshellDetail.btntag=btntag;
    [self.navigationController pushViewController:_rentorshellDetail animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
