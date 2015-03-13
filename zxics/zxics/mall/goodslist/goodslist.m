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
#import "DataService.h"
#import "ImageCacher.h"
#import "nameforgoods.h"
#import "classforgoods.h"

@interface goodslist ()

@end

@implementation goodslist

@synthesize goodsname;
@synthesize cid;

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
    [self.UINavigationBar setBackgroundImage:[UIImage imageNamed:@"logo_bg"] forBarMetrics:UIBarMetricsDefault];    
    //注册collectionview的cell
    [self.goodscollectionview registerClass:[goodslistCell class] forCellWithReuseIdentifier:@"goodslistCell"];
    
    page=1;
    list=[[NSMutableArray alloc]initWithCapacity:1];
    
    //加载数据
    [self loaddata];
    
    //上拉刷新下拉加载提示
    [self.goodscollectionview addHeaderWithCallback:^{
        [list removeAllObjects];
        page=1;
        [self loaddata];
        [self.goodscollectionview reloadData];
        [self.goodscollectionview headerEndRefreshing];}];
    [self.goodscollectionview addFooterWithCallback:^{
        page=page+1;
        [self loaddata];
        [self.goodscollectionview reloadData];
        [self.goodscollectionview footerEndRefreshing];
    }];
}

-(void)loaddata
{
    [list removeAllObjects];
    NSMutableDictionary * gds = [NSMutableDictionary dictionaryWithCapacity:5];
    if(goodsname || cid)
    {
        if (!cid) {
            cid=@"";
        }
        if (!goodsname) {
            goodsname=@"";
        }
        gds=[DataService PostDataService:[NSString stringWithFormat:@"%@api/mobileshopping",domainser] postDatas:[NSString stringWithFormat:@"pid=%@&text=%@",cid,goodsname] forPage:page forPageSize:10];
        NSArray *gdslist=[gds objectForKey:@"datas"];
        [list addObjectsFromArray:gdslist];
    }else{
        gds=[DataService PostDataService:[NSString stringWithFormat:@"%@api/mobileshopping",domainser] postDatas:nil forPage:page forPageSize:10];
        NSArray *gdslist=[gds objectForKey:@"datas"];
        [list addObjectsFromArray:gdslist];
    }
}

//首页跳转
-(IBAction)frontindex:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)passValue:(NSString *)value key:(NSString *)key tag:(NSInteger)tag
{
    cid=value;
    goodsname=key;
    [self loaddata];
    [self.goodscollectionview reloadData];
}

//搜索结果数目
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [list count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    goodslistCell *cell = (goodslistCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"goodslistCell" forIndexPath:indexPath];
    
    NSDictionary *gdsdetail = [list objectAtIndex:[indexPath row]];
    
    cell.nameLabel.text=[NSString stringWithFormat:@"%@",[gdsdetail objectForKey:@"name"]];
    cell.priceLabel.text=[NSString stringWithFormat:@"¥%@",[gdsdetail objectForKey:@"shopPrice"]];
    
    NSString *url=[NSString stringWithFormat:@"%@",[gdsdetail objectForKey:@"goodsThumb"]];
    NSURL *imgUrl=[NSURL URLWithString:url];
    if (hasCachedImage(imgUrl)) {
        [cell.productImage setImage:[UIImage imageWithContentsOfFile:pathForURL(imgUrl)]];
    }else{
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:imgUrl,@"url",cell.productImage,@"imageView",nil];
        [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
    }

    return cell;
}

//点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    goodsDetail *_goodsDetail=[[goodsDetail alloc]init];
    NSDictionary *gdsdetail = [list objectAtIndex:[indexPath row]];
    _goodsDetail.gdsdetail=gdsdetail;
    [self.navigationController pushViewController:_goodsDetail animated:NO];
}

//修改性别
-(IBAction)searchtype:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请选择查询类型" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"按分类查询", @"按名称查询", nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==2) {
        nameforgoods *_nameforgoods=[[nameforgoods alloc]init];
        _nameforgoods.delegate=self;
        [self.navigationController pushViewController:_nameforgoods animated:NO];
    }else if (buttonIndex==1)
    {
        classforgoods *_classforgoods=[[classforgoods alloc]init];
        _classforgoods.delegate=self;
        [self.navigationController pushViewController:_classforgoods animated:NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
