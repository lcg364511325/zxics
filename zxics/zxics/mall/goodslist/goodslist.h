//
//  goodslist.h
//  zxics
//
//  Created by johnson on 14-8-11.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTCardLayout.h"


@interface goodslist : UIViewController
{
    NSMutableArray *list;
    NSInteger page;
}

@property(retain , nonatomic) NSString * goodsname;//商品名称
@property(retain , nonatomic) NSString * cid;//分类id

@property (weak, nonatomic) IBOutlet UICollectionView *goodscollectionview;
@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;

@end
