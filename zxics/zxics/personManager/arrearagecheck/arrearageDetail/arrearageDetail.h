//
//  arrearageDetail.h
//  zxics
//
//  Created by johnson on 14-8-7.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Paymentfunction.h"

@interface arrearageDetail : UIViewController

@property(retain , nonatomic) NSDictionary * acc;//收费记录详情
@property(retain ,nonatomic) NSString *tname;
@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UIScrollView *accSView;
@property (weak, nonatomic) IBOutlet UILabel *batchLabel;
@property (weak, nonatomic) IBOutlet UILabel *orgnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *floornameLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *chargenameLabel;
@property (weak, nonatomic) IBOutlet UILabel *chargetypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *chargewayLabel;
@property (weak, nonatomic) IBOutlet UILabel *areamoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *operTLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *chargenoLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *paymoney;

@end
