//
//  SpecialPeopleDetail.h
//  zxics
//
//  Created by johnson on 14-8-5.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpecialPeopleDetailCell.h"
#import "SpecialPeople.h"
#import "SpecialPeopleIntroduce.h"

@interface SpecialPeopleDetail : UIViewController
{
    NSMutableArray * list;
    NSString *caid;
    NSInteger page;

}

@property(retain , nonatomic) NSString * spdbtntag;//按钮tag，判断是那个按钮被点击了
@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UINavigationItem *UINavigationItem;
@property (weak, nonatomic) IBOutlet UITableView *specialtableview;

@end
