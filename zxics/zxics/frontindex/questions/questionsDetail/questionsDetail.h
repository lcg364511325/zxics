//
//  questionsDetail.h
//  zxics
//
//  Created by johnson on 14-8-20.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface questionsDetail : UIViewController

@property(retain , nonatomic) NSDictionary * qtd;//招商信息明细

@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UIScrollView *qtSView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIWebView *contentsLabel;

@end
