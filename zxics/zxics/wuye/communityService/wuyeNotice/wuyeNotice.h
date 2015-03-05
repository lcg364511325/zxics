//
//  wuyeNotice.h
//  zxics
//
//  Created by johnson on 15-3-5.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface wuyeNotice : UIViewController
{
    NSMutableArray *list;
    NSInteger page;
    NSString *uid;
    NSString *delfag;
    NSInteger isfirst;
}

@property(retain , nonatomic)NSString * cid;

@property (weak, nonatomic) IBOutlet UINavigationItem *UINavigationItem;
@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UITableView *suTView;
@end
