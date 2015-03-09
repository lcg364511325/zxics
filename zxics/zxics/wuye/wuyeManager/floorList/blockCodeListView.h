//
//  blockCodeListView.h
//  zxics
//
//  Created by johnson on 15-3-9.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewPassValueDelegate.h"

@interface blockCodeListView : UIViewController
{
    NSMutableArray *list;
    NSInteger page;
    NSString *pname;
    NSMutableArray *selectedlist;
    NSMutableArray *selectedlistid;
    NSString *ids;
}

@property(nonatomic, retain) NSObject<UIViewPassValueDelegate> * delegate; //当前请求过来的对象
@property(retain,nonatomic)NSString *cid;

@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UITableView *suTView;

@end
