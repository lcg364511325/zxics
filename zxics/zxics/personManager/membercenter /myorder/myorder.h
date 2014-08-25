//
//  myorder.h
//  zxics
//
//  Created by johnson on 14-8-8.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myorderCell.h"
#import "myorderDetail.h"

@interface myorder : UIViewController
{
    NSMutableArray *list;
    NSInteger page;
    NSString *oStatus;
    NSString *pStatus;
}

@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UITableView *myorderTView;
@end
