//
//  SpecialPeopleDetail.m
//  zxics
//
//  Created by johnson on 14-8-5.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "SpecialPeopleDetail.h"

@interface SpecialPeopleDetail ()

@end

@implementation SpecialPeopleDetail

@synthesize spdbtntag;

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
    NSInteger selecttype=[spdbtntag integerValue];
    if (selecttype==0) {
        self.UINavigationItem.title=@"发布信息";
    }else if (selecttype==2)
    {
        self.UINavigationItem.title=@"知识库";
    }else if (selecttype==3)
    {
        self.UINavigationItem.title=@"工作动态";
    }else if (selecttype==4)
    {
        self.UINavigationItem.title=@"政策法规";
    }else if (selecttype==5)
    {
        self.UINavigationItem.title=@"求助公告";
    }
}

-(IBAction)goback:(id)sender
{
    SpecialPeople * _SpecialPeople=[[SpecialPeople alloc] init];
    
    [self.navigationController pushViewController:_SpecialPeople animated:NO];
}

//初始化tableview数据
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
    //只有一组，数组数即为行数。
}

// tableview数据显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"SpecialPeopleDetailCell";
    
    SpecialPeopleDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        NSArray * nib=[[NSBundle mainBundle]loadNibNamed:@"SpecialPeopleDetailCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    specialPeopleIntroduce *_specialPeopleIntroduce=[[specialPeopleIntroduce alloc]init];
    [self.navigationController pushViewController:_specialPeopleIntroduce animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
