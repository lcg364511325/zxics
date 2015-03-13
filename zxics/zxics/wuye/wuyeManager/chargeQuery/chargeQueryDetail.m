//
//  chargeQueryDetail.m
//  zxics
//
//  Created by johnson on 15-3-13.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import "chargeQueryDetail.h"
#import "DataService.h"
#include "AppDelegate.h"
#import "Commons.h"
#import "chargeCell.h"

@interface chargeQueryDetail ()

@end

@implementation chargeQueryDetail

@synthesize rdetail;
@synthesize cnoLable;
@synthesize payuserLable;
@synthesize userphoneLable;
@synthesize paydateLable;
@synthesize paytypeLable;
@synthesize paycountLable;
@synthesize floorLable;
@synthesize detailLable;
@synthesize appBtn;

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
    //注册collectionview的cell
    [self.goodscollectionview registerClass:[chargeCell class] forCellWithReuseIdentifier:@"chargeCell"];
    
    page=1;
    list=[[NSMutableArray alloc]initWithCapacity:1];
    
    //加载数据
    [self loaddata];
    
    //加载收费列表
    [self getChargeList];
    
    UIEdgeInsets edgeInsets = self.goodscollectionview.contentInset;
    BOOL bounces = self.goodscollectionview.bounces;
    
    self.goodscollectionview.contentInset = UIEdgeInsetsMake(-self.goodscollectionview.contentOffset.y, edgeInsets.left, edgeInsets.bottom, edgeInsets.right);
    self.goodscollectionview.bounces = NO;
    
    [self.goodscollectionview setPresenting:YES animated:YES completion:^(BOOL finished) {
        self.goodscollectionview.contentInset = edgeInsets;
        self.goodscollectionview.bounces = bounces;
    }];
}

-(void)loaddata
{
    Commons *_Commons=[[Commons alloc]init];
    
    
    NSString *receivecodeStr=[_Commons turnNullValue:@"receivecode" Object:rdetail];
    cnoLable.text=[NSString stringWithFormat:@"单据编号：%@",receivecodeStr];
    
    NSString *payusernameStr=[_Commons turnNullValue:@"payusername" Object:rdetail];
    payuserLable.text=[NSString stringWithFormat:@"付款人：%@",payusernameStr];
    
    NSString *payphoneStr=[_Commons turnNullValue:@"payphone" Object:rdetail];
    userphoneLable.text=[NSString stringWithFormat:@"联系方式：%@",payphoneStr];
    
    NSString *receivedateStr=[_Commons turnNullValue:@"receivedate" Object:rdetail];
    if (![receivedateStr isEqualToString:@""]) {
        receivedateStr=[_Commons stringtoDateforsecond:receivedateStr];
    }
    paydateLable.text=[NSString stringWithFormat:@"收款日期：%@",receivedateStr];
    
    NSString *typeStr=[_Commons turnNullValue:@"type" Object:rdetail];
    NSString *typeVlaue=@"";
    if ([typeStr isEqualToString:@"1"]) {
        typeVlaue=@"现金";
    }else if([typeStr isEqualToString:@"2"])
    {
        typeVlaue=@"转账";
    }else if([typeStr isEqualToString:@"3"])
    {
        typeVlaue=@"一卡通";
    }else{
        typeVlaue=@"其他";
    }
    paytypeLable.text=[NSString stringWithFormat:@"付款方式：%@",typeVlaue];
    
    NSString *chargecountStr=[_Commons turnNullValue:@"chargecount" Object:rdetail];
    paycountLable.text=[NSString stringWithFormat:@"总金额：%@",chargecountStr];
    
    NSString *nameStr=[_Commons turnNullValue:@"name" Object:rdetail];
    floorLable.text=[NSString stringWithFormat:@"选择楼盘：%@",nameStr];
    
    NSString *commentsStr=[_Commons turnNullValue:@"comments" Object:rdetail];
    CGSize commentsh=[_Commons NSStringHeightForLabel:detailLable.font width:detailLable.frame.size.width Str:[NSString stringWithFormat:@"说明：%@",commentsStr]];
    detailLable.text=[NSString stringWithFormat:@"说明：%@",commentsStr];
    detailLable.numberOfLines=0;
    detailLable.frame=CGRectMake(detailLable.frame.origin.x, detailLable.frame.origin.y, detailLable.frame.size.width, commentsh.height+24);
    
    NSString *approverflagStr=[_Commons turnNullValue:@"approverflag" Object:rdetail];
    if ([approverflagStr isEqualToString:@"0"]) {
        self.goodscollectionview.frame=CGRectMake(self.goodscollectionview.frame.origin.x, self.goodscollectionview.frame.origin.y, self.goodscollectionview.frame.size.width, appBtn.frame.origin.y-self.goodscollectionview.frame.origin.y-2);
    }
    
    
}

