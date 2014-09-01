//
//  balancelist.h
//  zxics
//
//  Created by johnson on 14-8-7.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "consumelistCell.h"
#import "consumeDetail.h"
#import "topup.h"

@interface balancelist : UIViewController
{
    NSMutableArray *list;
    NSInteger page;
    NSArray *typelist;
    NSString *tname;
}

@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UITableView *baTView;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@end
