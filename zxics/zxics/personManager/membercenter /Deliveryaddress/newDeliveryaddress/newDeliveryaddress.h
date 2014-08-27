//
//  newDeliveryaddress.h
//  zxics
//
//  Created by johnson on 14-8-8.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface newDeliveryaddress : UIViewController
{
    NSArray *list;
    NSString *areadetail;
    NSString *coutryid;
    NSString *provinceid;
    NSString *cityid;
    NSString *districtid;
}

@property (weak, nonatomic) IBOutlet UITableView *ndTView;
@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UIButton *addrselectButton;
@property (weak, nonatomic) IBOutlet UITextField *areaText;
@property (weak, nonatomic) IBOutlet UITextField *addrdetailText;
@property (weak, nonatomic) IBOutlet UITextField *zipcodeText;
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@end
