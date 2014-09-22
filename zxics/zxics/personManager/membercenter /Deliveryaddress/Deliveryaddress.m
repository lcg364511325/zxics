//
//  Deliveryaddress.m
//  zxics
//
//  Created by johnson on 14-8-8.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "Deliveryaddress.h"
#import "DeliveryaddressCell.h"
#import "AppDelegate.h"
#import "DataService.h"
#import "newDeliveryaddress.h"

@interface Deliveryaddress ()

@end

@implementation Deliveryaddress

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)loaddata
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    NSMutableDictionary * ar = [NSMutableDictionary dictionaryWithCapacity:5];
    ar=[DataService PostDataService:[NSString stringWithFormat:@"%@api/mobileFindUserGoodsAddress",domainser] postDatas:[NSString stringWithFormat:@"userid=%@",myDelegate.entityl.userid]];
    arlist=[ar objectForKey:@"datas"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.UINavigationBar setBackgroundImage:[UIImage imageNamed:@"logo_bg"] forBarMetrics:UIBarMetricsDefault];    
    [self loaddata];
}

-(IBAction)goback:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

//收货地址添加
-(IBAction)adddeliveryaddress:(id)sender
{
    newDeliveryaddress *_newDeliveryaddress=[[newDeliveryaddress alloc]init];
    [self.navigationController pushViewController:_newDeliveryaddress animated:NO];
    
}

//初始化tableview数据
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arlist count];
    //只有一组，数组数即为行数。
}

// tableview数据显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"DeliveryaddressCell";
    
    DeliveryaddressCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        NSArray * nib=[[NSBundle mainBundle]loadNibNamed:@"DeliveryaddressCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    NSDictionary *dadetail = [arlist objectAtIndex:[indexPath row]];
    
    cell.addrLabel.text=[NSString stringWithFormat:@"%@ %@ (%@收) %@ %@",[dadetail objectForKey:@"districtName"],[dadetail objectForKey:@"address"],[dadetail objectForKey:@"consignee"],[dadetail objectForKey:@"mobile"],[dadetail objectForKey:@"zipcode"]];
    
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dadetail = [arlist objectAtIndex:[indexPath row]];
    rid=[NSString stringWithFormat:@"%@",[dadetail objectForKey:@"address_id"]];
    NSString *rowString =@"是否删除本条收货地址？";
    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alter.delegate=self;
    [alter show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        NSMutableDictionary * state = [NSMutableDictionary dictionaryWithCapacity:5];
        state=[DataService PostDataService:[NSString stringWithFormat:@"%@api/mobileDelectReceivingAddress",domainser] postDatas:[NSString stringWithFormat:@"aId=%@",rid]];
        NSString *rowString =[NSString stringWithFormat:@"%@",[state objectForKey:@"info"]];
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        [self loaddata];
        [_daTView reloadData];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
