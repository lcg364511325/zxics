//
//  consumelist.h
//  zxics
//
//  Created by johnson on 14-8-7.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "consumelistCell.h"
#import "consumeDetail.h"

@interface consumelist : UIViewController
{
    NSMutableArray *list;
    NSInteger page;
    NSArray *typelist;
    NSString *searchtype;
    NSString *tname;
}
@property(retain , nonatomic) NSString * btntag;//消费停车
@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UINavigationItem *UINavigationItem;
@property (weak, nonatomic) IBOutlet UITableView *consumeTView;
@end
