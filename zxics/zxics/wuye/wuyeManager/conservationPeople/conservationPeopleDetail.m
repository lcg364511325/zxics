//
//  conservationPeopleDetail.m
//  zxics
//
//  Created by johnson on 15-3-9.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import "conservationPeopleDetail.h"
#import "DataService.h"
#import "Commons.h"
#import "ImageCacher.h"

@interface conservationPeopleDetail ()

@end

@implementation conservationPeopleDetail

@synthesize borderImage;
@synthesize headImage;
@synthesize nameLable;
@synthesize cardTypeLable;
@synthesize cardnoLable;
@synthesize sexLable;
@synthesize mobileLable;
@synthesize blockcodeLable;
@synthesize wulinoLable;
@synthesize stateLable;
@synthesize blockTypeLable;
@synthesize stimeLable;
@synthesize cnameLable;
@synthesize floornameLable;
@synthesize uid;

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
    Commons *_Commons=[[Commons alloc]init];
    NSMutableDictionary * pw = [NSMutableDictionary dictionaryWithCapacity:5];
    pw=[DataService PostDataService:[NSString stringWithFormat:@"%@api/getPropertyDetail",domainser] postDatas:[NSString stringWithFormat:@"id=%@",uid]];
    NSDictionary *user=[pw objectForKey:@"data"];
    
    //姓名
    NSString *nameStr=[_Commons turnNullValue:@"name" Object:user];
    nameLable.text=[NSString stringWithFormat:@"姓名：%@",nameStr];
    
    //证件类型
    NSString *codetypeStr=[_Commons turnNullValue:@"codetype" Object:user];
    if ([codetypeStr isEqualToString:@"1"]) {
        codetypeStr=@"身份证";
    }else if ([codetypeStr isEqualToString:@"2"])
    {
        codetypeStr=@"护照";
    }else if ([codetypeStr isEqualToString:@"3"])
    {
        codetypeStr=@"军人证";
    }else if ([codetypeStr isEqualToString:@"4"])
    {
        codetypeStr=@"香港证";
    }else if ([codetypeStr isEqualToString:@"5"])
    {
        codetypeStr=@"台胞证";
    }else{
        codetypeStr=@"其他";
    }
    cardTypeLable.text=[NSString stringWithFormat:@"证件类型：%@",codetypeStr];
    
    //证件号
    NSString *codeidStr=[_Commons turnNullValue:@"codeid" Object:user];
    cardnoLable.text=[NSString stringWithFormat:@"证件号：%@",codeidStr];
    
    //性别
    NSString *sexStr=[_Commons turnNullValue:@"sex" Object:user];
    if ([sexStr isEqualToString:@"1"]) {
        sexStr=@"男";
    }else if ([sexStr isEqualToString:@"2"])
    {
        sexStr=@"女";
    }else{
        sexStr=@"保密";
    }
    sexLable.text=[NSString stringWithFormat:@"性别：%@",sexStr];
    
    //手机号码
    NSString *mobileStr=[_Commons turnNullValue:@"mobile" Object:user];
    mobileLable.text=[NSString stringWithFormat:@"手机号码：%@",mobileStr];
    
    //业主卡号
    NSString *blockcodeStr=[_Commons turnNullValue:@"blockcode" Object:user];
    blockcodeLable.text=[NSString stringWithFormat:@"业主卡号：%@",blockcodeStr];
    
    //物理卡号
    NSString *physicalcodeStr=[_Commons turnNullValue:@"physicalcode" Object:user];
    wulinoLable.text=[NSString stringWithFormat:@"物理卡号：%@",physicalcodeStr];
    
    //状态
    NSString *typeStr=[_Commons turnNullValue:@"type" Object:user];
    if ([typeStr isEqualToString:@"0"]) {
        typeStr=@"正常";
    }else{
        typeStr=@"迁离";
    }
    stateLable.text=[NSString stringWithFormat:@"状态：%@",typeStr];
    
    //卡类型
    NSString *codemoldStr=[NSString stringWithFormat:@"%@",[pw objectForKey:@"codemold"]];
    blockTypeLable.text=[NSString stringWithFormat:@"卡类型：%@",codemoldStr];
    
    //签发日期
    NSString *issuedtimeStr=[_Commons turnNullValue:@"issuedtime" Object:user];
    if (![issuedtimeStr isEqualToString:@""]) {
        issuedtimeStr=[_Commons stringtoDateforsecond:issuedtimeStr];
    }
    stimeLable.text=[NSString stringWithFormat:@"签发日期：%@",issuedtimeStr];
    
    //社区名称
    NSString *cnameStr=[_Commons turnNullValue:@"cname" Object:user];
    cnameLable.text=[NSString stringWithFormat:@"社区名称：%@",cnameStr];
    
    //房号
    NSString *floornameStr=[NSString stringWithFormat:@"%@",[pw objectForKey:@"floorname"]];
    floornameLable.text=[NSString stringWithFormat:@"房号：%@",floornameStr];
    
    //头像
    NSString *url=[NSString stringWithFormat:@"%@",[pw objectForKey:@"headimg"]];
    NSURL *imgUrl=[NSURL URLWithString:url];
    if (hasCachedImage(imgUrl)) {
        [headImage setImage:[UIImage imageWithContentsOfFile:pathForURL(imgUrl)]];
    }else{
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:imgUrl,@"url",headImage,@"imageView",nil];
        [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
    }
    headImage.layer.cornerRadius = headImage.frame.size.width / 2;
    headImage.clipsToBounds = YES;
    
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
