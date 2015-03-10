//
//  shopMlistDetail.h
//  zxics
//
//  Created by johnson on 15-3-10.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWPhotoBrowser.h"

@interface shopMlistDetail : UIViewController<MWPhotoBrowserDelegate>
{
    NSDictionary *data;
    NSArray *imglist;
}

@property(retain , nonatomic)NSString * pid;

@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UIWebView *contentview;
@property (weak, nonatomic) IBOutlet UIScrollView *goodsimageSView;
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;
@property (weak, nonatomic) IBOutlet UIButton *introduceBtn;

@property (nonatomic, strong) NSMutableArray *photos;

@end
