//
//  download.h
//  zxics
//
//  Created by johnson on 14-8-11.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "downloadCell.h"

@interface download : UIViewController
{
    NSMutableArray *list;
    NSInteger page;
    NSString *cid;
}

@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UITableView *downloadTView;
@end