-(IBAction)goback:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)getChargeList
{
    Commons *_Commons=[[Commons alloc]init];
    NSMutableDictionary * gds = [NSMutableDictionary dictionaryWithCapacity:5];
    gds=[DataService PostDataService:[NSString stringWithFormat:@"%@api/getChargePlanDetail",domainser] postDatas:[NSString stringWithFormat:@"key=wjsnmnb&sfid=%@",[_Commons turnNullValue:@"id" Object:rdetail]] ];
    NSArray *gdslist=[gds objectForKey:@"datas"];
    [list addObjectsFromArray:gdslist];
}

//搜索结果数目
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [list count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    chargeCell *cell = (chargeCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"chargeCell" forIndexPath:indexPath];
    
    Commons *_Commons=[[Commons alloc]init];
    
    NSDictionary *gdsdetail = [list objectAtIndex:[indexPath row]];
    
    cell.titleLable.text=[NSString stringWithFormat:@"费用%d",[indexPath row]+1];
    
    NSString *typeStr=[_Commons turnNullValue:@"pname" Object:gdsdetail];
    cell.typeLable.text=[NSString stringWithFormat:@"类型：%@",typeStr];
    
    NSString *datetypeStr=[_Commons turnNullValue:@"datetype" Object:gdsdetail];
    NSString *datetypeValue=@"";
    if ([datetypeStr isEqualToString:@"0"]) {
        datetypeValue=@"次";
    }else if ([datetypeStr isEqualToString:@"1"])
    {
        datetypeValue=@"日";
    }else if ([datetypeStr isEqualToString:@"2"])
    {
        datetypeValue=@"月";
    }else if ([datetypeStr isEqualToString:@"3"])
    {
        datetypeValue=@"季";
    }else if ([datetypeStr isEqualToString:@"4"])
    {
        datetypeValue=@"年";
    }else{
        datetypeValue=@"未知";
    }
    cell.timetypeLable.text=[NSString stringWithFormat:@"时间类型：%@",datetypeValue];
    
    NSString *starttimeStr=[_Commons turnNullValue:@"starttime" Object:gdsdetail];
    if (![starttimeStr isEqualToString:@""]) {
        starttimeStr=[_Commons stringtoDateforsecond:starttimeStr];
    }
    cell.stimeLable.text=[NSString stringWithFormat:@"开始时间：%@",starttimeStr];
    
    NSString *endtimeStr=[_Commons turnNullValue:@"endtime" Object:gdsdetail];
    if (![endtimeStr isEqualToString:@""]) {
        endtimeStr=[_Commons stringtoDateforsecond:endtimeStr];
    }
    cell.etimeLable.text=[NSString stringWithFormat:@"结束时间：%@",endtimeStr];
    
    NSString *chargeStr=[_Commons turnNullValue:@"charge" Object:gdsdetail];
    cell.countLable.text=[NSString stringWithFormat:@"计划金额：%@",chargeStr];
    
    NSString *realchargeStr=[_Commons turnNullValue:@"realcharge" Object:gdsdetail];
    cell.inLable.text=[NSString stringWithFormat:@"实际金额：%@",realchargeStr];
    
    NSString *commentsStr=[_Commons turnNullValue:@"comments" Object:gdsdetail];
    CGSize commentsh=[_Commons NSStringHeightForLabel: cell.detailLable.font width: cell.detailLable.frame.size.width Str:[NSString stringWithFormat:@"付款说明：%@",commentsStr]];
    cell.detailLable.text=[NSString stringWithFormat:@"付款说明：%@",commentsStr];
    cell.detailLable.numberOfLines=0;
     cell.detailLable.frame=CGRectMake( cell.detailLable.frame.origin.x,  cell.detailLable.frame.origin.y,  cell.detailLable.frame.size.width, commentsh.height+24);
    
    
    //设置圆角边框
    cell.layer.cornerRadius = 5;
    cell.layer.masksToBounds = YES;
    //设置边框及边框颜色
    cell.layer.borderWidth = 0.8;
    cell.layer.borderColor =[ [UIColor colorWithRed:57.0/255 green:198.0/255  blue:233.0/255 alpha:1.0f] CGColor];
    
    return cell;
}

//点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.goodscollectionview setPresenting:YES animated:YES completion:nil];
}

- (BOOL)collectionView:(UICollectionView *)collectionView canDeleteItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    NSString * item = list[fromIndexPath.item];
    [list removeObjectAtIndex:fromIndexPath.item];
    [list insertObject:item atIndex:toIndexPath.item];
}

- (void)collectionView:(UICollectionView *)collectionView deleteItemAtIndexPath:(NSIndexPath *)indexPath
{
    [list removeObjectAtIndex:indexPath.item];
}

-(IBAction)appCharge:(id)sender
{
    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否确定审核？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    [alter show];
}

//alertview响应事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        Commons *_Commons=[[Commons alloc]init];
        NSMutableDictionary * gds = [NSMutableDictionary dictionaryWithCapacity:5];
        gds=[DataService PostDataService:[NSString stringWithFormat:@"%@api/approverflagCharge",domainser] postDatas:[NSString stringWithFormat:@"key=wjsnmnb&sfid=%@",[_Commons turnNullValue:@"id" Object:rdetail]] ];
        NSString *info=[gds objectForKey:@"info"];
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:info delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alter show];
    }else{
        [self.navigationController popViewControllerAnimated:NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
