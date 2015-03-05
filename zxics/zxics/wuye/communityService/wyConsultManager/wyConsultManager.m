//
//  wyConsultManager.m
//  zxics
//
//  Created by johnson on 15-3-5.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import "wyConsultManager.h"
#import "DataService.h"
#import "AppDelegate.h"
#import "Commons.h"
#import "threeLineTwoBtnCell.h"

@interface wyConsultManager ()

@end

@implementation wyConsultManager

@synthesize suTView;
@synthesize type;

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
    flag=@"0";
    page=0;
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
    pw=[DataService PostDataService:[NSString stringWithFormat:@"%@api/findReplyFixList",domainser] postDatas:[NSString stringWithFormat:@"type=%@&dealflag=%@&orgId=%@&communityIds=%@",type,flag,myDelegate.entityl.orgId,myDelegate.entityl.communityid] forPage:page forPageSize:10];
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
    
    //标题
    NSString *titleStr=[_Commons turnNullValue:@"title" Object:sudetail];
    cell.nameLabel.text=titleStr;
    
    //发布时间
    NSString *createTime=[_Commons turnNullValue:@"create_date" Object:sudetail];
    if (![createTime isEqualToString:@""]) {
        cell.infoLabel.text=[NSString stringWithFormat:@"发布时间：%@",[_Commons stringtoDateforsecond:createTime]];
    }else{
        cell.infoLabel.text=@"发布时间：";
    }
    
    //审核状态
    NSString *appflag=[_Commons turnNullValue:@"del_flag" Object:sudetail];
    if ([appflag isEqualToString:@"2"]) {
        cell.timeLabel.text=@"审核状态：未审核";
    }else if ([appflag isEqualToString:@"0"]){
        cell.timeLabel.text=@"审核状态：已审核";
    }else{
        cell.timeLabel.text=@"审核状态：已删除";
    }
    
    //审核
    cell.readBtn.tag=[indexPath row];
    [cell.readBtn setTitle:@"审核" forState:UIControlStateNormal];
    [cell.readBtn addTarget:self action:@selector(Audit:) forControlEvents:UIControlEventTouchDown];
    
    //修改
    NSString *catid=[_Commons turnNullValue:@"id" Object:sudetail];
    cell.deleteBtn.tag=[catid integerValue];
    [cell.deleteBtn setTitle:@"修改" forState:UIControlStateNormal];
    [cell.deleteBtn addTarget:self action:@selector(updatewuyeInfo:) forControlEvents:UIControlEventTouchDown];
    
    //删除
    cell.updatebtn.tag=[indexPath row];
    [cell.updatebtn setTitle:@"删除" forState:UIControlStateNormal];
    [cell.updatebtn addTarget:self action:@selector(deleteflag:) forControlEvents:UIControlEventTouchDown];
    
    int y=(cell.frame.size.height-cell.nameLabel.frame.size.height*3-4)/2;
    int x=cell.nameLabel.frame.origin.x;
    int btnx=cell.readBtn.frame.origin.x;
    int width=cell.nameLabel.frame.size.width;
    int btnwidth=cell.readBtn.frame.size.width;
    int height=cell.nameLabel.frame.size.height;
    
    cell.nameLabel.frame=CGRectMake(x, y, width, height);
    cell.readBtn.frame=CGRectMake(btnx, y, btnwidth, height);
    
    cell.infoLabel.frame=CGRectMake(x, y+height+2, width, height);
    cell.deleteBtn.frame=CGRectMake(btnx, y+height+2, btnwidth, height);
    
    cell.timeLabel.frame=CGRectMake(x, y+height*2+4, width, height);
    cell.updatebtn.frame=CGRectMake(btnx, y+height*2+4, btnwidth, height);
    
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
//    NSDictionary *sudetail = [list objectAtIndex:[indexPath row]];
//    wuyeNoticeDetail *_wuyeNoticeDetail=[[wuyeNoticeDetail alloc]init];
//    NSString *caid=[_Commons turnNullValue:@"id" Object:sudetail];
//    _wuyeNoticeDetail.cid=caid;
//    _wuyeNoticeDetail.type=cid;
//    [self.navigationController pushViewController:_wuyeNoticeDetail animated:NO];
}

-(IBAction)changeFlag:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    flag=[NSString stringWithFormat:@"%d",btn.tag];
    [list removeAllObjects];
    [self loaddata];
    [suTView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    threeLineTwoBtnCell *cell = (threeLineTwoBtnCell *)[self tableView:suTView cellForRowAtIndexPath:indexPath];
    CGFloat height=cell.borderImage.frame.size.height+6;
    return height;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
