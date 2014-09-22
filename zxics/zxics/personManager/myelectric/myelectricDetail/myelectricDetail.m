//
//  myelectricDetail.m
//  zxics
//
//  Created by johnson on 14-9-5.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "myelectricDetail.h"
#import "Commons.h"
#import "ImageCacher.h"

@interface myelectricDetail ()

@end

@implementation myelectricDetail

@synthesize me;
@synthesize medSView;
@synthesize pic1;
@synthesize pic2;

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
    [self.UINavigationBar setBackgroundImage:[UIImage imageNamed:@"logo_bg"] forBarMetrics:UIBarMetricsDefault];    imglist=[[NSMutableArray alloc]initWithCapacity:1];
    
    [self loaddata];
}

-(void)loaddata
{
    
    //图片1
    NSString *url=[NSString stringWithFormat:@"%@%@",domainser,[me objectForKey:@"imgurl1"]];
    NSURL *imgUrl=[NSURL URLWithString:url];
    if (hasCachedImage(imgUrl)) {
        [pic1 setImage:[UIImage imageWithContentsOfFile:pathForURL(imgUrl)]];
    }else{
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:imgUrl,@"url",pic1,@"imageView",nil];
        [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
    }
    
    NSString *picture1=[NSString stringWithFormat:@"%@",[me objectForKey:@"imgurl1"]];
    if (![picture1 isEqualToString:@""]) {
        [imglist addObject:url];
    }
    
    //图片2
    url=[NSString stringWithFormat:@"%@%@",domainser,[me objectForKey:@"imgurl2"]];
    imgUrl=[NSURL URLWithString:url];
    if (hasCachedImage(imgUrl)) {
        [pic2 setImage:[UIImage imageWithContentsOfFile:pathForURL(imgUrl)]];
    }else{
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:imgUrl,@"url",pic2,@"imageView",nil];
        [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
    }
    
    NSString *picture2=[NSString stringWithFormat:@"%@",[me objectForKey:@"imgurl2"]];
    if (![picture2 isEqualToString:@""]) {
        [imglist addObject:url];
    }
    
    //社区名称
    UILabel *comLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, 280, 30)];
    comLabel.font=[UIFont systemFontOfSize:12.0f];
    comLabel.text=[NSString stringWithFormat:@"社区名称：%@",[me objectForKey:@"community_name"]];
    [medSView addSubview:comLabel];
    
    //创建时间
    Commons *_Commons=[[Commons alloc]init];
    NSString *timestr=[me objectForKey:@"createtime"];
    UILabel *ctime=[[UILabel alloc] initWithFrame:CGRectMake(10, comLabel.frame.origin.y+30, 280, 30)];
    ctime.font=[UIFont systemFontOfSize:12.0f];
    ctime.text=[NSString stringWithFormat:@"创建时间：%@",[_Commons stringtoDateforsecond:timestr]];
    [medSView addSubview:ctime];
    
    
    //发电量
    UILabel *countLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, ctime.frame.origin.y+30, 280, 30)];
    countLabel.font=[UIFont systemFontOfSize:12.0f];
    countLabel.text=[NSString stringWithFormat:@"发电量：%.1fkcal",[[me objectForKey:@"generating"] floatValue]];
    [medSView addSubview:countLabel];
    
    //状态
    id state=[me objectForKey:@"type"];
    NSString *type=[NSString stringWithFormat:@"%@",[me objectForKey:@"type"]];
    UILabel *stateLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, countLabel.frame.origin.y+30, 280, 30)];
    stateLabel.font=[UIFont systemFontOfSize:12.0f];
    if (state==[NSNull null] || [type isEqualToString:@"0"]) {
        stateLabel.text=@"状态：提交";
    }else if ([type isEqualToString:@"1"])
    {
        stateLabel.text=@"状态：审核";
    }else if ([type isEqualToString:@"2"])
    {
        stateLabel.text=@"状态：退回";
    }else if ([type isEqualToString:@"3"])
    {
        stateLabel.text=@"状态：取消";
    }
    [medSView addSubview:stateLabel];
    
    //审核时间
    timestr=[me objectForKey:@"apptime"];
    UILabel *atime=[[UILabel alloc] initWithFrame:CGRectMake(10, stateLabel.frame.origin.y+30, 280, 30)];
    atime.font=[UIFont systemFontOfSize:12.0f];
    atime.text=[NSString stringWithFormat:@"审核时间：%@",[_Commons stringtoDateforsecond:timestr]];
    [medSView addSubview:atime];
    
    //审核人
    UILabel *appuserLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, atime.frame.origin.y+30, 280, 30)];
    appuserLabel.font=[UIFont systemFontOfSize:12.0f];
    id appaccount=[me objectForKey:@"appaccount"];
    if (appaccount==[NSNull null]) {
        appuserLabel.text=@"审核人：";
    }else{
        appuserLabel.text=[NSString stringWithFormat:@"审核人：%@",[me objectForKey:@"appaccount"]];
    }
    [medSView addSubview:appuserLabel];
    
    //说明
    UILabel *detailLabel=[[UILabel alloc] init];
    detailLabel.font=[UIFont systemFontOfSize:12.0f];
    id detail=[me objectForKey:@"remark"] ;
    if (detail==[NSNull null]) {
        detailLabel.text=@"说明：";
        detailLabel.frame=CGRectMake(10, appuserLabel.frame.origin.y+30, 280, 30);
    }else{
        detailLabel.text=[NSString stringWithFormat:@"说明：%@",[me objectForKey:@"remark"]];
        CGSize size =CGSizeMake(275,0);
        UIFont * tfont = detailLabel.font;
        NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
        
        CGSize  actualsize =[[me objectForKey:@"remark"] boundingRectWithSize:size options:
                             NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
        
        detailLabel.frame=CGRectMake(10, appuserLabel.frame.origin.y+30, 280, actualsize.height+24);
    }
    [medSView addSubview:detailLabel];
    
    medSView.contentSize=CGSizeMake(320, detailLabel.frame.origin.y-comLabel.frame.origin.y+detailLabel.frame.size.height+20);
    medSView.showsHorizontalScrollIndicator=NO;//不显示水平滑动线
    medSView.showsVerticalScrollIndicator=YES;//不显示垂直滑动线
    medSView.scrollEnabled=YES;
    
}

