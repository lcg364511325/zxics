//
//  goodsDetail.m
//  zxics
//
//  Created by johnson on 14-8-11.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "goodsDetail.h"
#import "goodsDetailCell.h"
#import "MJRefresh.h"
#import "AppDelegate.h"
#import "DataService.h"
#import "Commons.h"
#import "placeorder.h"
#import "ImageCacher.h"

@interface goodsDetail ()

@end

@implementation goodsDetail
@synthesize gdsdetail;
@synthesize secondView;
@synthesize thirdView;
@synthesize nameLabel;
@synthesize shopprcLabel;
@synthesize marketprcLabel;
@synthesize goodsnoLabel;
@synthesize sellnoLabel;
@synthesize countnoLabel;
@synthesize goodsimageSView;
@synthesize detailButton;
@synthesize introductButton;
@synthesize assessButton;
@synthesize assessTView;
@synthesize contentview;

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
    page=1;
    list=[[NSMutableArray alloc]initWithCapacity:1];
    
    //加载数据
    [self loaddata];
    
    //加载图片集
    [self goodsimglistshow];
    
    //上拉刷新下拉加载提示
    [assessTView addHeaderWithCallback:^{
        [list removeAllObjects];
        page=1;
        [self loaddata];
        [assessTView reloadData];
        [assessTView headerEndRefreshing];}];
    [assessTView addFooterWithCallback:^{
        page=page+1;
        [self loaddata];
        [assessTView reloadData];
        [assessTView footerEndRefreshing];
    }];
}

//商品图片集
-(void)goodsimglistshow
{
    NSMutableDictionary * goodsimgdic = [NSMutableDictionary dictionaryWithCapacity:5];
    goodsimgdic=[DataService PostDataService:[NSString stringWithFormat:@"%@api/getgoodsimglist",domainser] postDatas:[NSString stringWithFormat:@"gid=%@&name=sys_project_goods",[gdsdetail objectForKey:@"id"]]];
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

//商品详情
-(void)loaddata
{
    //商品详情
    self.UINavigationItem.title=[NSString stringWithFormat:@"%@",[gdsdetail objectForKey:@"name"]];
    detailButton.backgroundColor=[UIColor lightGrayColor];
    nameLabel.text=[NSString stringWithFormat:@"%@",[gdsdetail objectForKey:@"name"]];
    shopprcLabel.text=[NSString stringWithFormat:@"%@",[gdsdetail objectForKey:@"shopPrice"]];
    marketprcLabel.text=[NSString stringWithFormat:@"%@",[gdsdetail objectForKey:@"marketPrice"]];
    goodsnoLabel.text=[NSString stringWithFormat:@"%@",[gdsdetail objectForKey:@"goodsSn"]];
    sellnoLabel.text=[NSString stringWithFormat:@"%@",[gdsdetail objectForKey:@"saleCount"]];
    
    //商品描述
    NSString * webStr=[NSString stringWithFormat:@"<html> \n"
                       "<head> \n"
                       "<style type=\"text/css\"> \n"
                       "body {font-family: \"%@\"; font-size: %f; color: %@;}\n"
                       "#dtitle{color:orange;}"
                       "</style> \n"
                       "</head> \n"
                       "<body><span id='dtitle'>商品描述</span>：%@<br/><br/><span id='dtitle'>详细描述</span>：%@</body> \n"
                       "</html>", @"宋体", 20.0,@"black",[gdsdetail objectForKey:@"goodsBrief"],[gdsdetail objectForKey:@"goodsDesc"]];
    [contentview loadHTMLString:webStr baseURL:nil];
    [contentview setHidden:YES];
    Commons *_Commons=[[Commons alloc]init];
    NSString *goodsDescStr=[_Commons webViewDidFinishLoad:contentview webStr:webStr];
    [contentview loadHTMLString:goodsDescStr baseURL:nil];
    [contentview setHidden:NO];
    
    
    //商品评价
    NSMutableDictionary * ass = [NSMutableDictionary dictionaryWithCapacity:5];
    ass=[DataService PostDataService:[NSString stringWithFormat:@"%@api/mobileGoodsInfoEvaluate",domainser] postDatas:[NSString stringWithFormat:@"gid=%@",[gdsdetail objectForKey:@"id"]] forPage:page forPageSize:10];
    NSArray *asslist=[ass objectForKey:@"datas"];
    [list addObjectsFromArray:asslist];
}

//商品详情
-(IBAction)detail:(id)sender
{
    introductButton.backgroundColor=assessButton.backgroundColor=[UIColor darkGrayColor];
    detailButton.backgroundColor=[UIColor lightGrayColor];
    [secondView removeFromSuperview];
    [thirdView removeFromSuperview];
}


//商品介绍显示
-(IBAction)introduct:(id)sender
{
    [secondView removeFromSuperview];
    [thirdView removeFromSuperview];
    detailButton.backgroundColor=assessButton.backgroundColor=[UIColor darkGrayColor];
    introductButton.backgroundColor=[UIColor lightGrayColor];
    
    secondView.frame=CGRectMake(secondView.frame.origin.x, goodsimageSView.frame.origin.y+goodsimageSView.frame.size.height+40, secondView.frame.size.width, secondView.frame.size.height);
    
    [self.view addSubview:secondView];
    
}

-(IBAction)assess:(id)sender
{
    [secondView removeFromSuperview];
    [thirdView removeFromSuperview];
    
    detailButton.backgroundColor=introductButton.backgroundColor=[UIColor darkGrayColor];
    assessButton.backgroundColor=[UIColor lightGrayColor];
    thirdView.frame=CGRectMake(thirdView.frame.origin.x, goodsimageSView.frame.origin.y+goodsimageSView.frame.size.height+40, thirdView.frame.size.width, thirdView.frame.size.height);
    [self.view addSubview:thirdView];
}

//初始化tableview数据
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [list count];
    //只有一组，数组数即为行数。
}

