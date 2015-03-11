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
    NSInteger ctype;
    NSInteger oldtag;
    NSString *front_communityid;
    NSString *name;
    NSString *codeid;
    NSString *mobile;
    NSString *username;
    NSString *cardcode;
    NSString *account;
    NSString *communityid;
    NSString *floorid;
    NSArray *btnlist;
    UIButton *cardbtn;
    UIButton *personbtn;
    NSMutableDictionary * pw;
}

@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UITableView *suTView;
@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;
@property (weak, nonatomic) IBOutlet UIButton *thridBtn;
@property (weak, nonatomic) IBOutlet UIImageView *btnbgImg;

@end
