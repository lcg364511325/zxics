//
//  threeLineBtnCell.h
//  zxics
//
//  Created by johnson on 15-3-4.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface threeLineBtnCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *deletebtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLabal;
@property (weak, nonatomic) IBOutlet UILabel *mobileLabel;
@property (weak, nonatomic) IBOutlet UILabel *addrLabal;
@property (weak, nonatomic) IBOutlet UIImageView *borderImage;

@end