// tableview数据显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"goodsDetailCell";
    
    goodsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        NSArray * nib=[[NSBundle mainBundle]loadNibNamed:@"goodsDetailCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    NSDictionary *assdetail = [list objectAtIndex:[indexPath row]];
    
    cell.nameLabel.text=[NSString stringWithFormat:@"%@",[assdetail objectForKey:@"name"]];
    cell.asseccLabel.text=[NSString stringWithFormat:@"%@",[assdetail objectForKey:@"comments"]];
    cell.scoreLabel.text=[NSString stringWithFormat:@"用户评分：%@",[assdetail objectForKey:@"star"]];
    
    Commons *_Commons=[[Commons alloc]init];
    NSString *timestr=[NSString stringWithFormat:@"%@",[assdetail objectForKey:@"ctime"]];
    cell.timeLabel.text=[_Commons stringtoDateforsecond:timestr];
    
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//更改商品数量
-(IBAction)changeno:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    NSInteger btntag=btn.tag;
    NSInteger no=[countnoLabel.text integerValue];
    if (no<2 && btntag==0) {
        
    }else{
        if (btntag==0)
        {
            countnoLabel.text=[NSString stringWithFormat:@"%d",no-1];
            
        }else if (btntag==1)
        {
            countnoLabel.text=[NSString stringWithFormat:@"%d",no+1];
        }
    }
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

//加入购物车
-(IBAction)addtoshopcart:(id)sender
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    if (myDelegate.entityl) {
        NSMutableDictionary * state = [NSMutableDictionary dictionaryWithCapacity:5];
        state=[DataService PostDataService:[NSString stringWithFormat:@"%@api/mobileGoodsAddToCar",domainser] postDatas:[NSString stringWithFormat:@"gid=%@&mid=%@&sum=%@&sid=%@",[gdsdetail objectForKey:@"id"],myDelegate.entityl.userid,countnoLabel.text,@""]];
        NSString *rowString =[NSString stringWithFormat:@"%@",[state objectForKey:@"info"]];
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }else{
        NSString *rowString =@"请先登陆！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
}


//立即购买
-(IBAction)buynow:(id)sender
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    if (myDelegate.entityl) {
        placeorder *_placeorder=[[placeorder alloc]init];
        NSMutableArray *ridlist = [[NSMutableArray alloc]initWithCapacity:1];
        [ridlist addObject:[gdsdetail objectForKey:@"id"]];
        _placeorder.ridlist=ridlist;
        _placeorder.shopid=[gdsdetail objectForKey:@"orgId"];
        _placeorder.nowcount=countnoLabel.text;
        [self.navigationController pushViewController:_placeorder animated:NO];
    }else{
        NSString *rowString =@"请先登陆！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
}


@end
