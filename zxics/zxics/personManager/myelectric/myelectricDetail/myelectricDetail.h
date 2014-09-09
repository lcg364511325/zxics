//
//  myelectricDetail.h
//  zxics
//
//  Created by johnson on 14-9-5.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWPhotoBrowser.h"

@interface myelectricDetail : UIViewController<MWPhotoBrowserDelegate>
{
    NSMutableArray *imglist;
}

@property(retain , nonatomic) NSDictionary * me;//发电详情

@property (weak, nonatomic) IBOutlet UIImageView *pic1;
@property (weak, nonatomic) IBOutlet UIImageView *pic2;
@property (weak, nonatomic) IBOutlet UIScrollView *medSView;
@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;

@property (nonatomic, strong) NSMutableArray *photos;

@end
