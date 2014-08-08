//
//  consumelist.h
//  zxics
//
//  Created by johnson on 14-8-7.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "consumelistCell.h"
#import "consumeDetail.h"

@interface consumelist : UIViewController

@property(retain , nonatomic) NSString * btntag;//消费停车
@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UINavigationItem *UINavigationItem;
@end
