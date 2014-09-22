//
//  XNTabBar.h
//  toolbar
//
//  Created by johnson on 14-9-11.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XNTabBar;

@protocol XNTabBarDelegate <NSObject>
/**
 *  工具栏按钮被选中, 记录从哪里跳转到哪里. (方便以后做相应特效)
 */
- (void) tabBar:(XNTabBar *)tabBar selectedFrom:(NSInteger) from to:(NSInteger)to;

@end

@interface XNTabBar : UIView

@property(nonatomic,weak) id<XNTabBarDelegate> delegate;
/**
 *  使用特定图片来创建按钮, 这样做的好处就是可扩展性. 拿到别的项目里面去也能换图片直接用
 *
 *  @param image         普通状态下的图片
 *  @param selectedImage 选中状态下的图片
 */
-(void)addButtonWithImage:(UIImage *)image selectedImage:(UIImage *) selectedImage;

@end
