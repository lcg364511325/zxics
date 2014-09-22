//
//  addelectric.m
//  zxics
//
//  Created by johnson on 14-9-5.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "addelectric.h"
#import "AppDelegate.h"
#import "DataService.h"
#import "myelectric.h"

@interface addelectric ()

@end

@implementation addelectric

@synthesize countText;
@synthesize alter;

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
    [self.UINavigationBar setBackgroundImage:[UIImage imageNamed:@"logo_bg"] forBarMetrics:UIBarMetricsDefault];    
    picno=0;
    piclist=[[NSMutableArray alloc]initWithCapacity:1];
}

//上传图片
- (IBAction)chooseImage:(id)sender {
    if (picno>1) {
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
    
    [self saveImage:image withName:[NSString stringWithFormat:@"currentImage%d.png",picno]];
    
    fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:[NSString stringWithFormat:@"currentImage%d.png",picno]];
    [piclist addObject:fullPath];
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    //isFullScreen = NO;
    UIImageView *imageview =[[UIImageView alloc]init];
    imageview.frame=CGRectMake(70*(picno+1), 113, 50, 50);
    [imageview setImage:savedImage];
    
    imageview.tag = 100;
    [self.view addSubview:imageview];
    picno++;
    
    
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


//提交信息
-(IBAction)submitOrder:(id)sender{
    
    @try {
        AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
        alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"提交信息中。。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        
        
        NSString *URL = [NSString stringWithFormat:@"%@api/addGenerating",domainser];
        
        
        ASIFormDataRequest *uploadImageRequest= [ ASIFormDataRequest requestWithURL : [NSURL URLWithString:[URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ]];
        
        [uploadImageRequest setStringEncoding:NSUTF8StringEncoding];
        [uploadImageRequest setRequestMethod:@"POST"];
        [uploadImageRequest setPostValue:myDelegate.entityl.userid forKey:@"userid"];
        [uploadImageRequest setPostValue:myDelegate.entityl.communityid forKey:@"communityid"];
        [uploadImageRequest setPostValue:countText.text forKey:@"generating"];
        [uploadImageRequest setPostFormat:ASIMultipartFormDataPostFormat];
        
        int i=0;
        for (NSString *eImage in piclist)
        {
            i++;
            NSData *imageData = [NSData dataWithContentsOfFile:eImage];
            //NSData *imageData=UIImageJPEGRepresentation(eImage,100);
            //NSString *photoName=[NSString stringWithFormat:@"file%d.jpg",i];
            NSString * photoName=[eImage lastPathComponent];//从路径中获得完整的文件名（带后缀）
            photoName=[NSString stringWithFormat:@"%d%@",i,photoName];
            //NSString *photoDescribe=@" ";
            //NSLog(@"photoName=%@",photoName);
            //NSLog(@"photoDescribe=%@",photoDescribe);
            NSLog(@"图片名字+++++%@",photoName);
            NSLog(@"图片大小+++++%d",[imageData length]/1024);
            //照片content
            //[uploadImageRequest setPostValue:photoDescribe forKey:@"photoContent"];
            //[uploadImageRequest addData:imageData withFileName:photoName andContentType:@"image/jpeg" forKey:@"photoContent"];
            //[requset addData:imageData withFileName:[NSString stringWithFormat:@"%@_%d.png",self.TF_tel.text,ranNum] andContentType:@"image/png" forKey:[NSString stringWithFormat:@"uploadImage%d",index]];
            
            [uploadImageRequest addData:imageData withFileName:photoName andContentType:@"image/jpeg" forKey:[NSString stringWithFormat:@"uploadImage%d",i]];
        }
        
        [uploadImageRequest setDelegate : self ];
        [uploadImageRequest setDidFinishSelector : @selector (responseComplete:)];
        [uploadImageRequest setDidFailSelector : @selector (responseFailed:)];
        [uploadImageRequest startAsynchronous];
        
        
    }@catch (NSException *exception) {
        [alter dismissWithClickedButtonIndex:0 animated:YES];
    }
    @finally {
        
    }
    
}

//数据提交上传完成
-(void)responseComplete:(ASIHTTPRequest*)request
{
    @try {
        [alter dismissWithClickedButtonIndex:0 animated:YES];
        
        //Use when fetching text data
        
        //Use when fetching binary data
        NSData *jsonData = [request responseData];
        
        NSError *error = nil;
        if ([jsonData length] > 0 && error == nil){
            error = nil;
            
            id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
            
            if (jsonObject != nil && error == nil){
                if ([jsonObject isKindOfClass:[NSDictionary class]])
                {
                    NSDictionary *d = (NSDictionary *)jsonObject;
                    NSString * status=[NSString stringWithFormat:@"%@",[d objectForKey:@"status"]];
                    if ([status isEqualToString:@"0"]) {
                        //提交失败
                        [[[UIAlertView alloc] initWithTitle:@"信息提示" message:@"提交失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
                        
                        return;
                    }else if([status isEqualToString:@"1"]){
                        [[[UIAlertView alloc] initWithTitle:@"信息提示" message:@"提交成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
                        myelectric *_myelectric=[[myelectric alloc]init];
                        [self.navigationController pushViewController:_myelectric animated:NO];
                        return;
                    }
                    
                }else if ([jsonObject isKindOfClass:[NSArray class]]){
                    
                }
                else {
                    NSLog(@"无法解析的数据结构.");
                }
                
                
            }
            else if (error != nil){
                NSLog(@"%@",error);
            }
        }
        else if ([jsonData length] == 0 &&error == nil){
            NSLog(@"空的数据集.");
        }
        else if (error != nil){
            NSLog(@"发生致命错误：%@", error);
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    [[[UIAlertView alloc] initWithTitle:@"信息提示" message:@"提交失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
    
}

//提交上传数据失败
-(void)responseFailed:(ASIHTTPRequest *)request
{
    [alter dismissWithClickedButtonIndex:0 animated:YES];
    //NSError *error = [request error];
    
    [[[UIAlertView alloc] initWithTitle:@"信息提示" message:@"提交失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
    
}

-(IBAction)goback:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
