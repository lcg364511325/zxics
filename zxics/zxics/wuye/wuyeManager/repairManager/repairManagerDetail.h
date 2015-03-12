//
//  repairManagerDetail.h
//  zxics
//
//  Created by johnson on 15-3-11.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWPhotoBrowser.h"
#import "CustomIOS7AlertView.h"

@interface repairManagerDetail : UIViewController<MWPhotoBrowserDelegate,CustomIOS7AlertViewDelegate,UITextFieldDelegate>
{
    UILabel *firstLable;
    UILabel *secondLable;
    UILabel *thirdLable;
    UILabel *fourthLable;
    UITextField *fristText;
    UITextField *secondText;
    UITextField *thirdText;
    UITextField *fourthText;
    NSArray *imglist;
    NSString *rstatus;
    NSMutableDictionary * rdtetailnow;
    UIDatePicker *datePickerView;
    CGRect oldframe;
    CGRect frame;
}

@property(retain , nonatomic)NSDictionary * rdetail;

@property (weak, nonatomic) IBOutlet UIScrollView *imgSview;
@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UIScrollView *suSview;

@property (nonatomic, strong) NSMutableArray *photos;

@end
