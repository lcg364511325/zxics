//
//  staffSearchType.m
//  zxics
//
//  Created by johnson on 15-3-10.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import "staffSearchType.h"
#import "residentManager.h"
#import "myFloorList.h"
#import "staffSearchList.h"

@interface staffSearchType ()

@end

@implementation staffSearchType

@synthesize delegate;
@synthesize type;

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
    
    if ([type isEqualToString:@"1"]) {
        [self.UINavigationItem setTitle:@"以人查房"];
    }else if ([type isEqualToString:@"2"]){
        [self.UINavigationItem setTitle:@"以卡查房"];
    }else{
        [self.UINavigationItem setTitle:@"以房查人"];
    }
    
    [self loadMyView];
}

-(void)loadMyView
{
    
    //第一行
    firstLable=[[UILabel alloc]init];
    firstLable.font=[UIFont systemFontOfSize:12.0f];
    firstLable.frame=CGRectMake(5, self.UINavigationBar.frame.origin.y+self.UINavigationBar.frame.size.height+16, 60, 18);
    
    fristText=[[UITextField alloc]init];
    fristText.font=[UIFont systemFontOfSize:12.0f];
    [fristText setBorderStyle:UITextBorderStyleRoundedRect];
    fristText.frame=CGRectMake(57, self.UINavigationBar.frame.origin.y+self.UINavigationBar.frame.size.height+10, self.view.frame.size.width-62, 30);
    
    //第二行
    secondLable=[[UILabel alloc]init];
    secondLable.font=[UIFont systemFontOfSize:12.0f];
    secondLable.frame=CGRectMake(5, fristText.frame.origin.y+41, 60, 18);
    
    secondText=[[UITextField alloc]init];
    secondText.font=[UIFont systemFontOfSize:12.0f];
    [secondText setBorderStyle:UITextBorderStyleRoundedRect];
    secondText.frame=CGRectMake(57, fristText.frame.origin.y+35, self.view.frame.size.width-62, 30);
    
    if ([type isEqualToString:@"1"] || [type isEqualToString:@"2"]) {
        
        
        //第三行
        
        thirdText=[[UITextField alloc]init];
        thirdText.font=[UIFont systemFontOfSize:12.0f];
        [thirdText setBorderStyle:UITextBorderStyleRoundedRect];
        thirdText.frame=CGRectMake(57, secondText.frame.origin.y+35, self.view.frame.size.width-62, 30);
        
        thirdLable=[[UILabel alloc]init];
        thirdLable.font=[UIFont systemFontOfSize:12.0f];
        thirdLable.frame=CGRectMake(5, secondText.frame.origin.y+41, 60, 18);
        
        
        if ([type isEqualToString:@"1"]) {
            firstLable.text=@"姓名";
            secondLable.text=@"证件号码";
            thirdLable.text=@"手机号";
        }else{
            firstLable.text=@"业主卡号";
            secondLable.text=@"姓名";
            thirdLable.text=@"用户名";
        }
        
        [self.view addSubview:firstLable];
        [self.view addSubview:secondLable];
        [self.view addSubview:thirdLable];
        [self.view addSubview:fristText];
        [self.view addSubview:secondText];
        [self.view addSubview:thirdText];
    }else{
        firstLable.text=@"选择地区";
        secondLable.text=@"选择楼盘";
        
        secondText.placeholder=fristText.placeholder=@"请选择";
        
        firstBtn=[[UIButton alloc]init];
        [firstBtn setBackgroundColor:[UIColor clearColor]];
        firstBtn.frame=fristText.frame;
        [firstBtn addTarget:self action:@selector(selectCommunity) forControlEvents:UIControlEventTouchDown];
        
        secondBtn=[[UIButton alloc]init];
        [secondBtn setBackgroundColor:[UIColor clearColor]];
        secondBtn.frame=secondText.frame;
        [secondBtn addTarget:self action:@selector(selectFloor) forControlEvents:UIControlEventTouchDown];
        
        [self.view addSubview:firstLable];
        [self.view addSubview:secondLable];
        [self.view addSubview:fristText];
        [self.view addSubview:secondText];
        [self.view addSubview:firstBtn];
        [self.view addSubview:secondBtn];
    }
    
}

//选择社区
-(void)selectCommunity
{
    residentManager *_residentManager=[[residentManager alloc]init];
    _residentManager.type=@"1";
    _residentManager.delegate=self;
    [self.navigationController pushViewController:_residentManager animated:NO];
}

//选择楼盘
-(void)selectFloor
{
    if (cid==nil || [cid isEqualToString:@""]) {
        NSString *rowString =@"请先选择一个社区！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alter show];
    }else{
        myFloorList *_residentManager=[[myFloorList alloc]init];
        _residentManager.cid=cid;
        _residentManager.delegate=self;
        [self.navigationController pushViewController:_residentManager animated:NO];
    }
}

//传递值
-(void)passValue:(NSString *)value key:(NSString *)key tag:(NSInteger)tag
{
    if (tag==0) {
        cid=value;
        fristText.text=key;
    }else if(tag==1){
        fid=value;
        secondText.text=key;
    }
}

-(IBAction)returnToStaffSearch:(id)sender
{
    if (![type isEqualToString:@"3"]) {
        cid=fristText.text;
        fid=secondText.text;
    }
    NSDictionary *searchterm=[NSDictionary dictionaryWithObjectsAndKeys:cid,@"firstvalue",fid,@"secondvalue",thirdText.text,@"thirdvalue", nil];
    [delegate passDictionaryValue:searchterm key:nil tag:[type integerValue]];
    [self.navigationController popViewControllerAnimated:NO];
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

@end
