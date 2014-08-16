//
//  RadioGroup.m
//
//  Created by 凌洛寒 on 14-5-14.
//  Copyright (c) 2014年 凌洛寒. All rights reserved.
//

#import "RadioGroup.h"
#import "RadioBox.h"

@interface RadioGroup ()

- (void)handleSwitchEvent:(id)sender;

@end

@implementation RadioGroup

- (id)initWithFrame:(CGRect)frame WithControl:(NSArray*)controls
{
    self = [super initWithFrame:frame];
    if (self) {
        for (id control in controls) {
            [self addSubview:control];
        }
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self commonInit];
    }
    
    return self;
}

-(void)setTintColor:(UIColor *)tintColor
{
    for (UIView *control in self.subviews) {
        if ([control isKindOfClass:[RadioBox class]]) {
            [(RadioBox*)control setTintColor:tintColor];
        }
    }
}

-(void)setOnTintColor:(UIColor *)onTintColor
{
    for (UIView *control in self.subviews) {
        if ([control isKindOfClass:[RadioBox class]]) {
            [(RadioBox*)control setOnTintColor:onTintColor];
        }
    }
}

-(void)setBoxBgColor:(UIColor *)boxBgColor
{
    for (UIView *control in self.subviews) {
        if ([control isKindOfClass:[RadioBox class]]) {
            [(RadioBox*)control setBoxBgColor:boxBgColor];
        }
    }
}

-(void)setBoxColor:(UIColor *)boxColor
{
    for (UIView *control in self.subviews) {
        if ([control isKindOfClass:[RadioBox class]]) {
            [(RadioBox*)control setBoxColor:boxColor];
        }
    }
}

-(void)setTextColor:(UIColor *)textColor
{
    for (UIView *control in self.subviews) {
        if ([control isKindOfClass:[RadioBox class]]) {
            [(RadioBox*)control setTextColor:textColor];
        }
    }
}

-(void)setTextFont:(UIFont *)textFont
{
    for (UIView *control in self.subviews) {
        if ([control isKindOfClass:[RadioBox class]]) {
            [(RadioBox*)control setTextFont:textFont];
        }
    }
}

- (void)setSelectValue:(NSInteger)selectValue
{
    for (UIView *control in self.subviews) {
        if ([control isKindOfClass:[RadioBox class]]) {
            if (((RadioBox*)control).value == selectValue) {
                [(RadioBox*)control setIsClick:YES];
                [(RadioBox*)control setOn:YES];
            }
        }
    }
}


- (void)commonInit
{
    for (UIView *control in self.subviews) {
        if ([control isKindOfClass:[RadioBox class]]) {
            [(RadioBox*)control addTarget:self action:@selector(handleSwitchEvent:) forControlEvents:UIControlEventValueChanged];
        }
    }
}

- (void)handleSwitchEvent:(id)sender
{
    for (UIView *control in self.subviews) {
        if ([control isKindOfClass:[RadioBox class]]) {
            if (!((RadioBox*)control).isClick) {
                continue;
            }
            if ([self.subviews indexOfObject:control] != [self.subviews indexOfObject:sender]) {
                [(RadioBox*)control setIsClick:NO];
                if (((RadioBox*)control).isOn) {
                    [(RadioBox*)control setOn:NO];
                }
            }
            else
            {
                self.selectText = ((RadioBox*)control).text;
                self.selectValue = ((RadioBox*)control).value;
            }
        }
    }
}

@end
