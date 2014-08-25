//
//  personfootprintDetail.h
//  zxics
//
//  Created by johnson on 14-8-21.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface personfootprintDetail : UIViewController

@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UIScrollView *pfpSView;

@property(retain , nonatomic) NSDictionary * pfp;//个人日志详情
@property(retain ,nonatomic) NSString *tname;
@property (weak, nonatomic) IBOutlet UILabel *cartnoLabel;
@property (weak, nonatomic) IBOutlet UILabel *terminalLabel;
@property (weak, nonatomic) IBOutlet UILabel *terminalnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *terminaltypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *footDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *accountLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *childtypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneylabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *runLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end
