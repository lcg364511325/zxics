//
//  myorderDetail.h
//  zxics
//
//  Created by johnson on 14-8-8.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myorderDetail : UIViewController<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UIScrollView *orderscrollview;
@property (strong, nonatomic) IBOutlet UIView *secondview;
@end
