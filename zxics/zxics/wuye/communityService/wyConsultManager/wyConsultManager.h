//
//  wyConsultManager.h
//  zxics
//
//  Created by johnson on 15-3-5.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface wyConsultManager : UIViewController
{
    NSMutableArray *list;
    NSInteger page;
    NSString *flag;
}

@property(retain , nonatomic)NSString * type;

@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UITableView *suTView;
@end
