//
//  cplist.h
//  zxics
//
//  Created by johnson on 14-8-5.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cplistCell.h"
#import "cpdetali.h"

@interface cplist : UIViewController

@property(retain , nonatomic) NSString * btntag;//社区物业
@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UINavigationItem *UINavigationItem;

@end
