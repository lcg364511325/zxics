//
//  editConservationPeople.h
//  zxics
//
//  Created by johnson on 15-3-9.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomIOS7AlertView.h"

@interface editConservationPeople : UIViewController<CustomIOS7AlertViewDelegate>
{
    UIDatePicker *datePickerView;
    NSArray *list;
    NSString *ids;
    NSString *cid;
    NSString *fid;
    NSDictionary *user;
    NSString* backstate;
    NSDictionary *myTypeDict;
}

@property(retain,nonatomic)NSString *uid;

@property (weak, nonatomic) IBOutlet UINavigationItem *UINavigationItem;
@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *cardtypeText;
@property (weak, nonatomic) IBOutlet UITextField *cardnoText;
@property (weak, nonatomic) IBOutlet UITextField *mobileText;
@property (weak, nonatomic) IBOutlet UITextField *signtimeText;
@property (weak, nonatomic) IBOutlet UITextField *cnameText;
@property (weak, nonatomic) IBOutlet UITextField *floornameText;
@property (weak, nonatomic) IBOutlet UITextField *blockcodeText;
@property (weak, nonatomic) IBOutlet UITableView *cardtypeView;
@end
