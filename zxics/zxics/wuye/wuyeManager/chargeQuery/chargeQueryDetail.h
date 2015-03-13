//
//  chargeQueryDetail.h
//  zxics
//
//  Created by johnson on 15-3-13.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTCardLayout.h"
#import "UICollectionView+CardLayout.h"
#import "LSCollectionViewLayoutHelper.h"
#import "UICollectionView+Draggable.h"

@interface chargeQueryDetail : UIViewController<UICollectionViewDataSource_Draggable>
{
    NSMutableArray *list;
    NSInteger page;
}

@property(retain , nonatomic)NSDictionary * rdetail;

@property (weak, nonatomic) IBOutlet UICollectionView *goodscollectionview;
@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;

@property (weak, nonatomic) IBOutlet UIButton *appBtn;
@property (weak, nonatomic) IBOutlet UILabel *cnoLable;
@property (weak, nonatomic) IBOutlet UILabel *payuserLable;
@property (weak, nonatomic) IBOutlet UILabel *userphoneLable;
@property (weak, nonatomic) IBOutlet UILabel *paydateLable;
@property (weak, nonatomic) IBOutlet UILabel *paytypeLable;
@property (weak, nonatomic) IBOutlet UILabel *paycountLable;
@property (weak, nonatomic) IBOutlet UILabel *floorLable;
@property (weak, nonatomic) IBOutlet UILabel *detailLable;
@end
