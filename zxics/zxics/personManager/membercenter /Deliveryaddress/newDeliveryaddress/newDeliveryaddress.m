//
//  newDeliveryaddress.m
//  zxics
//
//  Created by johnson on 14-8-8.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "newDeliveryaddress.h"
#import "AppDelegate.h"
#import "DataService.h"
#import "Deliveryaddress.h"

@interface newDeliveryaddress ()

@end

@implementation newDeliveryaddress

@synthesize addrselectButton;
@synthesize ndTView;
@synthesize areaText;
@synthesize addrdetailText;
@synthesize zipcodeText;
@synthesize nameText;
@synthesize phoneText;

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
    areadetail=nil;
    coutryid=@"";
    provinceid=@"";
    cityid=@"";
    districtid=@"";
    ndTView.hidden=YES;
    
}


//查询地区数据
-(NSArray *)loaddata:(NSString *)cid type:(NSString *)type
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    NSMutableDictionary * area = [NSMutableDictionary dictionaryWithCapacity:5];
    area=[DataService PostDataService:[NSString stringWithFormat:@"%@api/mobileOrederFindAddress",myDelegate.url] postDatas:[NSString stringWithFormat:@"id=%@&type=%@",cid,type]];
    NSArray *arealist=[area objectForKey:@"datas"];
    return arealist;
}

-(IBAction)goback:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}


//选择地区
-(IBAction)searcharea:(id)sender
{
    ndTView.hidden=NO;
    list=[self loaddata:@"0" type:@"5"];
    [ndTView reloadData];
}

//初始化tableview数据
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [list count];
    //只有一组，数组数即为行数。
}

// tableview数据显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableSampleIdentifier];
    }
    NSUInteger row = [indexPath row];
    NSDictionary *addetail=[list objectAtIndex:row];
    
    cell.textLabel.text =[addetail objectForKey:@"name"];
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *addetail=[list objectAtIndex:[indexPath row]];
    
    NSString *cid=[NSString stringWithFormat:@"%@",[addetail objectForKey:@"id"]];
    NSInteger type=[[NSString stringWithFormat:@"%@",[addetail objectForKey:@"type"]]integerValue];
    NSString *name=[addetail objectForKey:@"name"];
    
    if (type==5) {
        coutryid=cid;
    }else if (type==6)
    {
        provinceid=cid;
    }else if (type==7)
    {
        cityid=cid;
    }else if (type==8)
    {
        districtid=cid;
    }
    
    list=[self loaddata:cid type:[NSString stringWithFormat:@"%d",type+1]];
    if ([list count]>0) {
        if (areadetail) {
            areadetail=[NSString stringWithFormat:@"%@%@",areadetail,name];
            areaText.text=areadetail;
            [ndTView reloadData];
        }else{
            areadetail=[NSString stringWithFormat:@"%@",name];
            areaText.text=areadetail;
            [ndTView reloadData];
        }
        
    }else{
        if (areadetail) {
            areadetail=[NSString stringWithFormat:@"%@%@",areadetail,name];
            areaText.text=areadetail;
            areadetail=nil;
            ndTView.hidden=YES;
        }else{
            areadetail=[NSString stringWithFormat:@"%@",name];
            areaText.text=areadetail;
            areadetail=nil;
            ndTView.hidden=YES;
        }
    }
}

//点击tableview以外的地方触发事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self.view];
    if (!CGRectContainsPoint([ndTView frame], pt)) {
        //to-do
        ndTView.hidden=YES;
    }
}

//保存收货地址
-(IBAction)submitaddr:(id)sender
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    NSMutableDictionary * state = [NSMutableDictionary dictionaryWithCapacity:5];
    state=[DataService PostDataService:[NSString stringWithFormat:@"%@api/mobileOrederAddReceivingAddress",myDelegate.url] postDatas:[NSString stringWithFormat:@"userid=%@&country=%@&province=%@&city=%@&district=%@&address=%@&zipcode=%@&consignee=%@&mobile=%@",myDelegate.entityl.userid,coutryid,provinceid,cityid,districtid,addrdetailText.text,zipcodeText.text,nameText.text,phoneText.text]];
    NSString *rowString =[NSString stringWithFormat:@"%@",[state objectForKey:@"info"]];
    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    alter.delegate=self;
    [alter show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    Deliveryaddress *_Deliveryaddress=[[Deliveryaddress alloc]init];
    [self.navigationController pushViewController:_Deliveryaddress animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
