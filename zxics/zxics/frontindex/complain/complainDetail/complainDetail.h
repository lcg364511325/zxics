//
//  complainDetail.h
//  zxics
//
//  Created by johnson on 14-8-5.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface complainDetail : UIViewController

@property(retain , nonatomic) NSDictionary * complaininfo;//投诉信息明细

@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UILabel *complainaboutLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *introduceLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;
@property (weak, nonatomic) IBOutlet UILabel *complainDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *complainstateLabel;
@property (weak, nonatomic) IBOutlet UILabel *dealdateLabel;
@property (weak, nonatomic) IBOutlet UILabel *dealstateLabel;
@end
