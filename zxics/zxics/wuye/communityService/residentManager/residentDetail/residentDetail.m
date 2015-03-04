//
//  residentDetail.m
//  zxics
//
//  Created by johnson on 15-3-3.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import "residentDetail.h"
#import "DataService.h"
#import "Commons.h"
#import "ImageCacher.h"

@interface residentDetail ()

@end

@implementation residentDetail

@synthesize uid;
@synthesize accountLabel;
@synthesize nameLabel;
@synthesize sexLabel;
@synthesize isyezhuLabel;
@synthesize cardnoLabel;
@synthesize cardnumberLabel;
@synthesize proLabel;
@synthesize addrLabel;
@synthesize QQLabel;
@synthesize EmailLabel;
@synthesize telLabel;
@synthesize mobileLabel;
@synthesize briLabel;
@synthesize wordLabel;
@synthesize reLabel;
@synthesize borderImage;
@synthesize headImage;

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
    
    //设置圆角边框
    borderImage.layer.cornerRadius = 5;
    borderImage.layer.masksToBounds = YES;
    //设置边框及边框颜色
    borderImage.layer.borderWidth = 0.8;
    borderImage.layer.borderColor =[ [UIColor colorWithRed:200.0/255 green:199.0/255  blue:204.0/255 alpha:1.0f] CGColor];
    
    
    [self loaddata];
}

-(void)loaddata
{
    NSMutableDictionary * pw = [NSMutableDictionary dictionaryWithCapacity:5];
    pw=[DataService PostDataService:[NSString stringWithFormat:@"%@api/getOwnerResidentDetail",domainser] postDatas:[NSString stringWithFormat:@"id=%@",uid]];
    NSDictionary *user=[pw objectForKey:@"data"];
    
    //头像
    NSString *url=[self turnNullValue:@"headimg" Object:user];
    NSURL *imgUrl=[NSURL URLWithString:url];
    if (hasCachedImage(imgUrl)) {
        [headImage setImage:[UIImage imageWithContentsOfFile:pathForURL(imgUrl)]];
    }else{
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:imgUrl,@"url",headImage,@"imageView",nil];
        [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
    }
    headImage.layer.cornerRadius = headImage.frame.size.width / 2;
    headImage.clipsToBounds = YES;
    
    accountLabel.text=[NSString stringWithFormat:@"账号：%@",[self turnNullValue:@"account" Object:user]];
    nameLabel.text=[NSString stringWithFormat:@"姓名：%@",[self turnNullValue:@"name" Object:user]];
    
    NSString *sex=[self turnNullValue:@"sex" Object:user];
    if ([sex isEqualToString:@"0"]) {
        sex=@"保密";
    }else if([sex isEqualToString:@"1"]){
        sex=@"男";
    }else if([sex isEqualToString:@"2"]){
        sex=@"女";
    }
    sexLabel.text=[NSString stringWithFormat:@"性别：%@",sex];
    
    NSString *isstaff=[self turnNullValue:@"isstaff" Object:user];
    if ([isstaff isEqualToString:@"0"]) {
        isstaff=@"不是";
    }else if([sex isEqualToString:@"1"]){
        isstaff=@"是";
    }
    
    isyezhuLabel.text=[NSString stringWithFormat:@"是否业主：%@",isstaff];
    
    
    cardnoLabel.text=[NSString stringWithFormat:@"身份证号：%@",[self turnNullValue:@"codeid" Object:user]];
    cardnumberLabel.text=[NSString stringWithFormat:@"卡号：%@",[self turnNullValue:@"cardcode" Object:user]];
    proLabel.text=[NSString stringWithFormat:@"地区：%@",[self turnNullValue:@"tname" Object:user]];
    addrLabel.text=[NSString stringWithFormat:@"地址：%@",[self turnNullValue:@"addr" Object:user]];
    QQLabel.text=[NSString stringWithFormat:@"QQ：%@",[self turnNullValue:@"qq" Object:user]];
    EmailLabel.text=[NSString stringWithFormat:@"Email：%@",[self turnNullValue:@"email" Object:user]];
    telLabel.text=[NSString stringWithFormat:@"固话：%@",[self turnNullValue:@"phone" Object:user]];
    mobileLabel.text=[NSString stringWithFormat:@"手机：%@",[self turnNullValue:@"mobile" Object:user]];
    briLabel.text=[NSString stringWithFormat:@"生日：%@",[self turnNullValue:@"birthday" Object:user]];
    wordLabel.text=[NSString stringWithFormat:@"工作单位：%@",[self turnNullValue:@"compname" Object:user]];
    
    Commons *_Commons=[[Commons alloc]init];
    NSString *m_reg_timeStr=[self turnNullValue:@"m_reg_time" Object:user];
    
    
    if (![m_reg_timeStr isEqualToString:@""]) {
        reLabel.text=[NSString stringWithFormat:@"注册时间：%@",[_Commons stringtoDateforsecond:m_reg_timeStr]];
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
