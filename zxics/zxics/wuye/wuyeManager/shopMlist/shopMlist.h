//
//  shopMlist.h
//  zxics
//
//  Created by johnson on 15-3-10.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface shopMlist : UIViewController
{
    NSMutableArray *list;
    NSInteger page;
    NSString *delfag;
    NSString *uid;
    NSString *type;
}

@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UITableView *suTView;

@end
