//
//  shopMlistDetail.m
//  zxics
//
//  Created by johnson on 15-3-10.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import "shopMlistDetail.h"
#import "DataService.h"
#import "Commons.h"
#import "ImageCacher.h"

@interface shopMlistDetail ()

@end

@implementation shopMlistDetail

@synthesize pid;
@synthesize contentview;
@synthesize detailBtn;
@synthesize introduceBtn;
@synthesize goodsimageSView;

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
    [self.navigationController setNavigationBarHidden:YES];
    [self.UINavigationBar setBackgroundImage:[UIImage imageNamed:@"logo_bg"] forBarMetrics:UIBarMetricsDefault];
    
    NSMutableDictionary * pw = [NSMutableDictionary dictionaryWithCapacity:5];
    pw=[DataService PostDataService:[NSString stringWithFormat:@"%@api/getShopMListDetail",domainser] postDatas:[NSString stringWithFormat:@"id=%@",pid]];
    data=[pw objectForKey:@"data"];
    
    contentview.hidden=YES;
    
    [self loaddata];
    
    //加载图片集
    [self goodsimglistshow];
    
}

-(IBAction)goback:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

-(IBAction)selectDetailShow:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    if (btn.tag==0) {
        contentview.hidden=YES;
        [detailBtn setBackgroundImage:[UIImage imageNamed:@"selectedBtn"] forState:UIControlStateNormal];
        [introduceBtn setBackgroundImage:[UIImage imageNamed:@"unseletedBtn"] forState:UIControlStateNormal];
    }else{
        contentview.hidden=NO;
        [detailBtn setBackgroundImage:[UIImage imageNamed:@"unseletedBtn"] forState:UIControlStateNormal];
        [introduceBtn setBackgroundImage:[UIImage imageNamed:@"selectedBtn"] forState:UIControlStateNormal];
    }
}

-(void)loaddata
{
        Commons *_Commons=[[Commons alloc]init];
        //商铺详情
        
        
        //名称
        UILabel *nameLable=[[UILabel alloc]init];
        NSString *nameStr=[_Commons turnNullValue:@"title" Object:data];
        nameLable.font=[UIFont systemFontOfSize:12.0f];
        nameLable.frame=CGRectMake(5, contentview.frame.origin.y+5, self.view.frame.size.width-10, 18);
        nameLable.text=[NSString stringWithFormat:@"名称：%@",nameStr] ;
        [self.view addSubview:nameLable];
        
        //租金
        UILabel *rentLable=[[UILabel alloc]init];
        NSString *rentStr=[_Commons turnNullValue:@"rent" Object:data];
        rentLable.font=[UIFont systemFontOfSize:12.0f];
        rentLable.frame=CGRectMake(5, nameLable.frame.origin.y+24, self.view.frame.size.width-10, 18);
        rentStr=[NSString stringWithFormat:@"租金：%@元",rentStr] ;
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:rentStr];
        [AttributedStr addAttribute:NSForegroundColorAttributeName
         
                              value:[UIColor redColor]
         
                              range:NSMakeRange(3, rentStr.length-4)];
        rentLable.attributedText=AttributedStr;
        [self.view addSubview:rentLable];
        
        //保证金
        UILabel *depositLable=[[UILabel alloc]init];
        NSString *depositStr=[_Commons turnNullValue:@"deposit" Object:data];
        depositLable.font=[UIFont systemFontOfSize:12.0f];
        depositLable.frame=CGRectMake(5, rentLable.frame.origin.y+24, self.view.frame.size.width-10, 18);
        depositLable.text=[NSString stringWithFormat:@"保证金：%@元",depositStr] ;
        [self.view addSubview:depositLable];
        
        //建于
        UILabel *shopyearLable=[[UILabel alloc]init];
        NSString *shopyearStr=[_Commons turnNullValue:@"shopyear" Object:data];
        shopyearLable.font=[UIFont systemFontOfSize:12.0f];
        shopyearLable.frame=CGRectMake(5, depositLable.frame.origin.y+24, self.view.frame.size.width-10, 18);
        shopyearLable.text=[NSString stringWithFormat:@"建于：%@年",shopyearStr] ;
        [self.view addSubview:shopyearLable];
        
        //类型
        UILabel *subTypeLable=[[UILabel alloc]init];
        NSString *subTypeStr=[_Commons turnNullValue:@"subType" Object:data];
        if ([subTypeStr isEqualToString:@"0"]) {
            subTypeStr=@"出售";
        }else if ([subTypeStr isEqualToString:@"1"])
        {
            subTypeStr=@"租赁";
            
        }else{
            subTypeStr=@"未知";
        }
        subTypeLable.font=[UIFont systemFontOfSize:12.0f];
        subTypeLable.frame=CGRectMake(5, shopyearLable.frame.origin.y+24, self.view.frame.size.width-10, 18);
        subTypeLable.text=[NSString stringWithFormat:@"类型：%@",subTypeStr] ;
        [self.view addSubview:subTypeLable];
        
        //地址
        UILabel *addressLable=[[UILabel alloc]init];
        NSString *addressStr=[NSString stringWithFormat:@"%@－%@－%@",[_Commons turnNullValue:@"Cname" Object:data],[_Commons turnNullValue:@"Tname" Object:data],[_Commons turnNullValue:@"address" Object:data]];
        addressLable.font=[UIFont systemFontOfSize:12.0f];
        addressLable.frame=CGRectMake(5, subTypeLable.frame.origin.y+24, self.view.frame.size.width-10, 18);
        addressLable.text=[NSString stringWithFormat:@"地址：%@",addressStr] ;
        [self.view addSubview:addressLable];
        
        //联系人
        UILabel *contactnameLable=[[UILabel alloc]init];
        NSString *contactnameStr=[_Commons turnNullValue:@"contactname" Object:data];
        contactnameLable.font=[UIFont systemFontOfSize:12.0f];
        contactnameLable.frame=CGRectMake(5, addressLable.frame.origin.y+24, self.view.frame.size.width-10, 18);
        contactnameLable.text=[NSString stringWithFormat:@"联系人：%@",contactnameStr] ;
        [self.view addSubview:contactnameLable];
        
        //联系电话
        UILabel *contactphoneLable=[[UILabel alloc]init];
        NSString *contactphoneStr=[_Commons turnNullValue:@"contactphone" Object:data];
        contactphoneLable.font=[UIFont systemFontOfSize:12.0f];
        contactphoneLable.frame=CGRectMake(5, contactnameLable.frame.origin.y+24, self.view.frame.size.width-10, 18);
        contactphoneLable.text=[NSString stringWithFormat:@"联系电话：%@",contactphoneStr] ;
        [self.view addSubview:contactphoneLable];
        
        //商铺介绍
        NSString * webStr=[NSString stringWithFormat:@"<html> \n"
                           "<head> \n"
                           "<style type=\"text/css\"> \n"
                           "body {font-family: \"%@\"; font-size: %f; color: %@;}\n"
                           "</style> \n"
                           "</head> \n"
                           "<body>%@</body> \n"
                           "</html>", @"宋体", 12.0,@"black",[_Commons turnNullValue:@"contents" Object:data]];
        [contentview loadHTMLString:webStr baseURL:nil];
        [contentview setHidden:YES];
        NSString *goodsDescStr=[_Commons webViewDidFinishLoad:contentview webStr:webStr];
        [contentview loadHTMLString:goodsDescStr baseURL:nil];
        [self.view bringSubviewToFront:contentview];
}

