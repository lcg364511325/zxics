//
//  assess.h
//  zxics
//
//  Created by johnson on 14-8-15.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPGrowingTextView.h"

@interface assess : UIViewController<HPGrowingTextViewDelegate>

@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UITextView *assessTextView;
@end
