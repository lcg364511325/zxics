//
//  Deliveryaddress.h
//  zxics
//
//  Created by johnson on 14-8-8.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Deliveryaddress : UIViewController<UIAlertViewDelegate>
{
    NSArray *arlist;
    NSString *rid;
}

@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UITableView *daTView;
@end
