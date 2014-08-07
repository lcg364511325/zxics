//
//  myLabel.h
//  zxics
//
//  Created by johnson on 14-8-5.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MyLabel;
@protocol MyLabelDelegate <NSObject>
@required
- (void)myLabel:(MyLabel *)myLabel touchesWtihTag:(NSInteger)tag;
@end

@interface MyLabel : UILabel {
    __unsafe_unretained id<MyLabelDelegate> delegate;
}
@property (nonatomic, assign) id <MyLabelDelegate> delegate;
- (id)initWithFrame:(CGRect)frame;
@end