//
//  conservationPeopleDetail.h
//  zxics
//
//  Created by johnson on 15-3-9.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface conservationPeopleDetail : UIViewController

@property(retain , nonatomic)NSString * uid;

@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UIImageView *borderImage;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *cardTypeLable;
@property (weak, nonatomic) IBOutlet UILabel *cardnoLable;
@property (weak, nonatomic) IBOutlet UILabel *sexLable;
@property (weak, nonatomic) IBOutlet UILabel *mobileLable;
@property (weak, nonatomic) IBOutlet UILabel *blockcodeLable;
@property (weak, nonatomic) IBOutlet UILabel *wulinoLable;
@property (weak, nonatomic) IBOutlet UILabel *stateLable;
@property (weak, nonatomic) IBOutlet UILabel *blockTypeLable;
@property (weak, nonatomic) IBOutlet UILabel *stimeLable;
@property (weak, nonatomic) IBOutlet UILabel *cnameLable;
@property (weak, nonatomic) IBOutlet UILabel *floornameLable;

@end
