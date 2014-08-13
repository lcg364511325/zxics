//
//  filecenterDetail.h
//  zxics
//
//  Created by johnson on 14-8-13.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface filecenterDetail : UIViewController

@property(retain , nonatomic) NSString * fid;//文件中心id

@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UIWebView *filecenterWView;

@end
