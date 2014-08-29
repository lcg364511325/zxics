//
//  goodsDetail.m
//  zxics
//
//  Created by johnson on 14-8-11.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "goodsDetail.h"
#import "goodsDetailCell.h"
#import "MJRefresh.h"
#import "AppDelegate.h"
#import "DataService.h"
#import "Commons.h"
#import "placeorder.h"

@interface goodsDetail ()

@end

@implementation goodsDetail
@synthesize gdsdetail;
@synthesize secondView;
@synthesize thirdView;
@synthesize nameLabel;
@synthesize shopprcLabel;
@synthesize marketprcLabel;
@synthesize goodsnoLabel;
@synthesize sellnoLabel;
@synthesize countnoLabel;
@synthesize goodsimageSView;
@synthesize detailButton;
@synthesize introductButton;
@synthesize assessButton;
@synthesize miaoshu;
@synthesize maoshuLabel;
@synthesize xiangqing;
@synthesize xiangqingLabel;
@synthesize assessTView;
@synthesize introSView;

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
    
    page=1;
    list=[[NSMutableArray alloc]initWithCapacity:1];
    
    //加载数据
    [self loaddata];
    
    //上拉刷新下拉加载提示
    [assessTView addHeaderWithCallback:^{
        [list removeAllObjects];
        page=1;
        [self loaddata];
        [assessTView reloadData];
        [assessTView headerEndRefreshing];}];
    [assessTView addFooterWithCallback:^{
        page=page+1;
        [self loaddata];
        [assessTView reloadData];
        [assessTView footerEndRefreshing];
    }];
}

