//
//  conservationSearch.h
//  zxics
//
//  Created by johnson on 15-3-10.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomIOS7AlertView.h"
#import "UIViewPassValueDelegate.h"

@interface conservationSearch : UIViewController<CustomIOS7AlertViewDelegate>
{
    UIDatePicker *datePickerView;
    NSInteger timetype;
}

@property(nonatomic, retain) NSObject<UIViewPassValueDelegate> * delegate; //当前请求过来的对象

@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *cardnoText;
@property (weak, nonatomic) IBOutlet UITextField *mobileText;
@property (weak, nonatomic) IBOutlet UITextField *stimeText;
@property (weak, nonatomic) IBOutlet UITextField *etimeText;
@end
