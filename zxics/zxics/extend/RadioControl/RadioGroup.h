//
//  RadioGroup.h
//
//  Created by 凌洛寒 on 14-5-14.
//  Copyright (c) 2014年 凌洛寒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RadioGroup : UIControl

@property (nonatomic, strong) NSString *selectText;
@property (nonatomic) NSInteger selectValue;

@property (nonatomic, strong) UIColor *onTintColor;
@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic, strong) UIColor *boxColor;
@property (nonatomic, strong) UIColor *boxBgColor;

@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *textFont;


- (id)initWithFrame:(CGRect)frame WithControl:(NSArray*)controls;
@end
