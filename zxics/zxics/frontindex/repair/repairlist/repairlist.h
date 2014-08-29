//
//  repairlist.h
//  zxics
//
//  Created by johnson on 14-8-6.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "repairlistCell.h"
#import "repairadd.h"

@interface repairlist : UIViewController
{
    NSString *source;
    NSMutableArray *list;
    NSInteger page;
}
@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UITableView *repairTView;
@property (weak, nonatomic) IBOutlet UIButton *allButton;
@property (weak, nonatomic) IBOutlet UIButton *state1button;
@property (weak, nonatomic) IBOutlet UIButton *state2Button;
@property (weak, nonatomic) IBOutlet UIButton *state3Button;
@property (weak, nonatomic) IBOutlet UIButton *state4Button;
@property (weak, nonatomic) IBOutlet UIButton *state5Button;

@end