//商品详情
-(void)loaddata
{
    //商品详情
    detailButton.backgroundColor=[UIColor lightGrayColor];
    nameLabel.text=[NSString stringWithFormat:@"%@",[gdsdetail objectForKey:@"name"]];
    shopprcLabel.text=[NSString stringWithFormat:@"%@",[gdsdetail objectForKey:@"shopPrice"]];
    marketprcLabel.text=[NSString stringWithFormat:@"%@",[gdsdetail objectForKey:@"marketPrice"]];
    goodsnoLabel.text=[NSString stringWithFormat:@"%@",[gdsdetail objectForKey:@"goodsSn"]];
    sellnoLabel.text=[NSString stringWithFormat:@"%@",[gdsdetail objectForKey:@"saleCount"]];
    
    //商品描述
    maoshuLabel.numberOfLines=0;
    CGSize size =CGSizeMake(maoshuLabel.frame.size.width,0);
    UIFont * tfont = maoshuLabel.font;
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
    
    CGSize  actualsize =[[gdsdetail objectForKey:@"goodsBrief"] boundingRectWithSize:size options:
                         NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
    maoshuLabel.text=[NSString stringWithFormat:@"%@",[gdsdetail objectForKey:@"goodsBrief"]];
    maoshuLabel.frame=CGRectMake(maoshuLabel.frame.origin.x, maoshuLabel.frame.origin.y, maoshuLabel.frame.size.width, actualsize.height+24);
    
    //详情描述
    xiangqing.frame=CGRectMake(xiangqing.frame.origin.x, maoshuLabel.frame.origin.y+maoshuLabel.frame.size.height, xiangqing.frame.size.width, xiangqing.frame.size.height);
    
    xiangqingLabel.numberOfLines=0;
    actualsize =[[gdsdetail objectForKey:@"goodsDesc"] boundingRectWithSize:size options:
                 NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
    xiangqingLabel.text=[NSString stringWithFormat:@"%@",[gdsdetail objectForKey:@"goodsDesc"]];
    xiangqingLabel.frame=CGRectMake(xiangqingLabel.frame.origin.x, xiangqing.frame.origin.y, xiangqingLabel.frame.size.width, actualsize.height+24);
    
    introSView.contentSize=CGSizeMake(320, maoshuLabel.frame.size.height+xiangqingLabel.frame.size.height+introSView.frame.size.height);
    introSView.showsHorizontalScrollIndicator=NO;//不显示水平滑动线
    introSView.showsVerticalScrollIndicator=YES;//不显示垂直滑动线
    introSView.scrollEnabled=YES;
    
    
    //商品评价
    NSMutableDictionary * ass = [NSMutableDictionary dictionaryWithCapacity:5];
    ass=[DataService PostDataService:[NSString stringWithFormat:@"%@api/mobileGoodsInfoEvaluate",domainser] postDatas:[NSString stringWithFormat:@"gid=%@",[gdsdetail objectForKey:@"id"]] forPage:page forPageSize:10];
    NSArray *asslist=[ass objectForKey:@"datas"];
    [list addObjectsFromArray:asslist];
}

-(IBAction)detail:(id)sender
{
    introductButton.backgroundColor=assessButton.backgroundColor=[UIColor darkGrayColor];
    detailButton.backgroundColor=[UIColor lightGrayColor];
    [secondView removeFromSuperview];
    [thirdView removeFromSuperview];
}


//商品介绍显示
-(IBAction)introduct:(id)sender
{
    [secondView removeFromSuperview];
    [thirdView removeFromSuperview];
    detailButton.backgroundColor=assessButton.backgroundColor=[UIColor darkGrayColor];
    introductButton.backgroundColor=[UIColor lightGrayColor];
    
    secondView.frame=CGRectMake(secondView.frame.origin.x, 226, secondView.frame.size.width, secondView.frame.size.height);
    
    [self.view addSubview:secondView];
    
}

-(IBAction)assess:(id)sender
{
    [secondView removeFromSuperview];
    [thirdView removeFromSuperview];
    
    thirdView.frame=CGRectMake(thirdView.frame.origin.x, 226, thirdView.frame.size.width, thirdView.frame.size.height);
    [self.view addSubview:thirdView];
}

//初始化tableview数据
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [list count];
    //只有一组，数组数即为行数。
}

// tableview数据显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"goodsDetailCell";
    
    goodsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        NSArray * nib=[[NSBundle mainBundle]loadNibNamed:@"goodsDetailCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    NSDictionary *assdetail = [list objectAtIndex:[indexPath row]];
    
    cell.nameLabel.text=[NSString stringWithFormat:@"%@",[assdetail objectForKey:@"name"]];
    cell.asseccLabel.text=[NSString stringWithFormat:@"%@",[assdetail objectForKey:@"comments"]];
    cell.scoreLabel.text=[NSString stringWithFormat:@"用户评分：%@",[assdetail objectForKey:@"star"]];
    
    Commons *_Commons=[[Commons alloc]init];
    NSString *timestr=[NSString stringWithFormat:@"%@",[assdetail objectForKey:@"ctime"]];
    cell.timeLabel.text=[_Commons stringtoDateforsecond:timestr];
    
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//更改商品数量
-(IBAction)changeno:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    NSInteger btntag=btn.tag;
    NSInteger no=[countnoLabel.text integerValue];
    if (btntag==0)
    {
        countnoLabel.text=[NSString stringWithFormat:@"%d",no-1];
        
    }else if (btntag==1)
    {
        countnoLabel.text=[NSString stringWithFormat:@"%d",no+1];
    }
}

-(IBAction)goback:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//加入购物车
-(IBAction)addtoshopcart:(id)sender
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    if (myDelegate.entityl) {
        NSMutableDictionary * state = [NSMutableDictionary dictionaryWithCapacity:5];
        state=[DataService PostDataService:[NSString stringWithFormat:@"%@api/mobileGoodsAddToCar",domainser] postDatas:[NSString stringWithFormat:@"gid=%@&mid=%@&sum=%@&sid=%@",[gdsdetail objectForKey:@"id"],myDelegate.entityl.userid,countnoLabel.text,@""]];
        NSString *rowString =[NSString stringWithFormat:@"%@",[state objectForKey:@"info"]];
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }else{
        NSString *rowString =@"请先登陆！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
}


//立即购买
-(IBAction)buynow:(id)sender
{
    placeorder *_placeorder=[[placeorder alloc]init];
    NSMutableArray *ridlist = [[NSMutableArray alloc]initWithCapacity:1];
    [ridlist addObject:[gdsdetail objectForKey:@"id"]];
    _placeorder.ridlist=ridlist;
    _placeorder.shopid=[gdsdetail objectForKey:@"orgId"];
    _placeorder.nowcount=countnoLabel.text;
    [self.navigationController pushViewController:_placeorder animated:NO];
}

@end
