//
//  classforgoods.h
//  zxics
//
//  Created by johnson on 14-9-9.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewPassValueDelegate.h"

@interface classforgoods : UIViewController
{
    NSMutableArray *list;
}

@property(nonatomic, retain) NSObject<UIViewPassValueDelegate> * delegate; //当前请求过来的对象

@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UITableView *classTView;
@end
