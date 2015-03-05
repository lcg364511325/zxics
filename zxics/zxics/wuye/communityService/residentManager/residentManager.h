//
//  residentManager.h
//  zxics
//
//  Created by johnson on 15-3-3.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewPassValueDelegate.h"

@interface residentManager : UIViewController
{
    NSMutableArray *list;
    NSInteger page;
    NSInteger isfirst;
    NSString *comid;
    NSString *comname;
}

@property(nonatomic, retain) NSObject<UIViewPassValueDelegate> * delegate; //当前请求过来的对象
@property(retain,nonatomic)NSString *type;

@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UITableView *suTView;

@end
