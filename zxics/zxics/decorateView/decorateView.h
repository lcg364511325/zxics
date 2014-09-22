//
//  decorateView.h
//  zhubao_iphone
//
//  Created by johnson on 14-9-11.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XNTabBar.h"

@interface decorateView : UITabBarController<XNTabBarDelegate,UITabBarControllerDelegate,UIApplicationDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITextField *scomtext;
    UITableView *comTView;
    NSMutableArray *list;
    UIButton *settingbtn;
}
@end
