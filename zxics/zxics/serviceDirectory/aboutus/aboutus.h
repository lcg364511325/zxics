//
//  aboutus.h
//  zxics
//
//  Created by johnson on 14-8-11.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface aboutus : UIViewController
{
    NSString *appurl;
    NSString *isupdate;
    NSString *isExit;
}
@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UILabel *versonnoLabel;

@end
