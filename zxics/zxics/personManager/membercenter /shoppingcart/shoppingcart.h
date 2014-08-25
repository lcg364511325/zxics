//
//  shoppingcart.h
//  zxics
//
//  Created by johnson on 14-8-8.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "shoppingcartCell.h"
#import "CustomIOS7AlertView.h"

@interface shoppingcart : UIViewController<CustomIOS7AlertViewDelegate>
{
    NSMutableArray *list;
    NSInteger page;
    NSInteger rid;
    NSMutableArray *ridlist;
    NSString *orgid;
}

@property (weak, nonatomic) IBOutlet UITextField *goodscount;
@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UITableView *scTView;
@property (strong, nonatomic) IBOutlet UIView *secondView;
@end
