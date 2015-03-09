//
//  wyCManagerDetail.h
//  zxics
//
//  Created by johnson on 15-3-6.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPGrowingTextView.h"

@interface wyCManagerDetail : UIViewController<HPGrowingTextViewDelegate>
{
    HPGrowingTextView *rcontentsView;
    NSInteger oldheight;
    UIImageView *borderImage;
    UIScrollView *suview;
    UIButton *replybtn;
    CGRect oldframe;
    CGRect frame;
}

@property(retain , nonatomic)NSString * cid;
@property(retain , nonatomic)NSString * type;


@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@end
