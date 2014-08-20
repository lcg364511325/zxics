//
//  rentorshelllist.h
//  zxics
//
//  Created by johnson on 14-8-11.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface rentorshelllist : UIViewController
{
    NSMutableArray *list;
    NSInteger page;
}
@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UINavigationItem *UINavigationItem;
@property (weak, nonatomic) IBOutlet UITableView *rsTView;

@property(retain , nonatomic) NSString * btntag;//出租出售
@end
