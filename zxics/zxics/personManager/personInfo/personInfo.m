    //
//  personInfo.m
//  zxics
//
//  Created by johnson on 14-8-6.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "personInfo.h"
#import "AppDelegate.h"
#import "DataService.h"
#import "Commons.h"
#import "ImageCacher.h"
#import "changecom.h"
#import "updatepassword.h"

@interface personInfo ()

@end

@implementation personInfo

@synthesize UINavigationBar;
@synthesize userimage;
@synthesize personnoLabel;
@synthesize cartnoLabel;
@synthesize accountLabel;
@synthesize nameLabel;
@synthesize birthdayLabel;
@synthesize sexLabel;
@synthesize phoneLabel;
@synthesize emailLabel;
@synthesize qqLabel;
@synthesize comLabel;
@synthesize addrLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self.navigationController setNavigationBarHidden:YES];
    // Do any additional setup after loading the view from its nib.
    [self.UINavigationBar setBackgroundImage:[UIImage imageNamed:@"logo_bg"] forBarMetrics:UIBarMetricsDefault];
    piclist=[[NSMutableArray alloc]initWithCapacity:5];
    
    [self loaddata];
}

-(void)loaddata
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    NSMutableDictionary * infolist = [NSMutableDictionary dictionaryWithCapacity:5];
    infolist=[DataService PostDataService:[NSString stringWithFormat:@"%@api/findPersoanlInfo",domainser] postDatas:[NSString stringWithFormat:@"userid=%@",myDelegate.entityl.userid]];
    NSDictionary *info=[infolist objectForKey:@"datas"];
    
    //身份证号码
    id codeid=[info objectForKey:@"codeid"];
    if (codeid!=[NSNull null]) {
        personnoLabel.text=[NSString stringWithFormat:@"%@",codeid];
    }
    
    //卡号
    id cardcode=[info objectForKey:@"cardcode"];
    if (cardcode!=[NSNull null]) {
        cartnoLabel.text=[NSString stringWithFormat:@"%@",cardcode];
    }
    
    //账号
    id account=[info objectForKey:@"account"];
    if (account!=[NSNull null]) {
        accountLabel.text=[NSString stringWithFormat:@"%@",account];
    }
    
    //昵称
    id name=[info objectForKey:@"name"];
    if (name!=[NSNull null]) {
        nameLabel.text=[NSString stringWithFormat:@"%@",name];
    }
    
    //出生日期
    id birthday=[info objectForKey:@"birthday"];
    if (birthday!=[NSNull null]) {
        birthdayLabel.text=[NSString stringWithFormat:@"%@",birthday];
    }
    
    //性别
    id sex=[info objectForKey:@"sex"];
    if (sex!=[NSNull null]) {
        NSString *sextext=[NSString stringWithFormat:@"%@",sex];
        if ([sextext isEqualToString:@"0"]) {
            sexLabel.text=@"保密";
        }else if ([sextext isEqualToString:@"1"])
        {
            sexLabel.text=@"男";
        }else if ([sextext isEqualToString:@"2"])
        {
            sexLabel.text=@"女";
        }
    }
    
    
    //手机号码
    id mobile=[info objectForKey:@"mobile"];
    if (mobile!=[NSNull null]) {
        phoneLabel.text=[NSString stringWithFormat:@"%@",mobile];
    }
    
    
    //电子邮箱
    id email=[info objectForKey:@"email"];
    if (email!=[NSNull null]) {
        emailLabel.text=[NSString stringWithFormat:@"%@",email];
    }
    
    //qq号
    id qq=[info objectForKey:@"qq"];
    if (qq!=[NSNull null]) {
        qqLabel.text=[NSString stringWithFormat:@"%@",qq];
    }
    
    //当前社区
    comLabel.text=[NSString stringWithFormat:@"%@",myDelegate.entityl.communityName];
    
    
    //联系地址
    id addr=[info objectForKey:@"addr"];
    if (addr!=[NSNull null]) {
        addrLabel.text=[NSString stringWithFormat:@"%@",addr];
    }
    
    //头像
    NSString *url=[NSString stringWithFormat:@"%@",myDelegate.entityl.headimg];
    NSURL *imgUrl=[NSURL URLWithString:url];
    if (hasCachedImage(imgUrl)) {
        [userimage setImage:[UIImage imageWithContentsOfFile:pathForURL(imgUrl)]];
    }else{
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:imgUrl,@"url",userimage,@"imageView",nil];
        [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
    }
}

-(IBAction)goback:(id)sender
{
    personIndex *_personIndex=[[personIndex alloc]init];
    [self.navigationController pushViewController:_personIndex animated:NO];
}

