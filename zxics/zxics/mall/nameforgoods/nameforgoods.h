//
//  nameforgoods.h
//  zxics
//
//  Created by johnson on 14-9-9.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewPassValueDelegate.h"

@interface nameforgoods : UIViewController

@property(nonatomic, retain) NSObject<UIViewPassValueDelegate> * delegate; //当前请求过来的对象

@property (weak, nonatomic) IBOutlet UITextField *goodsnameText;
@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@end
