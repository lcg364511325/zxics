//
//  rentorshellDetail.m
//  zxics
//
//  Created by johnson on 14-8-11.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "rentorshellDetail.h"

@interface rentorshellDetail ()

@end

@implementation rentorshellDetail

@synthesize picSView;
@synthesize detailSView;
@synthesize nameLabel;
@synthesize rentLabel;
@synthesize floorLabel;
@synthesize typeLabel;
@synthesize comLabel;
@synthesize addrLabel;
@synthesize personLabel;
@synthesize telLabel;
@synthesize detailLabel;
@synthesize areaLabel;
@synthesize targetLabel;
@synthesize fixtureLabel;
@synthesize rsd;
@synthesize btntag;

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
    if ([btntag isEqualToString:@"0"]) {
        self.UINavigationItem.title=@"出售";
    }else{
        self.UINavigationItem.title=@"出租";
    }
    
    [self loaddata];
}

-(void)loaddata
{
    //名称
    nameLabel.text=[NSString stringWithFormat:@"名称：%@",[rsd objectForKey:@"title"]];
    
    //租金
    if ([btntag isEqualToString:@"0"]) {
       rentLabel.text=[NSString stringWithFormat:@"售价：%@万元",[rsd objectForKey:@"rent"]];
    }else
    {
        rentLabel.text=[NSString stringWithFormat:@"租金：%@元/月",[rsd objectForKey:@"rent"]];
    }
    
    //楼层
    id doorch=[rsd objectForKey:@"doorch"];
    id doorzc=[rsd objectForKey:@"doorzc"];
    if (doorch!=[NSNull null] && doorzc!=[NSNull null]) {
        floorLabel.text=[NSString stringWithFormat:@"楼层：%@/%@",doorch,doorzc];
    }else{
        floorLabel.text=@"楼层：";
    }
    
    //房型
    id homeptype=[rsd objectForKey:@"homeptype"];
    if (homeptype!=[NSNull null]) {
        if ([homeptype isEqualToString:@"1"]) {
            typeLabel.text=@"房型：公寓";
        }else if([homeptype isEqualToString:@"2"])
        {
            typeLabel.text=@"房型：单位楼房";
        }else if([homeptype isEqualToString:@"3"])
        {
            typeLabel.text=@"房型：别墅";
        }else if([homeptype isEqualToString:@"4"])
        {
            typeLabel.text=@"房型：民房";
        }else if([homeptype isEqualToString:@"5"])
        {
            typeLabel.text=@"房型：公租";
        }else if([homeptype isEqualToString:@"6"])
        {
            typeLabel.text=@"房型：其他";
        }
    }else{
        typeLabel.text=@"房型：";
    }
    
    //小区
    id communityid=[rsd objectForKey:@"communityid"];
    if (communityid!=[NSNull null]) {
        comLabel.text=[NSString stringWithFormat:@"小区：%@",[rsd objectForKey:@"communityid"]];
    }else{
        comLabel.text=@"小区：";
    }
    
    //地址
    id homeaddress=[rsd objectForKey:@"homeaddress"];
    if (homeaddress!=[NSNull null]) {
        addrLabel.text=[NSString stringWithFormat:@"地址：%@",[rsd objectForKey:@"homeaddress"]];
    }else{
        addrLabel.text=@"地址：";
    }
    
    //联系人
    id contactname=[rsd objectForKey:@"contactname"];
    if (contactname!=[NSNull null]) {
        personLabel.text=[NSString stringWithFormat:@"联系人：%@",[rsd objectForKey:@"contactname"]];
    }else{
        personLabel.text=@"联系人：";
    }
    
    //电话号码
    id contactphone=[rsd objectForKey:@"contactphone"];
    if (contactphone!=[NSNull null]) {
        telLabel.text=[NSString stringWithFormat:@"联系电话：%@",[rsd objectForKey:@"contactphone"]];
    }else{
        telLabel.text=@"联系电话：";
    }
    
    //配置
    id homeset=[rsd objectForKey:@"homeset"];
    if (homeset!=[NSNull null]) {
        detailLabel.text=[NSString stringWithFormat:@"配置：%@",[rsd objectForKey:@"homeset"]];
    }else{
        detailLabel.text=@"配置：";
    }
    
    //面积
    id area=[rsd objectForKey:@"area"];
    if (area!=[NSNull null]) {
        areaLabel.text=[NSString stringWithFormat:@"面积：%@㎡",[rsd objectForKey:@"area"]];
    }else{
        areaLabel.text=@"面积：";
    }
    
    //朝向
    id hometarget=[rsd objectForKey:@"hometarget"];
    if (hometarget!=[NSNull null]) {
        targetLabel.text=[NSString stringWithFormat:@"朝向：%@",[rsd objectForKey:@"hometarget"]];
    }else{
        targetLabel.text=@"朝向：";
    }
    
    //装修
    id hometype=[rsd objectForKey:@"hometype"];
    if (hometype!=[NSNull null]) {
        if ([hometype isEqualToString:@"1"]) {
            fixtureLabel.text=@"装修：毛胚";
        }else if([hometype isEqualToString:@"2"])
        {
            fixtureLabel.text=@"装修：普通装修";
        }else if([hometype isEqualToString:@"3"])
        {
            fixtureLabel.text=@"装修：精装修";
        }else if([hometype isEqualToString:@"4"])
        {
            fixtureLabel.text=@"装修：豪华装修";
        }else if([hometype isEqualToString:@"5"])
        {
            fixtureLabel.text=@"装修：其他";
        }
    }else{
        fixtureLabel.text=@"装修：";
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
