//
//  conservationPeople.m
//  zxics
//
//  Created by johnson on 15-3-9.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import "conservationPeople.h"
#import "AppDelegate.h"
#import "Commons.h"
#import "DataService.h"
#import "threeLineTwoBtnCell.h"
#import "conservationPeopleDetail.h"
#import "editConservationPeople.h"
#import "conservationSearch.h"

@interface conservationPeople ()

@end

@implementation conservationPeople

@synthesize suTView;

-(void)viewWillAppear:(BOOL)animated
{
    if (isfirst==1) {
        isfirst=0;
    }else{
        [list removeAllObjects];
        page=0;
        [self loaddata];
        [suTView reloadData];
    }
}

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
    
    UIBarButtonItem *firstButton = [[UIBarButtonItem alloc] initWithTitle:@"查询" style:UIBarButtonItemStylePlain target:self action:@selector(setSearchValue)];
    UIBarButtonItem *secondButton = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addConservationPeople)];
    
    [self.UINavigationItem setRightBarButtonItems:[NSArray arrayWithObjects:firstButton, secondButton, nil]];
    
    isfirst=1;
    page=0;
    username=@"";
    userphone=@"";
    blockcode=@"";
    stime=@"";
    etime=@"";
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
    pw=[DataService PostDataService:[NSString stringWithFormat:@"%@api/findPopulationList",domainser] postDatas:[NSString stringWithFormat:@"communityids=%@&name=%@&blockcode=%@&phone=%@&stime=%@&etime=%@",myDelegate.entityl.communityid,username,blockcode,userphone,stime,etime] forPage:page forPageSize:10];
    NSArray *pwlist=[pw objectForKey:@"datas"];
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
    
    static NSString *TableSampleIdentifier = @"threeLineTwoBtnCell";
    
    threeLineTwoBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        NSArray * nib=[[NSBundle mainBundle]loadNibNamed:@"threeLineTwoBtnCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    NSDictionary *sudetail = [list objectAtIndex:[indexPath row]];
    Commons *_Commons=[[Commons alloc]init];
    
    //社区
    NSString *titleStr=[_Commons turnNullValue:@"cname" Object:sudetail];
    cell.nameLabel.text=titleStr;
    
    //姓名
    NSString *createTime=[_Commons turnNullValue:@"pname" Object:sudetail];
    if (![createTime isEqualToString:@""]) {
        cell.infoLabel.text=[NSString stringWithFormat:@"姓名：%@",createTime];
    }else{
        cell.infoLabel.text=@"姓名：";
    }
    
    //业主卡号
    NSString *flag=[_Commons turnNullValue:@"blockcode" Object:sudetail];
    if (![flag isEqualToString:@""]) {
        cell.timeLabel.text=[NSString stringWithFormat:@"业主卡号：%@",flag];
    }else{
        cell.timeLabel.text=@"业主卡号：";
    }
    cell.readBtn.hidden=YES;
    
    //修改
    NSString *catid=[_Commons turnNullValue:@"pid" Object:sudetail];
    cell.deleteBtn.tag=[catid integerValue];
    [cell.deleteBtn setTitle:@"修改" forState:UIControlStateNormal];
    [cell.deleteBtn addTarget:self action:@selector(updataConservationPeople:) forControlEvents:UIControlEventTouchDown];
    
    //删除
    cell.updatebtn.tag=[indexPath row];
    [cell.updatebtn setTitle:@"删除" forState:UIControlStateNormal];
    [cell.updatebtn addTarget:self action:@selector(deleteflag:) forControlEvents:UIControlEventTouchDown];
    
    int y=(cell.frame.size.height-cell.nameLabel.frame.size.height*3-4)/2;
    int btny=(cell.frame.size.height-cell.nameLabel.frame.size.height*2-4)/2;
    int x=cell.nameLabel.frame.origin.x;
    int btnx=cell.readBtn.frame.origin.x;
    int width=cell.nameLabel.frame.size.width;
    int btnwidth=cell.readBtn.frame.size.width;
    int height=cell.nameLabel.frame.size.height;
    
    cell.nameLabel.frame=CGRectMake(x, y, width, height);
    cell.deleteBtn.frame=CGRectMake(btnx, btny, btnwidth, height);
    
    cell.infoLabel.frame=CGRectMake(x, y+height+2, width, height);
    cell.updatebtn.frame=CGRectMake(btnx, btny+height+2, btnwidth, height);
    
    cell.timeLabel.frame=CGRectMake(x, y+height*2+4, width, height);
    
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
    Commons *_Commons=[[Commons alloc]init];
    NSDictionary *sudetail = [list objectAtIndex:[indexPath row]];
    conservationPeopleDetail *_wuyeNoticeDetail=[[conservationPeopleDetail alloc]init];
    NSString *caid=[_Commons turnNullValue:@"pid" Object:sudetail];
    _wuyeNoticeDetail.uid=caid;
    [self.navigationController pushViewController:_wuyeNoticeDetail animated:NO];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    threeLineTwoBtnCell *cell = (threeLineTwoBtnCell *)[self tableView:suTView cellForRowAtIndexPath:indexPath];
    CGFloat height=cell.borderImage.frame.size.height+6;
    return height;
}


//添加常住人口
-(void)addConservationPeople
{
    editConservationPeople *_editConservationPeople=[[editConservationPeople alloc]init];
    [self.navigationController pushViewController:_editConservationPeople animated:NO];
}

//修改常住人口
-(void)updataConservationPeople:(UIButton *)btn
{
    editConservationPeople *_editConservationPeople=[[editConservationPeople alloc]init];
    _editConservationPeople.uid=[NSString stringWithFormat:@"%d",btn.tag];
    [self.navigationController pushViewController:_editConservationPeople animated:NO];
}


//搜索条件页面跳转
-(void)setSearchValue
{
    conservationSearch *_conservationSearch=[[conservationSearch alloc]init];
    _conservationSearch.delegate=self;
    [self.navigationController pushViewController:_conservationSearch animated:NO];
}

//接受搜索条件
-(void)passDictionaryValue:(NSDictionary *)value key:(NSDictionary *)key tag:(NSInteger)tag
{
    Commons *_Commons=[[Commons alloc]init];
    username=[_Commons turnNullValue:@"name" Object:value];
    userphone=[_Commons turnNullValue:@"mobile" Object:value];
    blockcode=[_Commons turnNullValue:@"cardno" Object:value];
    stime=[_Commons turnNullValue:@"stime" Object:value];
    etime=[_Commons turnNullValue:@"etime" Object:value];
    [list removeAllObjects];
    [self loaddata];
    [suTView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
