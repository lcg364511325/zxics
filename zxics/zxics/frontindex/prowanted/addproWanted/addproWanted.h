//
//  addproWanted.h
//  zxics
//
//  Created by johnson on 14-11-7.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPGrowingTextView.h"

@interface addproWanted : UIViewController<HPGrowingTextViewDelegate>
{
    NSString *coutryid;
    NSString *provinceid;
    NSString *cityid;
    NSString *districtid;
    NSString *areadetail;
    NSString *oldareadetail;
    NSArray *list;
    NSInteger oldtype;
    HPGrowingTextView *textView;
    UIButton *oldbtn;
    NSString *type1;
}


@property (weak, nonatomic) IBOutlet UITextField *titleText;
@property (weak, nonatomic) IBOutlet UITextField *addrText;
@property (weak, nonatomic) IBOutlet UITextField *addrDetailtext;
@property (weak, nonatomic) IBOutlet UITextField *userText;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UITextField *emailtext;
@property (weak, nonatomic) IBOutlet UITextView *detailText;
@property (weak, nonatomic) IBOutlet UITableView *addrTView;
@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;

@end
