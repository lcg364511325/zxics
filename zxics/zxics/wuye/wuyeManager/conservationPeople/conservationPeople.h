//
//  conservationPeople.h
//  zxics
//
//  Created by johnson on 15-3-9.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface conservationPeople : UIViewController
{
    NSMutableArray *list;
    NSInteger page;
    NSString *username;
    NSString *userphone;
    NSString *stime;
    NSString *etime;
    NSString *blockcode;
    NSInteger isfirst;
}

@property (weak, nonatomic) IBOutlet UINavigationItem *UINavigationItem;
@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UITableView *suTView;

@end
