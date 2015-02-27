//
//  cpdetali.h
//  zxics
//
//  Created by johnson on 14-8-5.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cpdetali : UIViewController

@property(retain , nonatomic) NSDictionary * cpd;//社区活动，物业通知详细
@property(retain , nonatomic) NSString * cid;//社区活动，物业通知详细

@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *contentLable;
@property (weak, nonatomic) IBOutlet UILabel *othercontentLabel;
@property (weak, nonatomic) IBOutlet UILabel *orgLabel;
@property (weak, nonatomic) IBOutlet UILabel *dataLabel;
@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UINavigationItem *UINavigationItem;
@property (weak, nonatomic) IBOutlet UIScrollView *cpScrollview;
@property (weak, nonatomic) IBOutlet UIImageView *borderImage;

@end
