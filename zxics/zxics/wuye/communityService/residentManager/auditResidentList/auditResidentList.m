//
//  auditResidentList.m
//  zxics
//
//  Created by johnson on 15-3-4.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import "auditResidentList.h"
#import "Commons.h"
#import "AppDelegate.h"
#import "DataService.h"
#import "threeLineBtnCell.h"
#import "residentDetail.h"

@interface auditResidentList ()

@end

@implementation auditResidentList

@synthesize suTView;
@synthesize cid;

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
    NSMutableDictionary * pw = [NSMutableDictionary dictionaryWithCapacity:5];
    pw=[DataService PostDataService:[NSString stringWithFormat:@"%@api/findOwnerResidentAuditList",domainser] postDatas:[NSString stringWithFormat:@"communityId=%@",cid] forPage:page forPageSize:10];
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
    
    static NSString *TableSampleIdentifier = @"threeLineBtnCell";
    
    threeLineBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        NSArray * nib=[[NSBundle mainBundle]loadNibNamed:@"threeLineBtnCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    NSDictionary *sudetail = [list objectAtIndex:[indexPath row]];
    
    
    //申请人
    NSString *name=[NSString stringWithFormat:@"%@",[sudetail objectForKey:@"name"]];
    if (![name isEqualToString:@"(null)"]) {
        cell.nameLabal.text=name;
    }
    
    
    //申请加入
    NSString *mobile=[NSString stringWithFormat:@"申请加入：%@",[sudetail objectForKey:@"floorname"]];
    if (![mobile isEqualToString:@"申请加入：(null)"]) {
        cell.mobileLabel.text=mobile;
    }else{
        cell.mobileLabel.text=@"申请加入：无";
    }
    cell.mobileLabel.numberOfLines=0;
    
    Commons *_Commons=[[Commons alloc]init];
    CGSize  actualsize =[_Commons NSStringHeightForLabel:cell.mobileLabel.font width:cell.mobileLabel.frame.size.width Str:cell.mobileLabel.text];
    
    cell.mobileLabel.frame=CGRectMake(cell.mobileLabel.frame.origin.x, cell.nameLabal.frame.origin.y+18, cell.mobileLabel.frame.size.width, actualsize.height+24);
    
    
    //申请时间
    NSString *m_reg_timeStr=[self turnNullValue:@"date" Object:sudetail];
    if (![m_reg_timeStr isEqualToString:@""]) {
        cell.addrLabal.text=[_Commons stringtoDateforsecond:m_reg_timeStr];
    }
    
    cell.addrLabal.frame=CGRectMake(cell.addrLabal.frame.origin.x, cell.mobileLabel.frame.origin.y+cell.mobileLabel.frame.size.height+18-cell.addrLabal.frame.size.height, cell.addrLabal.frame.size.width, cell.addrLabal.frame.size.height);
    
    
    //审核按钮
    NSString *uid=[self turnNullValue:@"id" Object:sudetail];
    cell.deletebtn.tag=[uid intValue];
    [cell.deletebtn setTitle:@"审核" forState:UIControlStateNormal];
    [cell.deletebtn addTarget:self action:@selector(deleteResidentForCommunity:) forControlEvents:UIControlEventTouchDown];
    
    
    //设置圆角边框
    cell.borderImage.frame=CGRectMake(3, 3, cell.frame.size.width-6, cell.frame.size.height+cell.mobileLabel.frame.size.height-cell.addrLabal.frame.size.height-6);
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
    NSDictionary *sudetail = [list objectAtIndex:[indexPath row]];
    NSString *uid=[NSString stringWithFormat:@"%@",[sudetail objectForKey:@"id"]];
    residentDetail *_succourDetail=[[residentDetail alloc]init];
    _succourDetail.uid=uid;
    [self.navigationController pushViewController:_succourDetail animated:NO];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    threeLineBtnCell *cell = (threeLineBtnCell *)[self tableView:suTView cellForRowAtIndexPath:indexPath];
    CGFloat height=cell.frame.size.height+cell.mobileLabel.frame.size.height-cell.addrLabal.frame.size.height;
    return height;
}

//审核居民
-(void)deleteResidentForCommunity:(UIButton *)btn
{
    seteduid=btn.tag;
    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择是否通过审核" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",@"拒绝", nil];
    [alter show];
    
}

//alertview响应事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex!=0) {
        NSMutableDictionary * pw = [NSMutableDictionary dictionaryWithCapacity:5];
        pw=[DataService PostDataService:[NSString stringWithFormat:@"%@api/upOwnerResidentAudit",domainser] postDatas:[NSString stringWithFormat:@"flag=%d&id=%d",buttonIndex,seteduid]];
        NSString *rowString =[pw objectForKey:@"info"];
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alter show];
        [list removeAllObjects];
        [self loaddata];
        [suTView reloadData];
    }
}

-(NSString *)turnNullValue:(NSString *)key Object:(NSDictionary *)Object
{
    NSString *str=[NSString stringWithFormat:@"%@",[Object objectForKey:key]];
    if ([str isEqualToString:@"<null>"] || [str isEqualToString:@"(null)"]) {
        return @"";
    }else{
        return str;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
