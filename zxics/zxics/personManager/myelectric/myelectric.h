//
//  myelectric.h
//  zxics
//
//  Created by johnson on 14-9-5.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myelectric : UIViewController
{
    NSMutableArray *list;
    NSInteger page;
}

@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UITableView *meTView;
@end
