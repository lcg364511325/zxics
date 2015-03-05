//
//  wuyeNoticeDetail.h
//  zxics
//
//  Created by johnson on 15-3-5.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface wuyeNoticeDetail : UIViewController

@property(retain , nonatomic)NSString * cid;
@property(retain,nonatomic)NSString *type;

@property (weak, nonatomic) IBOutlet UINavigationItem *UINavigationItem;
@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIWebView *detailWeb;

@end