//商品图片集
-(void)goodsimglistshow
{
    NSMutableDictionary * goodsimgdic = [NSMutableDictionary dictionaryWithCapacity:5];
    goodsimgdic=[DataService PostDataService:[NSString stringWithFormat:@"%@api/getgoodsimglist",domainser] postDatas:[NSString stringWithFormat:@"gid=%@&name=sys_project_propertyshop",[data objectForKey:@"id"]]];
    imglist=[goodsimgdic objectForKey:@"datas"];
    NSInteger count=[imglist count];
    for (int i=0; i<count; i++) {
        //创建图片
        UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(i*122, 0, 122, 120)];
        
        //实例化
        NSString *url=[NSString stringWithFormat:@"%@",[[imglist objectAtIndex:i] objectForKey:@"goodsImg"]];
        NSURL *imgUrl=[NSURL URLWithString:url];
        if (hasCachedImage(imgUrl)) {
            [img setImage:[UIImage imageWithContentsOfFile:pathForURL(imgUrl)]];
        }else{
            NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:imgUrl,@"url",img,@"imageView",nil];
            [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
        }
        
        img.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPhotoBrowser)];
        [img addGestureRecognizer:singleTap];
        
        [goodsimageSView addSubview:img];
    }
    
    goodsimageSView.contentSize=CGSizeMake(122*count, 0);
    goodsimageSView.showsHorizontalScrollIndicator=NO;//不显示水平滑动线
    goodsimageSView.showsVerticalScrollIndicator=YES;//不显示垂直滑动线
    goodsimageSView.scrollEnabled=YES;
}

//展示图片集
-(void)showPhotoBrowser
{
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    //NSMutableArray *thumbs = [[NSMutableArray alloc] init];
    //MWPhoto *photot;
    
    NSArray  * array= imglist;
    int count = [array count];
    //遍历这个数组
    for (int i = 0; i < count; i++) {
        //NSLog(@"普通的遍历：i = %d 时的数组对象为: %@",i,[array objectAtIndex: i]);
        NSString * patht=[NSString stringWithFormat:@"%@",[[array objectAtIndex:i] objectForKey:@"goodsImg"]];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
