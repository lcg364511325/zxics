//
//  myorderDetail.h
//  zxics
//
//  Created by johnson on 14-8-8.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myorderDetail : UIViewController<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UIScrollView *orderscrollview;
@property (strong, nonatomic) IBOutlet UIView *secondview;

@property(retain ,nonatomic) NSString *orderid;
@property (weak, nonatomic) IBOutlet UILabel *customernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *consigneeLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderCtimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *consigneephoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *paywayLabel;
@property (weak, nonatomic) IBOutlet UILabel *zipcodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *consigneezipcodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *distributionwayLabel;
@property (weak, nonatomic) IBOutlet UILabel *distributionchargeLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderaffirmLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderpayTLabel;
@property (weak, nonatomic) IBOutlet UILabel *ordersendTLabel;
@property (weak, nonatomic) IBOutlet UILabel *consigneeaddrLabel;
@property (weak, nonatomic) IBOutlet UILabel *shipperLabel;
@property (weak, nonatomic) IBOutlet UILabel *shipperconLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderdetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsnoLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodscountLabel;
@property (weak, nonatomic) IBOutlet UILabel *shoppriLabel;
@property (weak, nonatomic) IBOutlet UILabel *marketpriLabel;
@property (weak, nonatomic) IBOutlet UILabel *isreadLabel;
@property (weak, nonatomic) IBOutlet UILabel *issendLabel;
@property (weak, nonatomic) IBOutlet UIButton *paybutton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@end
