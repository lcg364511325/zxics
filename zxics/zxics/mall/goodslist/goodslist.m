//
//  goodslist.m
//  zxics
//
//  Created by johnson on 14-8-11.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "goodslist.h"
#import "goodslistCell.h"
#import "fontindex.h"
#import "personIndex.h"
#import "serviceIndex.h"
#import "goodsDetail.h"

@interface goodslist ()

@end

@implementation goodslist

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
    
    //注册collectionview的cell
    [self.goodscollectionview registerClass:[goodslistCell class] forCellWithReuseIdentifier:@"goodslistCell"];
}

//首页跳转
-(IBAction)frontindex:(id)sender
{
    fontindex * _fontindex=[[fontindex alloc] init];
    
    [self.navigationController pushViewController:_fontindex animated:NO];
}

//个人管理页面跳转
-(IBAction)personindex:(id)sender
{
    personIndex *_personIndex=[[personIndex alloc]init];
    [self.navigationController pushViewController:_personIndex animated:NO];
}

//服务指南页面跳转
-(IBAction)serviceIndex:(id)sender
{
    serviceIndex *_serviceIndex=[[serviceIndex alloc]init];
    [self.navigationController pushViewController:_serviceIndex animated:NO];
}

//搜索结果数目
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 12;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    goodslistCell *cell = (goodslistCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"goodslistCell" forIndexPath:indexPath];

    return cell;
}

//点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    goodsDetail *_goodsDetail=[[goodsDetail alloc]init];
    [self.navigationController pushViewController:_goodsDetail animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
