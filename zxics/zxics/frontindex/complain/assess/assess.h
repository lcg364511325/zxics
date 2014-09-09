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
{
    NSString *assessvalue;
    NSMutableArray *btnlist;
    HPGrowingTextView *textView;
}

@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property(retain , nonatomic) NSString * mid;//投诉信息id
@end
