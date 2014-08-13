//
//  filecenterlist.h
//  zxics
//
//  Created by johnson on 14-8-13.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface filecenterlist : UIViewController
{
    NSArray * list;
}
@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UITableView *filecenterTView;

@end
