//
//  surveyDetail.h
//  zxics
//
//  Created by johnson on 14-8-16.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface surveyDetail : UIViewController

@property(retain , nonatomic) NSString * sid;//在线调查id

@property(retain , nonatomic) NSString * style;//参与还是查看

@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UINavigationItem *UINavigationItem;
@property (weak, nonatomic) IBOutlet UIWebView *surveyWView;

@end
