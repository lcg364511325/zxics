//
//  lifemdDetail.h
//  zxics
//
//  Created by johnson on 14-8-5.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myLabel.h"

@interface lifemdDetail : UIViewController

@property(retain , nonatomic) NSDictionary * Project_communityorgs;//生活管家信息明细


@property (weak, nonatomic) IBOutlet UIScrollView *lfmdscrollview;
@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UILabel *orgLabel;
@property (weak, nonatomic) IBOutlet UILabel *urlLabel;
@property (weak, nonatomic) IBOutlet UILabel *addrLabel;
@property (weak, nonatomic) IBOutlet UILabel *addrdetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *telLabel;
@property (weak, nonatomic) IBOutlet UILabel *businessLabel;
@property (weak, nonatomic) IBOutlet UILabel *contectpeopleLabel;
@property (weak, nonatomic) IBOutlet UILabel *introduceLabel;
@property (weak, nonatomic) IBOutlet UILabel *DetailsLabel;
@property (weak, nonatomic) IBOutlet UILabel *lifeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end
