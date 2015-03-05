//
//  wuyeNoticeEdit.h
//  zxics
//
//  Created by johnson on 15-3-5.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPGrowingTextView.h"

@interface wuyeNoticeEdit : UIViewController<HPGrowingTextViewDelegate>
{
    HPGrowingTextView *detailView;
    HPGrowingTextView *orderView;
    NSInteger oldheight;
    NSString *comid;
}

@property(retain,nonatomic)NSString *type;
@property(retain,nonatomic)NSString *cid;

@property (weak, nonatomic) IBOutlet UINavigationItem *UINavigationItem;
@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderLabel;
@property (weak, nonatomic) IBOutlet UITextField *titleText;
@property (weak, nonatomic) IBOutlet UITextField *communityText;
@end
