//
//  changecom.h
//  zxics
//
//  Created by johnson on 14-8-9.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface changecom : UIViewController
{
    NSMutableArray *list;
    NSInteger page;
}

@property(retain , nonatomic) NSString * ispersoninfo;//是否从个人信息进来

@property (weak, nonatomic) IBOutlet UILabel *comLabel;
@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UITableView *changecomTView;
@end
