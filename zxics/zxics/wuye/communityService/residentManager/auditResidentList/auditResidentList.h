//
//  auditResidentList.h
//  zxics
//
//  Created by johnson on 15-3-4.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface auditResidentList : UIViewController
{
    NSMutableArray *list;
    NSInteger page;
    NSString *comid;
    NSInteger seteduid;
}

@property(retain , nonatomic)NSString * cid;
@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UITableView *suTView;

@end
