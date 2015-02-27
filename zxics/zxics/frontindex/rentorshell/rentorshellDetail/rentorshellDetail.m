//
//  rentorshellDetail.m
//  zxics
//
//  Created by johnson on 14-8-11.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "rentorshellDetail.h"
#import "DataService.h"
#import "ImageCacher.h"

@interface rentorshellDetail ()

@end

@implementation rentorshellDetail

@synthesize picSView;
@synthesize detailSView;
@synthesize nameLabel;
@synthesize rentLabel;
@synthesize floorLabel;
@synthesize typeLabel;
@synthesize comLabel;
@synthesize addrLabel;
@synthesize personLabel;
@synthesize telLabel;
@synthesize detailLabel;
@synthesize areaLabel;
@synthesize targetLabel;
@synthesize fixtureLabel;
@synthesize rsd;
@synthesize btntag;
@synthesize HouseImage;

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
    [self.UINavigationBar setBackgroundImage:[UIImage imageNamed:@"logo_bg"] forBarMetrics:UIBarMetricsDefault];    if ([btntag isEqualToString:@"0"]) {
        self.UINavigationItem.title=@"出售";
    }else{
        self.UINavigationItem.title=@"出租";
    }
    
    [self loaddata];
    
    [self goodsimglistshow];
}

-(void)loaddata
{
    //图片
    NSString *url=[NSString stringWithFormat:@"%@%@",domainser,[rsd objectForKey:@"headurl"]];
    NSURL *imgUrl=[NSURL URLWithString:url];
    if (hasCachedImage(imgUrl)) {
        [HouseImage setImage:[UIImage imageWithContentsOfFile:pathForURL(imgUrl)]];
    }else{
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:imgUrl,@"url",HouseImage,@"imageView",nil];
        [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
    }
    
    //名称
    nameLabel.text=[NSString stringWithFormat:@"名称：%@",[rsd objectForKey:@"title"]];
    
    //租金
    if ([btntag isEqualToString:@"0"]) {
       rentLabel.text=[NSString stringWithFormat:@"售价：%@万元",[rsd objectForKey:@"rent"]];
    }else
    {
        rentLabel.text=[NSString stringWithFormat:@"租金：%@元/月",[rsd objectForKey:@"rent"]];
    }
    
    //楼层
    id doorch=[rsd objectForKey:@"doorch"];
    id doorzc=[rsd objectForKey:@"doorzc"];
    if (doorch!=[NSNull null] && doorzc!=[NSNull null]) {
        floorLabel.text=[NSString stringWithFormat:@"楼层：%@/%@",doorch,doorzc];
    }else{
        floorLabel.text=@"楼层：";
    }
    
    //房型
    id homeptype=[rsd objectForKey:@"homeptype"];
    if (homeptype!=[NSNull null]) {
        if ([homeptype isEqualToString:@"1"]) {
            typeLabel.text=@"房型：公寓";
        }else if([homeptype isEqualToString:@"2"])
        {
            typeLabel.text=@"房型：单位楼房";
        }else if([homeptype isEqualToString:@"3"])
        {
            typeLabel.text=@"房型：别墅";
        }else if([homeptype isEqualToString:@"4"])
        {
            typeLabel.text=@"房型：民房";
        }else if([homeptype isEqualToString:@"5"])
        {
            typeLabel.text=@"房型：公租";
        }else if([homeptype isEqualToString:@"6"])
        {
            typeLabel.text=@"房型：其他";
        }
    }else{
        typeLabel.text=@"房型：";
    }
    
    //小区
    id communityid=[rsd objectForKey:@"communityid"];
    if (communityid!=[NSNull null]) {
        comLabel.text=[NSString stringWithFormat:@"小区：%@",[rsd objectForKey:@"communityid"]];
    }else{
        comLabel.text=@"小区：";
    }
    
    //地址
    id homeaddress=[rsd objectForKey:@"homeaddress"];
    if (homeaddress!=[NSNull null]) {
        addrLabel.text=[NSString stringWithFormat:@"地址：%@",[rsd objectForKey:@"homeaddress"]];
    }else{
        addrLabel.text=@"地址：";
    }
    
    //联系人
    id contactname=[rsd objectForKey:@"contactname"];
    if (contactname!=[NSNull null]) {
        personLabel.text=[NSString stringWithFormat:@"联系人：%@",[rsd objectForKey:@"contactname"]];
    }else{
        personLabel.text=@"联系人：";
    }
    
    //电话号码
    id contactphone=[rsd objectForKey:@"contactphone"];
    if (contactphone!=[NSNull null]) {
        telLabel.text=[NSString stringWithFormat:@"联系电话：%@",[rsd objectForKey:@"contactphone"]];
    }else{
        telLabel.text=@"联系电话：";
    }
    
    //配置
    id homeset=[rsd objectForKey:@"homeset"];
    if (homeset!=[NSNull null]) {
        detailLabel.text=[NSString stringWithFormat:@"配置：%@",[rsd objectForKey:@"homeset"]];
        detailLabel.numberOfLines=0;
        CGSize size =CGSizeMake(detailLabel.frame.size.width,0);
        UIFont * tfont = detailLabel.font;
        NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
        
        CGSize  actualsize =[[rsd objectForKey:@"homeset"] boundingRectWithSize:size options:
                             NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
        
        detailLabel.frame=CGRectMake(detailLabel.frame.origin.x, detailLabel.frame.origin.y, detailLabel.frame.size.width, actualsize.height+24);
    }else{
        detailLabel.text=@"配置：";
    }
    
    //面积
    id area=[rsd objectForKey:@"area"];
    if (area!=[NSNull null]) {
        areaLabel.text=[NSString stringWithFormat:@"面积：%@㎡",[rsd objectForKey:@"area"]];
    }else{
        areaLabel.text=@"面积：";
    }
    
    //朝向
    id hometarget=[rsd objectForKey:@"hometarget"];
    if (hometarget!=[NSNull null]) {
        targetLabel.text=[NSString stringWithFormat:@"朝向：%@",[rsd objectForKey:@"hometarget"]];
    }else{
        targetLabel.text=@"朝向：";
    }
    
    //装修
    id hometype=[rsd objectForKey:@"hometype"];
    if (hometype!=[NSNull null]) {
        if ([hometype isEqualToString:@"1"]) {
            fixtureLabel.text=@"装修：毛胚";
        }else if([hometype isEqualToString:@"2"])
        {
            fixtureLabel.text=@"装修：普通装修";
        }else if([hometype isEqualToString:@"3"])
        {
            fixtureLabel.text=@"装修：精装修";
        }else if([hometype isEqualToString:@"4"])
        {
            fixtureLabel.text=@"装修：豪华装修";
        }else if([hometype isEqualToString:@"5"])
        {
            fixtureLabel.text=@"装修：其他";
        }
    }else{
        fixtureLabel.text=@"装修：";
    }
}


//商品图片集
-(void)goodsimglistshow
{
    NSMutableDictionary * goodsimgdic = [NSMutableDictionary dictionaryWithCapacity:5];
    goodsimgdic=[DataService PostDataService:[NSString stringWithFormat:@"%@api/getgoodsimglist",domainser] postDatas:[NSString stringWithFormat:@"gid=%@&name=sys_project_property",[rsd objectForKey:@"id"]]];
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
        
        [picSView addSubview:img];
    }
    
    picSView.contentSize=CGSizeMake(122*count, 0);
    picSView.showsHorizontalScrollIndicator=NO;//不显示水平滑动线
    picSView.showsVerticalScrollIndicator=YES;//不显示垂直滑动线
    picSView.scrollEnabled=YES;
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
