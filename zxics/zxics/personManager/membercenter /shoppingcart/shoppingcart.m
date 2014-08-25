//
//  shoppingcart.m
//  zxics
//
//  Created by johnson on 14-8-8.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "shoppingcart.h"
#import "AppDelegate.h"
#import "DataService.h"
#import "MJRefresh.h"
#import "ImageCacher.h"
#import "placeorder.h"

@interface shoppingcart ()

@end

@implementation shoppingcart

@synthesize scTView;
@synthesize secondView;
@synthesize goodscount;

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
    ridlist = [[NSMutableArray alloc]initWithCapacity:5];
    page=1;
    orgid=@"0";
    list=[[NSMutableArray alloc]initWithCapacity:5];
    
    [self loaddata];
    
    //上拉刷新下拉加载提示
    [scTView addHeaderWithCallback:^{
        [list removeAllObjects];
        page=1;
        [self loaddata];
        [scTView reloadData];
        [scTView headerEndRefreshing];}];
    [scTView addFooterWithCallback:^{
        page=page+1;
        [self loaddata];
        [scTView reloadData];
        [scTView footerEndRefreshing];
    }];
}

-(void)loaddata
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    NSMutableDictionary * sc = [NSMutableDictionary dictionaryWithCapacity:5];
    sc=[DataService PostDataService:[NSString stringWithFormat:@"%@api/mobileShoppingCar",myDelegate.url] postDatas:[NSString stringWithFormat:@"userid=%@",myDelegate.entityl.userid] forPage:page forPageSize:10];
    NSArray *sclist=[sc objectForKey:@"datas"];
    [list addObjectsFromArray:sclist];
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
    
    static NSString *TableSampleIdentifier = @"shoppingcartCell";
    
    shoppingcartCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        NSArray * nib=[[NSBundle mainBundle]loadNibNamed:@"shoppingcartCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    NSDictionary *scdetail = [list objectAtIndex:[indexPath row]];
    NSDictionary *sc=[scdetail objectForKey:@"sc"];
    cell.titleLabel.text=[NSString stringWithFormat:@"%@",[sc objectForKey:@"goodsName"]];
    cell.countLabel.text=[NSString stringWithFormat:@"%@",[sc objectForKey:@"goodsNumber"]];
    cell.moneyLabel.text=[NSString stringWithFormat:@"%@",[sc objectForKey:@"goodsPrice"]];
    cell.shopnameLabel.text=[NSString stringWithFormat:@"所属商家：%@",[scdetail objectForKey:@"orgName"]];
    
    //删除按钮
    NSString *recId=[NSString stringWithFormat:@"%@",[sc objectForKey:@"recId"]];
    cell.deleteButton.tag=[recId integerValue];
    [cell.deleteButton addTarget:self action:@selector(deletegoodsforsc:) forControlEvents:UIControlEventTouchDown];
    
    //更改数量按钮
    cell.changecountButton.tag=[indexPath row];
    [cell.changecountButton addTarget:self action:@selector(pickerAction:) forControlEvents:UIControlEventTouchDown];
    
    //checkbox
    cell.checkbutton.tag=[indexPath row];
    [cell.checkbutton addTarget:self action:@selector(selectedcell:) forControlEvents:UIControlEventTouchDown];
    
    NSURL *imgUrl=[NSURL URLWithString:[NSString stringWithFormat:@"%@",[scdetail objectForKey:@"goodImg"]]];
    if (hasCachedImage(imgUrl)) {
        [cell.logoimage setImage:[UIImage imageWithContentsOfFile:pathForURL(imgUrl)]];
    }else{
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:imgUrl,@"url",cell.logoimage,@"imageView",nil];
        [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
    }
    
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//删除购物车里面的商品
-(void)deletegoodsforsc:(UIButton *)btn;
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    NSMutableDictionary * state = [NSMutableDictionary dictionaryWithCapacity:5];
    state=[DataService PostDataService:[NSString stringWithFormat:@"%@api/mobileDeleteOrderGoods",myDelegate.url] postDatas:[NSString stringWithFormat:@"recId=%d",btn.tag]];
    NSString *rowString =[NSString stringWithFormat:@"%@",[state objectForKey:@"info"]];
    NSString *status =[NSString stringWithFormat:@"%@",[state objectForKey:@"status"]];
    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alter show];
    if ([status isEqualToString:@"1"]) {
        [list removeAllObjects];
        page=1;
        [self loaddata];
        [scTView reloadData];
    }
}


