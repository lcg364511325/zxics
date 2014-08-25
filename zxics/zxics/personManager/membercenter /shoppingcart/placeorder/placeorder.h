//
//  placeorder.h
//  zxics
//
//  Created by johnson on 14-8-8.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface placeorder : UIViewController
{
    NSString *shopn;
}

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


@end
