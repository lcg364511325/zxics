//
//  myappraise.h
//  zxics
//
//  Created by johnson on 14-8-8.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myappraiseCell.h"

@interface myappraise : UIViewController
{
    NSMutableArray * list;
    NSInteger page;
    NSString *searchurl;
    NSMutableArray *btnlist;
}

@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UITableView *assessTView;
@property (weak, nonatomic) IBOutlet UIButton *completeButton;
@end