//商品数量更改页面弹出
- (void)pickerAction:(id)sender{
    
    //得到点击cell，查出要更改的订单实体
    UIButton *btn=(UIButton *)sender;
    NSDictionary *scdetail = [list objectAtIndex:btn.tag];
    NSDictionary *sc=[scdetail objectForKey:@"sc"];
    goodscount.text=[NSString stringWithFormat:@"%@",[sc objectForKey:@"goodsNumber"]];
    NSString *recId=[NSString stringWithFormat:@"%@",[sc objectForKey:@"recId"]];
    rid=[recId integerValue];
    
    // Here we need to pass a full frame
    CustomIOS7AlertView *alertView = [[CustomIOS7AlertView alloc] init];
    
    // Add some custom content to the alert view
    [alertView setContainerView:[self secondView]];
    
    // Modify the parameters
    [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"确定", @"取消", nil]];
    [alertView setDelegate:self];
    
    [alertView setUseMotionEffects:true];
    
    // And launch the dialog
    [alertView show];
}

- (void)customIOS7dialogButtonTouchUpInside: (CustomIOS7AlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        [alertView close];
    }else if (buttonIndex==0)
    {
        AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
        NSMutableDictionary * state = [NSMutableDictionary dictionaryWithCapacity:5];
        state=[DataService PostDataService:[NSString stringWithFormat:@"%@api/mobileChangeGoodsSum",myDelegate.url] postDatas:[NSString stringWithFormat:@"recId=%d&sum=%@",rid,goodscount.text]];
        NSString *rowString =[NSString stringWithFormat:@"%@",[state objectForKey:@"info"]];
        NSString *status =[NSString stringWithFormat:@"%@",[state objectForKey:@"status"]];
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        if ([status isEqualToString:@"1"]) {
            [list removeAllObjects];
            page=1;
            [self loaddata];
            [scTView reloadData];
        }
        [alertView close];
    }
}


//更改商品数量
-(IBAction)changeno:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    NSInteger btntag=btn.tag;
    NSInteger no=[goodscount.text integerValue];
    if (btntag==0)
    {
        goodscount.text=[NSString stringWithFormat:@"%d",no-1];
        
    }else if (btntag==1)
    {
        goodscount.text=[NSString stringWithFormat:@"%d",no+1];
    }
}

//checkbox选中事件
-(void)selectedcell:(UIButton *)btn
{
    //得到点击cell，查出要更改的订单实体
    NSDictionary *scdetail = [list objectAtIndex:btn.tag];
    NSDictionary *sc=[scdetail objectForKey:@"sc"];
    NSString *goodsId=[NSString stringWithFormat:@"%@",[sc objectForKey:@"goodsId"]];
    
    if ([orgid isEqualToString:@"0"]) {
        orgid=[NSString stringWithFormat:@"%@",[scdetail objectForKey:@"orgId"]];
    }
    
    if ([orgid isEqualToString:[NSString stringWithFormat:@"%@",[scdetail objectForKey:@"orgId"]]]) {
        BOOL isequal=NO;
        for (NSString *reid in ridlist) {
            isequal=[goodsId isEqualToString:reid];
            if (isequal) {
                [ridlist removeObject:reid];
                [btn setBackgroundColor:[UIColor lightGrayColor]];
            }
        }
        if (!isequal) {
            [ridlist addObject:goodsId];
            [btn setBackgroundColor:[UIColor redColor]];
        }
    }else
    {
        NSString *rowString =@"暂不支持不同商家的商品同时下单，请重新下单";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
}


//下单页面跳转
-(IBAction)submitorder:(id)sender
{
    if ([ridlist count]>0) {
        placeorder *_placeorder=[[placeorder alloc]init];
        _placeorder.ridlist=ridlist;
        [self.navigationController pushViewController:_placeorder animated:NO];
    }else{
        NSString *rowString =@"请选择下单的商品";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
