//
//  classforgoods.h
//  zxics
//
//  Created by johnson on 14-9-9.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface classforgoods : UIViewController
{
    NSMutableArray *list;
}

@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UITableView *classTView;
@end
