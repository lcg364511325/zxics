//
//  shopMlist.m
//  zxics
//
//  Created by johnson on 15-3-10.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import "shopMlist.h"
#import "DataService.h"
#import "AppDelegate.h"
#import "Commons.h"
#import "threeLineTwoBtnCell.h"
#import "shopMlistDetail.h"

@interface shopMlist ()

@end

@implementation shopMlist

@synthesize suTView;

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
    pw=[DataService PostDataService:[NSString stringWithFormat:@"%@api/findShopMList",domainser] postDatas:[NSString stringWithFormat:@"orgId=%@",myDelegate.entityl.orgId] forPage:page forPageSize:10];
    NSArray *pwlist=[pw objectForKey:@"data"];
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
    NSString *createTime=[_Commons turnNullValue:@"Send_date" Object:sudetail];
    if (![createTime isEqualToString:@""]) {
        cell.infoLabel.text=[NSString stringWithFormat:@"发布时间：%@",[_Commons stringtoDateforsecond:createTime]];
    }else{
        cell.infoLabel.text=@"发布时间：";
    }
    
    //审核状态
    NSString *flag=[_Commons turnNullValue:@"approverflag" Object:sudetail];
    if ([flag isEqualToString:@"0"]) {
        cell.timeLabel.text=@"审核状态：未审核";
    }else if ([flag isEqualToString:@"1"]){
        cell.timeLabel.text=@"审核状态：已审核";
    }else{
        cell.timeLabel.text=@"审核状态：审核不通过";
    }
    
    cell.readBtn.hidden=YES;
    
    if ([flag isEqualToString:@"0"]) {
        //审核
        cell.deleteBtn.tag=[indexPath row];
        [cell.deleteBtn setTitle:@"审核" forState:UIControlStateNormal];
        [cell.deleteBtn addTarget:self action:@selector(Audit:) forControlEvents:UIControlEventTouchDown];
        
        //删除
        cell.updatebtn.tag=[indexPath row];
        [cell.updatebtn setTitle:@"删除" forState:UIControlStateNormal];
        [cell.updatebtn addTarget:self action:@selector(deleteInfo:) forControlEvents:UIControlEventTouchDown];
        
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
    }else{
        cell.deleteBtn.hidden=YES;
        
        //删除
        cell.updatebtn.tag=[indexPath row];
        [cell.updatebtn setTitle:@"删除" forState:UIControlStateNormal];
        [cell.updatebtn addTarget:self action:@selector(deleteInfo:) forControlEvents:UIControlEventTouchDown];
        
        int y=(cell.frame.size.height-cell.nameLabel.frame.size.height*3-4)/2;
        int btny=(cell.frame.size.height-cell.nameLabel.frame.size.height)/2;
        int x=cell.nameLabel.frame.origin.x;
        int btnx=cell.readBtn.frame.origin.x;
        int width=cell.nameLabel.frame.size.width;
        int btnwidth=cell.readBtn.frame.size.width;
        int height=cell.nameLabel.frame.size.height;
        
        cell.nameLabel.frame=CGRectMake(x, y, width, height);
        
        cell.infoLabel.frame=CGRectMake(x, y+height+2, width, height);
        cell.updatebtn.frame=CGRectMake(btnx, btny, btnwidth, height);
        
        cell.timeLabel.frame=CGRectMake(x, y+height*2+4, width, height);

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
    Commons *_Commons=[[Commons alloc]init];
    NSDictionary *sudetail = [list objectAtIndex:[indexPath row]];
    shopMlistDetail *_wuyeNoticeDetail=[[shopMlistDetail alloc]init];
    NSString *caid=[_Commons turnNullValue:@"id" Object:sudetail];
    _wuyeNoticeDetail.pid=caid;
    [self.navigationController pushViewController:_wuyeNoticeDetail animated:NO];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    threeLineTwoBtnCell *cell = (threeLineTwoBtnCell *)[self tableView:suTView cellForRowAtIndexPath:indexPath];
    CGFloat height=cell.borderImage.frame.size.height+6;
    return height;
}

-(void)Audit:(UIButton *)btn
{
    Commons *_Commons=[[Commons alloc]init];
    NSDictionary *sudetail = [list objectAtIndex:btn.tag];
    delfag=[_Commons turnNullValue:@"approverflag" Object:sudetail];
    NSString *title=[_Commons turnNullValue:@"title" Object:sudetail];
    uid=[_Commons turnNullValue:@"id" Object:sudetail];
    type=@"0";
    NSString *infoStr=@"";
    if([delfag isEqualToString:@"0"])
    {
        infoStr=[NSString stringWithFormat:@"是否确定审核：%@",title];
    }else if([delfag isEqualToString:@"1"])
    {
        infoStr=[NSString stringWithFormat:@"是否确定反审核：%@",title];
    }else if([delfag isEqualToString:@"2"])
    {
        infoStr=[NSString stringWithFormat:@"是否确定审核：%@",title];
    }
    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:infoStr delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alter show];
    
}

-(void)deleteInfo:(UIButton *)btn
{
    Commons *_Commons=[[Commons alloc]init];
    NSDictionary *sudetail = [list objectAtIndex:btn.tag];
    delfag=@"";
    NSString *title=[_Commons turnNullValue:@"title" Object:sudetail];
    uid=[_Commons turnNullValue:@"id" Object:sudetail];
    type=@"1";
    NSString *infoStr=[NSString stringWithFormat:@"是否确定删除：%@",title];
    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:infoStr delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alter show];
}

//alertview响应事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        
        NSMutableDictionary * pw = [NSMutableDictionary dictionaryWithCapacity:5];
        pw=[DataService PostDataService:[NSString stringWithFormat:@"%@api/deappShopMList",domainser] postDatas:[NSString stringWithFormat:@"type=%@&id=%@&flag=%@",type,uid,delfag]];
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
