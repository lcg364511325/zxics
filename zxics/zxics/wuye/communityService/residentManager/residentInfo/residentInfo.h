//
//  residentInfo.h
//  zxics
//
//  Created by johnson on 15-3-3.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface residentInfo : UIViewController
{
    NSMutableArray *list;
    NSInteger page;
    NSInteger isfirst;
}
@property(retain , nonatomic)NSString * cid;
@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UITableView *suTView;

@end
