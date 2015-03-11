//
//  staffSearchList.m
//  zxics
//
//  Created by johnson on 15-3-10.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import "staffSearchList.h"
#import "staffSearchCell.h"
#import "AppDelegate.h"
#import "DataService.h"
#import "Commons.h"
#import "staffSearchType.h"

@interface staffSearchList ()

@end

@implementation staffSearchList

@synthesize suTView;
@synthesize firstBtn;
@synthesize secondBtn;
@synthesize thridBtn;
@synthesize btnbgImg;

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
    
    ctype=0;
    oldtag=1;
    searchtype=@"1";
    page=0;
    list=[[NSMutableArray alloc]initWithCapacity:5];
    btnlist=[NSArray arrayWithObjects:firstBtn,secondBtn,thridBtn, nil];
    
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
    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"正在加载数据。。。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alter show];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作（异步操作）
        AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
        pw = [NSMutableDictionary dictionaryWithCapacity:5];
        NSString *param=[NSString stringWithFormat:@"type=%@&front_communityid=%@",searchtype,myDelegate.entityl.communityid];
        if ([searchtype isEqualToString:@"1"]) {
            param=[NSString stringWithFormat:@"%@&name=%@&codeid=%@&mobile=%@",param,name,codeid,mobile];
        }else if([searchtype isEqualToString:@"2"]){
            param=[NSString stringWithFormat:@"%@&username=%@&cardcode=%@&account=%@",param,username,cardcode,account];
        }else if([searchtype isEqualToString:@"3"])
        {
            param=[NSString stringWithFormat:@"%@&communityid=%@&floorid=%@",param,communityid,floorid];
        }
        
        pw=[DataService PostDataService:[NSString stringWithFormat:@"%@api/findRycxMobileApi",domainser] postDatas:param forPage:page forPageSize:10];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            
            NSString *keyname=@"datas";
            if(ctype==2)
            {
                keyname=@"Pdatas";
            }
            NSArray *pwlist=[pw objectForKey:keyname];
            [list addObjectsFromArray:pwlist];
            [suTView reloadData];
            [alter dismissWithClickedButtonIndex:0 animated:YES];
        });
    });
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
    
    static NSString *TableSampleIdentifier = @"staffSearchCell";
    
    staffSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        NSArray * nib=[[NSBundle mainBundle]loadNibNamed:@"staffSearchCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    NSDictionary *sudetail = [list objectAtIndex:[indexPath row]];
    Commons *_Commons=[[Commons alloc]init];
    
    
    //以人查房
    if([searchtype isEqualToString:@"1"] || ctype==2)
    {
        //社区
        NSString *cname=[_Commons turnNullValue:@"cname" Object:sudetail];
        cell.cnameLable.text=cname;
        
        //姓名
        NSString *pname=[_Commons turnNullValue:@"pname" Object:sudetail];
        cell.nameLable.text=[NSString stringWithFormat:@"姓名：%@",pname];
        
        //身份证号
        NSString *codeidStr=[_Commons turnNullValue:@"codeid" Object:sudetail];
        cell.cardnoLable.text=[NSString stringWithFormat:@"身份证号：%@",codeidStr];
        
        //手机号
        NSString *mobileStr=[_Commons turnNullValue:@"mobile" Object:sudetail];
        cell.mobilelable.text=[NSString stringWithFormat:@"手机号：%@",mobileStr];
        
        //房号名称
        NSString *roomName=[_Commons turnNullValue:@"roomName" Object:sudetail];
        cell.floornameLable.text=[NSString stringWithFormat:@"房号名称：%@",roomName];
    }else if ([searchtype isEqualToString:@"2"] || ctype==1)
    {
        //社区
        NSString *cname=[_Commons turnNullValue:@"cname" Object:sudetail];
        cell.cnameLable.text=cname;
        
        //业主卡号
        NSString *pname=[_Commons turnNullValue:@"cardcode" Object:sudetail];
        cell.nameLable.text=[NSString stringWithFormat:@"业主卡号：%@",pname];
        
        //姓名
        NSString *codeidStr=[_Commons turnNullValue:@"pname" Object:sudetail];
        cell.cardnoLable.text=[NSString stringWithFormat:@"姓名：%@",codeidStr];
        
        //用户名
        NSString *mobileStr=[_Commons turnNullValue:@"account" Object:sudetail];
        cell.mobilelable.text=[NSString stringWithFormat:@"手机号：%@",mobileStr];
        
        //房号名称
        NSString *roomName=[_Commons turnNullValue:@"roomName" Object:sudetail];
        cell.floornameLable.text=[NSString stringWithFormat:@"房号名称：%@",roomName];
    }
    
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
}

-(IBAction)setSearchType:(id)sender
{
    staffSearchType *_staffSearchType=[[staffSearchType alloc]init];
    _staffSearchType.type=searchtype;
    _staffSearchType.delegate=self;
    [self.navigationController pushViewController:_staffSearchType animated:NO];
}

