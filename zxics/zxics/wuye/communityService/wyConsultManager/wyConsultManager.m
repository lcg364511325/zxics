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
#import "wyCManagerDetail.h"

@interface wyConsultManager ()

@end

@implementation wyConsultManager

@synthesize suTView;
@synthesize type;
@synthesize undealBtn;
@synthesize dealBtn;
@synthesize somedealBtn;
@synthesize notDealBtn;

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
    btnlist=[NSArray arrayWithObjects:undealBtn,dealBtn,somedealBtn,notDealBtn, nil];
    
    if ([type isEqualToString:@"consult"]) {
        [self.UINavigationItem setTitle:@"咨询管理"];
    }else{
        [self.UINavigationItem setTitle:@"投诉管理"];
    }
    
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
    
    cell.readBtn.hidden=YES;
    cell.updatebtn.hidden=YES;
    
    //标题
    NSString *titleStr=[_Commons turnNullValue:@"title" Object:sudetail];
    cell.nameLabel.text=titleStr;
    
    //审核状态
    NSString *approverflag=[_Commons turnNullValue:@"approverflag" Object:sudetail];
    if ([approverflag isEqualToString:@"0"]) {
        cell.infoLabel.text=@"发布时间：未审核";
    }else if ([approverflag isEqualToString:@"1"]){
        cell.infoLabel.text=@"发布时间：审核通过";
    }
    else{
        cell.infoLabel.text=@"发布时间：审核不通过";
    }
    
    //发布时间
    NSString *send_date=[_Commons turnNullValue:@"send_date" Object:sudetail];
    send_date=[_Commons stringtoDateforsecond:send_date];
    cell.timeLabel.text=[NSString stringWithFormat:@"发布时间：%@",send_date];
    
    //按钮处理状态
    NSString *assessStr=[_Commons turnNullValue:@"assess" Object:sudetail];
    if([assessStr isEqualToString:@""] || !assessStr){
        
        NSString *pid=[_Commons turnNullValue:@"id" Object:sudetail];
        cell.deleteBtn.tag=[pid intValue];
        [cell.deleteBtn setTitle:@"审核" forState:UIControlStateNormal];
        [cell.deleteBtn addTarget:self action:@selector(changeDealFlag:) forControlEvents:UIControlEventTouchDown];
    }else{
        cell.deleteBtn.hidden=YES;
    }
    
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
    NSDictionary *sudetail = [list objectAtIndex:[indexPath row]];
    wyCManagerDetail *_wuyeNoticeDetail=[[wyCManagerDetail alloc]init];
    NSString *caid=[_Commons turnNullValue:@"id" Object:sudetail];
    _wuyeNoticeDetail.cid=caid;
    _wuyeNoticeDetail.type=type;
    [self.navigationController pushViewController:_wuyeNoticeDetail animated:NO];
}

-(void)replyMessage:(UIButton *)btn
{
    wyCManagerDetail *_wuyeNoticeDetail=[[wyCManagerDetail alloc]init];
    NSString *caid=[NSString stringWithFormat:@"%d",btn.tag];
    _wuyeNoticeDetail.cid=caid;
    _wuyeNoticeDetail.type=type;
    [self.navigationController pushViewController:_wuyeNoticeDetail animated:NO];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    threeLineTwoBtnCell *cell = (threeLineTwoBtnCell *)[self tableView:suTView cellForRowAtIndexPath:indexPath];
    CGFloat height=cell.borderImage.frame.size.height+6;
    return height;
}

-(IBAction)changeFlag:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    for (UIButton *mybtn in btnlist) {
        if (mybtn==btn) {
            [mybtn setBackgroundImage:[UIImage imageNamed:@"selectedBtn"] forState:UIControlStateNormal];
        }else{
            [mybtn setBackgroundImage:[UIImage imageNamed:@"unseletedBtn"] forState:UIControlStateNormal];
        }
    }
    flag=[NSString stringWithFormat:@"%d",btn.tag];
    [list removeAllObjects];
    [self loaddata];
    [suTView reloadData];
}


-(void)changeDealFlag:(UIButton *)btn
{
    mid=btn.tag;
    NSString *infoStr=@"请选择处理状态";
    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:infoStr delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"处理完成",@"部分处理",@"无法处理", nil];
    [alter show];
}

//alertview响应事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex!=0) {
        
        NSMutableDictionary * pw = [NSMutableDictionary dictionaryWithCapacity:5];
        pw=[DataService PostDataService:[NSString stringWithFormat:@"%@api/upAppDealDeleteReplyFix",domainser] postDatas:[NSString stringWithFormat:@"type=1&id=%d&flag=%d",mid,buttonIndex]];
        NSString *rowString =[pw objectForKey:@"info"];
        
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alter show];
        
        [list removeAllObjects];
        [self loaddata];
        [suTView reloadData];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
