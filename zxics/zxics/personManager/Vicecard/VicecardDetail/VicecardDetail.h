//
//  VicecardDetail.h
//  zxics
//
//  Created by johnson on 14-8-9.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VicecardDetail : UIViewController

@property(retain , nonatomic) NSDictionary * vcdetail;//副卡详情

@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *accountLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardnoLabel;
@property (weak, nonatomic) IBOutlet UILabel *personnoLabel;
@property (weak, nonatomic) IBOutlet UILabel *mobileLabel;
@property (weak, nonatomic) IBOutlet UILabel *addtimeLabel;

@end
