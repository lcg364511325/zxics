//
//  placeorder.h
//  zxics
//
//  Created by johnson on 14-8-8.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPGrowingTextView.h"
#import "CustomIOS7AlertView.h"

@interface placeorder : UIViewController<HPGrowingTextViewDelegate,CustomIOS7AlertViewDelegate>
{
    NSString *shopn;
    NSMutableArray *sendwaylist;
    NSMutableArray *addrlist;
    NSString *swd;
    NSString *ard;
    NSArray *list;
    NSInteger btntag;
    NSInteger paywayvalue;
    NSString *gid;
    HPGrowingTextView *textView;
    NSString *addrid;
    NSString *sendwayid;
    float pricecount;
}
@property (strong, nonatomic) IBOutlet UIView *scview;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property(retain ,nonatomic) NSString *nowcount;//商家id
@property(retain ,nonatomic) NSString *shopid;//商家id
@property(retain ,nonatomic) NSMutableArray *ridlist;//商品id集合
@property (weak, nonatomic) IBOutlet UIScrollView *poSView;
@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UIImageView *pricecountImage;
@property (weak, nonatomic) IBOutlet UILabel *pricecountLabel;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *sendway;
@property (weak, nonatomic) IBOutlet UILabel *shopname;
@property (weak, nonatomic) IBOutlet UILabel *sendwayLabel;
@property (weak, nonatomic) IBOutlet UILabel *addr;
@property (weak, nonatomic) IBOutlet UILabel *addrLabel;
@property (weak, nonatomic) IBOutlet UIButton *changesendwayButton;
@property (weak, nonatomic) IBOutlet UIButton *changeaddrButton;
@property (weak, nonatomic) IBOutlet UIImageView *sendwayImage;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *payway;
@property (weak, nonatomic) IBOutlet UILabel *yikaLabel;
@property (weak, nonatomic) IBOutlet UILabel *zhifuLabel;
@property (weak, nonatomic) IBOutlet UILabel *huodaoLabel;
@property (weak, nonatomic) IBOutlet UIButton *yiButton;
@property (weak, nonatomic) IBOutlet UIButton *zhiButton;
@property (weak, nonatomic) IBOutlet UIButton *huoButton;


@end
