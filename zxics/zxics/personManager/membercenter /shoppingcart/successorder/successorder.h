//
//  successorder.h
//  zxics
//
//  Created by johnson on 14-8-27.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface successorder : UIViewController

@property(retain , nonatomic) NSDictionary * so;//订单生成返回信息
@property(retain , nonatomic) NSString * price;//订单价格
@property(retain , nonatomic) NSString * sendway;//支付方式

@property (weak, nonatomic) IBOutlet UILabel *ordernoLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UIButton *payButton;
@property (weak, nonatomic) IBOutlet UIButton *checkorderButton;

@end
