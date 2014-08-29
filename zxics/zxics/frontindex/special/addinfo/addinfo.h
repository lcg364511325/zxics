//
//  addinfo.h
//  zxics
//
//  Created by johnson on 14-8-28.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPGrowingTextView.h"

@interface addinfo : UIViewController<HPGrowingTextViewDelegate>
{
    HPGrowingTextView *textView;
}

@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UITextField *titleText;
@end
