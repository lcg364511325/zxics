//
//  blockCodeListView.m
//  zxics
//
//  Created by johnson on 15-3-9.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import "blockCodeListView.h"
#import "AppDelegate.h"
#import "DataService.h"
#import "Commons.h"
#import "blockcodeCell.h"

@interface blockCodeListView ()

@end

@implementation blockCodeListView

@synthesize suTView;
@synthesize cid;
@synthesize delegate;

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
    selectedlist=[[NSMutableArray alloc]initWithCapacity:5];
    selectedlistid=[[NSMutableArray alloc]initWithCapacity:5];
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
    pw=[DataService PostDataService:[NSString stringWithFormat:@"%@api/getPorterNum",domainser] postDatas:[NSString stringWithFormat:@"cId=%@",cid] forPage:page forPageSize:10];
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
    
    static NSString *TableSampleIdentifier = @"blockcodeCell";
    
    blockcodeCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        NSArray * nib=[[NSBundle mainBundle]loadNibNamed:@"blockcodeCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    NSDictionary *sudetail = [list objectAtIndex:[indexPath row]];
    Commons *_Commons=[[Commons alloc]init];
    
    
    
    [cell.checkBtn addTarget:self action:@selector(addpname:) forControlEvents:UIControlEventTouchDown];
    
    NSString *nameStr=[_Commons turnNullValue:@"portercardname" Object:sudetail];
    cell.nameLable.text=nameStr;
    
    
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


//记住所选的门房卡号
-(void)addpname:(UIButton *)btn
{
    Commons *_Commons=[[Commons alloc]init];
    int btntag=btn.tag;
    NSDictionary *sudetail=[list objectAtIndex:btntag];
    NSString *nameStr=[_Commons turnNullValue:@"portercardname" Object:sudetail];
    NSString *idStr=[_Commons turnNullValue:@"id" Object:sudetail];
    if([selectedlist count]==0)
    {
        [selectedlist addObject:nameStr];
        [selectedlistid addObject:idStr];
        [btn setImage:[UIImage imageNamed:@"sed"] forState:UIControlStateNormal];
    }else{
        for (NSString *sname in selectedlist) {
            if ([sname isEqualToString:nameStr]) {
                [selectedlist removeObject:nameStr];
                [selectedlistid removeObject:idStr];
                [btn setImage:[UIImage imageNamed:@"uns"] forState:UIControlStateNormal];
                break;
            }else{
                [selectedlist addObject:nameStr];
                [selectedlistid addObject:idStr];
                [btn setImage:[UIImage imageNamed:@"sed"] forState:UIControlStateNormal];
            }
        }
    }
}

//确定选择房号
-(IBAction)turntoredent:(id)sender
{
    if ([selectedlist count]==0) {
        NSString *rowString =@"请先选择门房卡号";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alter show];
    }else{
        for (int i=0; i<[selectedlist count]; i++) {
            if(i==0)
            {
                pname=[selectedlist objectAtIndex:i];
                ids=[selectedlistid objectAtIndex:i];
            }else{
                pname=[NSString stringWithFormat:@"%@,%@",pname,[selectedlist objectAtIndex:i]];
                ids=[NSString stringWithFormat:@"%@,%@",ids,[selectedlistid objectAtIndex:i]];
            }
        }
        NSString *rowString =[NSString stringWithFormat:@"确定是否选择：%@？",pname];
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alter show];
    }
}

//alertview响应事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        [delegate passValue:ids key:pname tag:2];
        [self.navigationController popViewControllerAnimated:NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
