//
//  chargeQPersonList.h
//  zxics
//
//  Created by johnson on 15-3-13.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface chargeQPersonList : UIViewController
{
    NSMutableArray *list;
    NSInteger page;
    NSString *cid;
    NSInteger isfirst;
}

@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UITableView *suTView;
@property (weak, nonatomic) IBOutlet UITextField *cnoText;
@property (weak, nonatomic) IBOutlet UITextField *cpersonText;


@end
