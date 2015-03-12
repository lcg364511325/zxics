//
//  repairManagerList.h
//  zxics
//
//  Created by johnson on 15-3-11.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface repairManagerList : UIViewController
{
    NSMutableArray *list;
    NSArray *btnlist;
    NSInteger page;
    NSString *cid;
    NSString *type;
    NSInteger isfirst;
}

@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UITableView *suTView;

@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;
@property (weak, nonatomic) IBOutlet UIButton *thirdBtn;
@property (weak, nonatomic) IBOutlet UIButton *fourthBtn;
@end