//展示图片集
-(IBAction)showPhotoBrowser:(id)sender
{
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    //NSMutableArray *thumbs = [[NSMutableArray alloc] init];
    //MWPhoto *photot;
    
    NSArray  * array= imglist;
    int count = [array count];
    //遍历这个数组
    for (int i = 0; i < count; i++) {
        //NSLog(@"普通的遍历：i = %d 时的数组对象为: %@",i,[array objectAtIndex: i]);
        NSString * patht=[NSString stringWithFormat:@"%@",[array objectAtIndex:i]];
        NSURL *imgUrl=[NSURL URLWithString:patht];
        if (hasCachedImage(imgUrl)) {
            [photos addObject:[MWPhoto photoWithImage:[UIImage imageWithContentsOfFile:pathForURL(imgUrl)]]];
        }else
        {
            [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:patht]]];
        }
        
        //[thumbs addObject:[MWPhoto photoWithURL:[NSURL URLWithString:patht]]];
    }
    
    self.photos = photos;
    //self.thumbs = thumbs;
    
    //    _selections = [NSMutableArray new];
    //    for (int i = 0; i < photos.count; i++) {
    //        [_selections addObject:[NSNumber numberWithBool:NO]];
    //    }
    
    // Create browser
	MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = NO;
    browser.displayNavArrows = YES;
    browser.displaySelectionButtons = NO;
    browser.alwaysShowControls = NO;
    browser.zoomPhotosToFill = YES;
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    browser.wantsFullScreenLayout = YES;
#endif
    browser.enableGrid = NO;
    browser.startOnGrid = NO;
    browser.enableSwipeToDismiss = YES;
    [browser setCurrentPhotoIndex:0];
    [browser setWantsFullScreenLayout:NO];
    
    // Push
    //[self presentViewController:browser animated:YES completion:nil];
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController pushViewController:browser animated:NO];
    //[self presentPopupViewController:browser animated:YES completion:^(void) {
    //    NSLog(@"popup view presented");
    //}];
    
}

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}

//- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
//    if (index < _thumbs.count)
//        return [_thumbs objectAtIndex:index];
//    return nil;
//}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
    //NSLog(@"Did start viewing photo at index %lu", (unsigned long)index);
}

- (void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser {
    // If we subscribe to this method we must dismiss the view controller ourselves
    //NSLog(@"Did finish modal presentation");
    [self dismissViewControllerAnimated:YES completion:nil];
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
