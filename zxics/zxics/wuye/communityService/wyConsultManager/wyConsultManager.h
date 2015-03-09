//
//  wyConsultManager.h
//  zxics
//
//  Created by johnson on 15-3-5.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface wyConsultManager : UIViewController
{
    NSMutableArray *list;
    NSInteger page;
    NSString *flag;
    NSInteger mid;
    NSArray* btnlist;
}

@property(retain , nonatomic)NSString * type;

@property (weak, nonatomic) IBOutlet UINavigationItem *UINavigationItem;
@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UITableView *suTView;
@property (weak, nonatomic) IBOutlet UIButton *undealBtn;
@property (weak, nonatomic) IBOutlet UIButton *dealBtn;
@property (weak, nonatomic) IBOutlet UIButton *somedealBtn;
@property (weak, nonatomic) IBOutlet UIButton *notDealBtn;
@end
