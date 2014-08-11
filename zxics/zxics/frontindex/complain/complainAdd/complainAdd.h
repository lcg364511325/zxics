//
//  complainAdd.h
//  zxics
//
//  Created by johnson on 14-8-5.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "complainlist.h"

@interface complainAdd : UIViewController

@property (strong, nonatomic) NSArray *list; //下拉框数据

@property (weak, nonatomic) IBOutlet UITableView *complaintoTview;//投诉对象tableview
@property (weak, nonatomic) IBOutlet UITextField *complaintoText;
@property (weak, nonatomic) IBOutlet UITextField *titleText;
@property (weak, nonatomic) IBOutlet UITextField *introduceText;
@property (weak, nonatomic) IBOutlet UITextField *detailsText;
@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;

@end
