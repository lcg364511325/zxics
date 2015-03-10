//
//  staffSearchType.h
//  zxics
//
//  Created by johnson on 15-3-10.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewPassValueDelegate.h"

@interface staffSearchType : UIViewController
{
    UILabel *firstLable;
    UILabel *secondLable;
    UILabel *thirdLable;
    UITextField *fristText;
    UITextField *secondText;
    UITextField *thirdText;
    UIButton *firstBtn;
    UIButton *secondBtn;
    NSString *cid;
    NSString *fid;
}

@property(nonatomic, retain) NSObject<UIViewPassValueDelegate> * delegate; //当前请求过来的对象


@property(retain , nonatomic)NSString * type;

@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UINavigationItem *UINavigationItem;
@end
