//
//  complainDetail.h
//  zxics
//
//  Created by johnson on 14-8-5.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface complainDetail : UIViewController
{
    UIButton *assessbutton;//评价按钮
}

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
@property (weak, nonatomic) IBOutlet UIScrollView *comscrollview;
@property (weak, nonatomic) IBOutlet UILabel *replycontentLabel;
@property (weak, nonatomic) IBOutlet UILabel *replydataLabel;
@property (weak, nonatomic) IBOutlet UILabel *assessLabel;
@property (weak, nonatomic) IBOutlet UILabel *assessdetailLabel;
@end