//修改个人信息
-(IBAction)updateinfo:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    NSInteger btntag=btn.tag;
    updateinfo *_updateinfo=[[updateinfo alloc]init];
    _updateinfo.btntag=[NSString stringWithFormat:@"%d",btntag];
    
    NSString *value;
    if (btntag==0) {
        value=personnoLabel.text;
    }else if (btntag==1)
    {
        value=cartnoLabel.text;
    }else if (btntag==3)
    {
        value=nameLabel.text;
    }else if (btntag==6)
    {
        value=phoneLabel.text;
    }else if (btntag==7)
    {
        value=emailLabel.text;
    }else if (btntag==8)
    {
        value=qqLabel.text;
    }else if (btntag==10)
    {
        value=addrLabel.text;
    }
    _updateinfo.value=value;
    
    [self.navigationController pushViewController:_updateinfo animated:NO];
}


//修改头像
- (IBAction)chooseImage:(id)sender {
        UIActionSheet *sheet;
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            
        {
            sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
            
        }
        
        else {
            
            sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
            
        }
        
        sheet.tag = 255;
        
        [sheet showInView:self.view];
}

#pragma mark - 保存图片至沙盒
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    
    // 将图片写入文件
    
    [imageData writeToFile:fullPath atomically:NO];
}

#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	[picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    NSString *fullPath =nil;
    //记录文件
    
    [self saveImage:image withName:@"currentImage1.png"];
    
    fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage1.png"];
    
    [piclist addObject:fullPath];
    
    //UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    //isFullScreen = NO;
    //[userimage setImage:savedImage];
    userimage.tag = 100;
    
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    myDelegate.mydelegate=self;
    [myDelegate submitOrder:myDelegate.entityl.userid uploadpath:piclist URL:@"api/updateMyInfo" postid:@"userid"];
    [piclist removeAllObjects];
    
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[self dismissViewControllerAnimated:YES completion:^{}];
}


#pragma mark - actionsheet delegate
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                case 0:
                    // 取消
                    return;
                case 1:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                    
                case 2:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = sourceType;
        
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:imagePickerController];
            popoverController = popover;
            [popoverController presentPopoverFromRect:CGRectMake(0, 0, 300, 300) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
            
        } else {
            [self presentViewController:imagePickerController animated:YES completion:^{}];
        }
        
    }
}

- (IBAction)pickerAction:(id)sender{
    // Here we need to pass a full frame
    CustomIOS7AlertView *alertView = [[CustomIOS7AlertView alloc] init];
    
    // Add some custom content to the alert view
    [alertView setContainerView:[self createDemoView]];
    
    // Modify the parameters
    [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"确定", @"取消", nil]];
    [alertView setDelegate:self];
    
    [alertView setUseMotionEffects:true];
    
    // And launch the dialog
    [alertView show];
}

- (void)customIOS7dialogButtonTouchUpInside: (CustomIOS7AlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        [alertView close];
    }else if (buttonIndex==0)
    {
        NSString *dateFromData = [NSString stringWithFormat:@"%@",datePickerView.date];
        NSString *date = [dateFromData substringWithRange:NSMakeRange(0, 10)];
        
        AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
        NSMutableDictionary * state = [NSMutableDictionary dictionaryWithCapacity:5];
        
        state=[DataService PostDataService:[NSString stringWithFormat:@"%@api/changeMyInfo",domainser] postDatas:[NSString stringWithFormat:@"userid=%@&account=%@&birthday=%@",myDelegate.entityl.userid,myDelegate.entityl.account,date]];
        
        
        NSString *rowString =[state objectForKey:@"info"];
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        
        
        NSString *status=[NSString stringWithFormat:@"%@",[state objectForKey:@"status"]];
        if ([status isEqualToString:@"1"]) {
            [self loaddata];
        }
        
        [alertView close];
    }
}

//日历选择
- (UIView *)createDemoView
{
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 290, 200)];
    datePickerView = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    datePickerView.locale=locale;
	datePickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
	datePickerView.frame = CGRectMake(10, 10, 300, 216);//216
	datePickerView.datePickerMode = UIDatePickerModeDate;
	
	[demoView addSubview:datePickerView];
    
    return demoView;
}

//修改性别
-(IBAction)changesex:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择性别" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"保密", @"男",@"女", nil];
    [alert show];
}


-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex!=0) {
        AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
        NSMutableDictionary * state = [NSMutableDictionary dictionaryWithCapacity:5];
        
        state=[DataService PostDataService:[NSString stringWithFormat:@"%@api/changeMyInfo",domainser] postDatas:[NSString stringWithFormat:@"userid=%@&account=%@&sex=%d",myDelegate.entityl.userid,myDelegate.entityl.account,buttonIndex-1]];
        
        
        NSString *rowString =[state objectForKey:@"info"];
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        
        
        NSString *status=[NSString stringWithFormat:@"%@",[state objectForKey:@"status"]];
        if ([status isEqualToString:@"1"]) {
            [self loaddata];
        }
    }
}

//更换社区
-(IBAction)changecom:(id)sender
{
    changecom *_changecom=[[changecom alloc]init];
    _changecom.ispersoninfo=@"1";
    [self.navigationController pushViewController:_changecom animated:NO];
}

//修改密码
-(IBAction)updatepassword:(id)sender
{
    updatepassword *_updatepassword=[[updatepassword alloc]init];
    [self.navigationController pushViewController:_updatepassword animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
