//
//  shoppingcartCell.m
//  zxics
//
//  Created by johnson on 14-8-8.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "shoppingcartCell.h"

@implementation shoppingcartCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(IBAction)selected:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    btn.backgroundColor=[UIColor redColor];
}

@end
