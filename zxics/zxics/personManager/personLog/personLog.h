//
//  personLog.h
//  zxics
//
//  Created by johnson on 14-8-7.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "personlogCellTableViewCell.h"
#import "personLogDetail.h"

@interface personLog : UIViewController
{
    NSMutableArray *list;
    NSInteger page;
}

@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UITableView *personlogTView;
@end
