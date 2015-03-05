//
//  wuyeInfo.m
//  zxics
//
//  Created by johnson on 15-3-4.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import "wuyeInfo.h"
#import "Commons.h"
#import "AppDelegate.h"
#import "DataService.h"
#import "threeLineTwoBtnCell.h"

@interface wuyeInfo ()

@end

@implementation wuyeInfo

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
    pw=[DataService PostDataService:[NSString stringWithFormat:@"%@api/findSiteMsgqList",domainser] postDatas:[NSString stringWithFormat:@"communityIds=%@",myDelegate.entityl.communityid] forPage:page forPageSize:10];
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
    
    cell.updatebtn.hidden=YES;
    Commons *_Commons=[[Commons alloc]init];
    NSDictionary *sudetail = [list objectAtIndex:[indexPath row]];
    
    //删除按钮
    NSString *uid=[self turnNullValue:@"id" Object:sudetail];
    cell.deleteBtn.tag=[uid intValue];
    [cell.deleteBtn addTarget:self action:@selector(deleteResidentForCommunity:) forControlEvents:UIControlEventTouchDown];
    
    //已读按钮
    cell.readBtn.tag=[uid intValue];
    [cell.readBtn addTarget:self action:@selector(turninfotoread:) forControlEvents:UIControlEventTouchDown];
    
    //发送人
    NSString *senderStr=[_Commons turnNullValue:@"name" Object:sudetail];
    if (![senderStr isEqualToString:@""]) {
        cell.nameLabel.text=[NSString stringWithFormat:@"发送人：%@",senderStr];
    }
    
    //信息内容
    NSString *infoStr=[_Commons turnNullValue:@"contents" Object:sudetail];
    NSString *isread=[_Commons turnNullValue:@"isread" Object:sudetail];
    CGSize infoheight;
    cell.infoLabel.numberOfLines=0;
    if (![infoStr isEqualToString:@""]) {
        if ([isread isEqualToString:@"1"]) {
            cell.infoLabel.text=[NSString stringWithFormat:@"%@",infoStr];
            
            infoheight=[_Commons NSStringHeightForLabel:cell.infoLabel.font width:cell.infoLabel.frame.size.width Str:infoStr];
            
        }else{
            NSString *newinfoStr=[NSString stringWithFormat:@"%@   (未读)",infoStr];
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:newinfoStr];
            [AttributedStr addAttribute:NSForegroundColorAttributeName
             
                                  value:[UIColor redColor]
             
                                  range:NSMakeRange(newinfoStr.length-4, 4)];
            cell.infoLabel.attributedText=AttributedStr;
            
            infoheight=[_Commons NSStringHeightForLabel:cell.infoLabel.font width:cell.infoLabel.frame.size.width Str:newinfoStr];
        }
        
        cell.infoLabel.frame=CGRectMake(cell.infoLabel.frame.origin.x, cell.nameLabel.frame.origin.y+18, cell.infoLabel.frame.size.width, infoheight.height+24);
    }
    
    //时间
    NSString *timeStr=[_Commons turnNullValue:@"createtime" Object:sudetail];
    if (![timeStr isEqualToString:@""]) {
        cell.timeLabel.text=[_Commons stringtoDateforsecond:timeStr];
        cell.timeLabel.frame=CGRectMake(cell.timeLabel.frame.origin.x, cell.infoLabel.frame.origin.y+infoheight.height+42-cell.nameLabel.frame.size.height, cell.timeLabel.frame.size.width, cell.timeLabel.frame.size.height);
    }
    
    
    //设置圆角边框
    cell.borderImage.frame=CGRectMake(3, 3, cell.frame.size.width-6, cell.frame.size.height+cell.infoLabel.frame.size.height-cell.timeLabel.frame.size.height-6);
    
    int cellheight=cell.frame.size.height+cell.infoLabel.frame.size.height-cell.timeLabel.frame.size.height;
    
    //btn位置处理
    if ([isread isEqualToString:@"1"]) {
        cell.readBtn.hidden=YES;
        cell.deleteBtn.frame=CGRectMake(cell.frame.size.width-10-cell.deleteBtn.frame.size.width, (cellheight-cell.deleteBtn.frame.size.height)/2, cell.deleteBtn.frame.size.width, cell.deleteBtn.frame.size.height);
    }else{
        int btncountheight=cell.deleteBtn.frame.size.height+cell.readBtn.frame.size.height+4;
        cell.readBtn.frame=CGRectMake(cell.frame.size.width-10-cell.deleteBtn.frame.size.width, (cellheight-btncountheight)/2, cell.readBtn.frame.size.width, cell.readBtn.frame.size.height);
        
        cell.deleteBtn.frame=CGRectMake(cell.frame.size.width-10-cell.deleteBtn.frame.size.width, (cellheight-btncountheight)/2+cell.readBtn.frame.size.height+4, cell.deleteBtn.frame.size.width, cell.deleteBtn.frame.size.height);
    }
    
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
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    threeLineTwoBtnCell *cell = (threeLineTwoBtnCell *)[self tableView:suTView cellForRowAtIndexPath:indexPath];
    CGFloat height=cell.frame.size.height+cell.infoLabel.frame.size.height-cell.timeLabel.frame.size.height;
    return height;
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

//删除居民社区关联
-(void)deleteResidentForCommunity:(UIButton *)btn
{
    userid=btn.tag;
    type=@"1";
    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定是否要删除此信息？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alter show];
    
}

//将消息设置为已读
-(void)turninfotoread:(UIButton *)btn
{
    userid=btn.tag;
    type=@"0";
    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定是否要改变未读状态？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alter show];
    
}

//alertview响应事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        
        NSMutableDictionary * pw = [NSMutableDictionary dictionaryWithCapacity:5];
        pw=[DataService PostDataService:[NSString stringWithFormat:@"%@api/dereadSiteMsg",domainser] postDatas:[NSString stringWithFormat:@"id=%d&type=%@",userid,type]];
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
