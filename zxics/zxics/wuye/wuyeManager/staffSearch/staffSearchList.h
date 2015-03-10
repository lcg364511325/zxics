//
//  staffSearchList.h
//  zxics
//
//  Created by johnson on 15-3-10.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface staffSearchList : UIViewController
{
    NSMutableArray *list;
    NSInteger page;
    NSString *searchtype;
    NSString *front_communityid;
    NSString *name;
    NSString *codeid;
    NSString *mobile;
    NSString *username;
    NSString *cardcode;
    NSString *account;
    NSString *communityid;
    NSString *floorid;
}

@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UITableView *suTView;

@end
