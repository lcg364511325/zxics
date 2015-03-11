//
//  myFloorList.h
//  zxics
//
//  Created by johnson on 15-3-11.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewPassValueDelegate.h"

@interface myFloorList : UIViewController
{
    NSMutableArray *list;
    NSInteger page;
    NSString *pid;
    NSString *hname;
    NSString *hid;
    NSString *oldpid;
}

@property(nonatomic, retain) NSObject<UIViewPassValueDelegate> * delegate; //当前请求过来的对象
@property(retain,nonatomic)NSString *cid;

@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UITableView *suTView;

@end
