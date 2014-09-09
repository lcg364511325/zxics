//
//  succourDetail.h
//  zxics
//
//  Created by johnson on 14-9-5.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface succourDetail : UIViewController

@property(retain , nonatomic) NSDictionary * sud;//救助申请详细
@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UIScrollView *suSView;

@end
