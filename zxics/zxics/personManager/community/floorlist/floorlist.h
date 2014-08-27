//
//  floorlist.h
//  zxics
//
//  Created by johnson on 14-8-9.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "communityCell.h"

@interface floorlist : UIViewController<UIAlertViewDelegate>
{
    NSMutableArray *list;
    NSInteger page;
    NSString *fid;
}

@property(retain , nonatomic) NSString * cid;//社区id

@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UITableView *floorTView;
@end
