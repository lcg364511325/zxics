//
//  yikatong.h
//  zxics
//
//  Created by johnson on 14-8-27.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface yikatong : UIViewController

@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property(retain , nonatomic) NSString * price;//订单价格
@property(retain , nonatomic) NSString * orderid;//订单号
@property (weak, nonatomic) IBOutlet UILabel *ordernoLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UITextField *cardidText;
@property (weak, nonatomic) IBOutlet UITextField *accountLabel;
@property (weak, nonatomic) IBOutlet UITextField *pwdLabel;

@end
