//
//  consultDetail.h
//  zxics
//
//  Created by johnson on 14-8-11.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface consultDetail : UIViewController

@property(retain , nonatomic) NSDictionary * consultinfo;//用户咨询明细

@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *introduceLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdateLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyuserLabel;
@property (weak, nonatomic) IBOutlet UILabel *assessLabel;
@property (weak, nonatomic) IBOutlet UILabel *replydetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *conSView;

@end
