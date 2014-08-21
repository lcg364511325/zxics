//
//  personInfo.h
//  zxics
//
//  Created by johnson on 14-8-6.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "personIndex.h"
#import "updateinfo.h"

@interface personInfo : UIViewController<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,CustomIOS7AlertViewDelegate>
{
    UIPopoverController *popoverController;
    NSMutableArray *piclist;
    UIDatePicker *datePickerView;
}

@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UIImageView *userimage;
@property (weak, nonatomic) IBOutlet UILabel *personnoLabel;
@property (weak, nonatomic) IBOutlet UILabel *cartnoLabel;
@property (weak, nonatomic) IBOutlet UILabel *accountLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *qqLabel;
@property (weak, nonatomic) IBOutlet UILabel *comLabel;
@property (weak, nonatomic) IBOutlet UILabel *addrLabel;

@end
