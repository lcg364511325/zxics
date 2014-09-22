//
//  Vicecardlist.h
//  zxics
//
//  Created by johnson on 14-9-22.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "communityCell.h"
#import "VicecardDetail.h"
#import "vicecardadd.h"

@interface Vicecardlist : UIViewController
{
    NSMutableArray *list;
    NSInteger page;
}

@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UITableView *vicecTView;
@property (weak, nonatomic) IBOutlet UILabel *cardnoLabel;

@end
