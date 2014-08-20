//
//  repairadd.h
//  zxics
//
//  Created by johnson on 14-8-6.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomIOS7AlertView.h"
#import "repairlist.h"

@interface repairadd : UIViewController<CustomIOS7AlertViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>
{
    UIDatePicker *datePickerView;
    UIPopoverController *popoverController;
    NSArray *list;
    NSMutableArray *piclist;
    NSString *typevalue;
}

@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UITextField *titleText;
@property (weak, nonatomic) IBOutlet UITextField *typeText;
@property (weak, nonatomic) IBOutlet UITextField *dateText;
@property (weak, nonatomic) IBOutlet UITextField *detailsText;
@property (weak, nonatomic) IBOutlet UITableView *repairtypeTView;

@end
