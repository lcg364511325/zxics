//
//  addelectric.h
//  zxics
//
//  Created by johnson on 14-9-5.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface addelectric : UIViewController<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>
{
    NSInteger picno;
    NSMutableArray *piclist;
    UIPopoverController *popoverController;
}
@property (weak, nonatomic) IBOutlet UINavigationBar *UINavigationBar;
@property (weak, nonatomic) IBOutlet UITextField *countText;

@property (strong, nonatomic) UIAlertView *alter;//弹出提示框

@end
