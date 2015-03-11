//
//  repairManagerDetail.h
//  zxics
//
//  Created by johnson on 15-3-11.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface repairManagerDetail : UIViewController
{
    UILabel *firstLable;
    UILabel *secondLable;
    UILabel *thirdLable;
    UILabel *fourthLable;
    UITextField *fristText;
    UITextField *secondText;
    UITextField *thirdText;
    UITextField *fourthText;
}

@property(retain , nonatomic)NSDictionary * rdetail;

@property (weak, nonatomic) IBOutlet UIScrollView *imgSview;
@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UIScrollView *suSview;

@end
