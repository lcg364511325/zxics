//
//  repairadd.m
//  zxics
//
//  Created by johnson on 14-8-6.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "repairadd.h"
#import "AppDelegate.h"
#import "DataService.h"

@interface repairadd ()

@end

@implementation repairadd

@synthesize titleText;
@synthesize typeText;
@synthesize dateText;
@synthesize detailsText;
@synthesize repairtypeTView;

//判断上传第几张图
NSInteger iii=0;

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
    // Do any additional setup after loading the view from its nib.
    [self.UINavigationBar setBarTintColor:[UIColor colorWithRed:7.0/255.0 green:3.0/255.0 blue:164.0/255.0 alpha:1]];//设置bar背景颜色
    piclist=[[NSMutableArray alloc]initWithCapacity:5];
    
    //初始化值
    typeText.text=@"紧急报修";
    titleText.text=@"物业报修";
    
    NSDate *  senddate=[NSDate date];
    NSDate *nextDate = [NSDate dateWithTimeInterval:24*60*60 sinceDate:senddate];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    dateText.text=[formatter stringFromDate:nextDate];
    
    
    //加载报修类型
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    NSMutableDictionary * type = [NSMutableDictionary dictionaryWithCapacity:1];
    type=[DataService PostDataService:[NSString stringWithFormat:@"%@api/findParameter",myDelegate.url] postDatas:@"type=repairsParame"];
    list=[type objectForKey:@"datas"];
}

-(IBAction)saverepairdata:(id)sender
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    [DataService PostDataService:[NSString stringWithFormat:@"%@api/propertyMaintainAddApi",myDelegate.url] postDatas:[NSString stringWithFormat:@"userid=%@&communityid=%@&title=%@&addDate=%@&contents=%@",myDelegate.entityl.userid,myDelegate.entityl.communityid,titleText.text,dateText.text,detailsText.text]];
}

-(IBAction)goback:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
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
        dateText.text = date;
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

-(IBAction)showrepairtype:(id)sender
{
    repairtypeTView.hidden=NO;
}


//初始化tableview数据
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [list count];
    //只有一组，数组数即为行数。
}

// tableview数据显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableSampleIdentifier];
    }
    NSUInteger row = [indexPath row];
    NSDictionary *retype=[list objectAtIndex:row];
    cell.textLabel.text = [retype objectForKey:@"name"];
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *retype=[list objectAtIndex:[indexPath row]];
    NSString *rowString = [retype objectForKey:@"name"];
    typeText.text=rowString;
    repairtypeTView.hidden=YES;
    
}

//点击tableview以外的地方触发事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self.view];
    if (!CGRectContainsPoint([repairtypeTView frame], pt)) {
        //to-do
        repairtypeTView.hidden=YES;
    }
}

- (IBAction)chooseImage:(id)sender {
    if (iii>1) {
        UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"提示" message:@"最多不能超过两张图片" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertview show];
    }else{
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
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    //isFullScreen = NO;
    UIImageView *imageview =[[UIImageView alloc]init];
    imageview.frame=CGRectMake(70*(iii+1), 240, 50, 50);
    [imageview setImage:savedImage];
    
    imageview.tag = 100;
    [self.view addSubview:imageview];
    iii++;
    
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