//接受值
-(void)passDictionaryValue:(NSDictionary *)value key:(NSDictionary *)key tag:(NSInteger)tag
{
    Commons *_Commons=[[Commons alloc]init];
    if (tag==1) {
        name=[_Commons turnNullValue:@"firstvalue" Object:value];
        codeid=[_Commons turnNullValue:@"secondvalue" Object:value];
        mobile=[_Commons turnNullValue:@"thirdvalue" Object:value];
    }else if(tag==2){
        username=[_Commons turnNullValue:@"firstvalue" Object:value];
        cardcode=[_Commons turnNullValue:@"secondvalue" Object:value];
        account=[_Commons turnNullValue:@"thirdvalue" Object:value];
    }else{
        communityid=[_Commons turnNullValue:@"firstvalue" Object:value];
        floorid=[_Commons turnNullValue:@"secondvalue" Object:value];
    }
    
    [list removeAllObjects];
    [self loaddata];
    [suTView reloadData];
}

-(IBAction)setSearchTypeValue:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    searchtype=[NSString stringWithFormat:@"%d",btn.tag];
    [list removeAllObjects];
    [suTView reloadData];
    for (UIButton *oldbtn in btnlist) {
        if (btn==oldbtn) {
            [btn setBackgroundImage:[UIImage imageNamed:@"selectedBtn"] forState:UIControlStateNormal];
        }else
        {
            [oldbtn setBackgroundImage:[UIImage imageNamed:@"unseletedBtn"] forState:UIControlStateNormal];
        }
    }
    if (btn.tag==3) {
        ctype=1;
        suTView.frame=CGRectMake(suTView.frame.origin.x, suTView.frame.origin.y+btnbgImg.frame.size.height, suTView.frame.size.width, suTView.frame.size.height-btnbgImg.frame.size.height);
        
        btnbgImg.frame=CGRectMake(btnbgImg.frame.origin.x, btnbgImg.frame.origin.y, btnbgImg.frame.size.width, btnbgImg.frame.size.height*2);
        
        //卡信息btn
        cardbtn=[[UIButton alloc]init];
        [cardbtn setTitle:@"查看卡信息" forState:UIControlStateNormal];
        cardbtn.titleLabel.font=[UIFont systemFontOfSize:12.0f];
        [cardbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cardbtn.tag=1;
        [cardbtn setBackgroundColor:[UIColor clearColor]];
        cardbtn.frame=CGRectMake(0, btnbgImg.frame.origin.y+39, btnbgImg.frame.size.width/2, 30);
        [cardbtn addTarget:self action:@selector(floornameToSearch:) forControlEvents:UIControlEventTouchDown];
        [cardbtn setBackgroundImage:[UIImage imageNamed:@"selectedBtn"] forState:UIControlStateNormal];
        [self.view addSubview:cardbtn];
        
        //人口信息btn
        personbtn=[[UIButton alloc]init];
        [personbtn setTitle:@"查看人口信息" forState:UIControlStateNormal];
        personbtn.titleLabel.font=[UIFont systemFontOfSize:12.0f];
        [personbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        personbtn.tag=2;
        [personbtn setBackgroundColor:[UIColor clearColor]];
        personbtn.frame=CGRectMake(btnbgImg.frame.size.width/2, btnbgImg.frame.origin.y+39, btnbgImg.frame.size.width/2, 30);
        [personbtn addTarget:self action:@selector(floornameToSearch:) forControlEvents:UIControlEventTouchDown];
        [personbtn setBackgroundImage:[UIImage imageNamed:@"unseletedBtn"] forState:UIControlStateNormal];
        [self.view addSubview:personbtn];
    }else if(oldtag==3 && btn.tag!=3){
        ctype=0;
        [cardbtn removeFromSuperview];
        [personbtn removeFromSuperview];
        
        btnbgImg.frame=CGRectMake(btnbgImg.frame.origin.x, btnbgImg.frame.origin.y, btnbgImg.frame.size.width, btnbgImg.frame.size.height/2);
        
        suTView.frame=CGRectMake(suTView.frame.origin.x, suTView.frame.origin.y-btnbgImg.frame.size.height, suTView.frame.size.width, suTView.frame.size.height+btnbgImg.frame.size.height);
        
    }
    oldtag=btn.tag;
    
}

-(void)floornameToSearch:(UIButton *)btn
{
    if(btn.tag==1)
    {
        
        [personbtn setBackgroundImage:[UIImage imageNamed:@"unseletedBtn"] forState:UIControlStateNormal];
    }else{
        [cardbtn setBackgroundImage:[UIImage imageNamed:@"unseletedBtn"] forState:UIControlStateNormal];
    }
    [btn setBackgroundImage:[UIImage imageNamed:@"selectedBtn"] forState:UIControlStateNormal];
    ctype=btn.tag;
    [list removeAllObjects];
    NSString *keyname=@"datas";
    if(ctype==2)
    {
        keyname=@"Pdatas";
    }
    NSArray *pwlist=[pw objectForKey:keyname];
    [list addObjectsFromArray:pwlist];
    [suTView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
