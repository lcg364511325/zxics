//
//  placeorder.m
//  zxics
//
//  Created by johnson on 14-8-8.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "placeorder.h"
#import "AppDelegate.h"
#import "DataService.h"
#import "ImageCacher.h"

@interface placeorder ()

@end

@implementation placeorder

@synthesize ridlist;
@synthesize poSView;
@synthesize pricecountImage;
@synthesize pricecountLabel;
@synthesize price;
@synthesize sendway;
@synthesize shopname;
@synthesize sendwayLabel;
@synthesize addr;
@synthesize addrLabel;
@synthesize changesendwayButton;
@synthesize changeaddrButton;
@synthesize sendwayImage;

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
    
    //商品数据添加
    [self loadgoodsdata];
}

-(IBAction)goback:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

//商品数据添加
-(void)loadgoodsdata
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    NSMutableDictionary * gl = [NSMutableDictionary dictionaryWithCapacity:5];
    NSString *gid;
    for (NSString *rid in ridlist)
    {
        if (gid) {
            gid=[NSString stringWithFormat:@"%@,%@",gid,rid];
        }else
        {
            gid=rid;
        }
    }
    gl=[DataService PostDataService:[NSString stringWithFormat:@"%@api/mobileOrderCarGoods",myDelegate.url] postDatas:[NSString stringWithFormat:@"userid=%@&gid=%@",myDelegate.entityl.userid,gid]];
    NSArray *glist=[gl objectForKey:@"datas"];
    
    NSInteger count=[glist count];
    CGRect framesize;
    NSInteger pricecount=0;
    for (int i=0; i<count; i++) {
        
        NSDictionary *gdetail=[glist objectAtIndex:i];
        NSDictionary *sc=[gdetail objectForKey:@"sc"];
        
        UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(11, 12+100*i, 80, 80)];
        NSURL *imgUrl=[NSURL URLWithString:[NSString stringWithFormat:@"%@",[gdetail objectForKey:@"goodImg"]]];
        if (hasCachedImage(imgUrl)) {
            [image setImage:[UIImage imageWithContentsOfFile:pathForURL(imgUrl)]];
        }else{
            NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:imgUrl,@"url",image,@"imageView",nil];
            [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
        }
        
        UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(99, 12+100*i, 214, 21)];
        titleLabel.text=[NSString stringWithFormat:@"%@",[sc objectForKey:@"goodsName"]];
        titleLabel.font=[UIFont systemFontOfSize:12];
        
        UILabel *shopnameLabel=[[UILabel alloc]initWithFrame:CGRectMake(99, 41+100*i, 214, 21)];
        shopnameLabel.text=[NSString stringWithFormat:@"商家：%@",[gdetail objectForKey:@"orgName"]];
        shopnameLabel.font=[UIFont systemFontOfSize:12];
        
        UILabel *countLabel=[[UILabel alloc]initWithFrame:CGRectMake(99, 65+100*i, 104, 21)];
        countLabel.text=[NSString stringWithFormat:@"数量：%@",[sc objectForKey:@"goodsNumber"]];
        countLabel.font=[UIFont systemFontOfSize:12];
        shopn=[NSString stringWithFormat:@"%@",[sc objectForKey:@"goodsNumber"]];
        
        UILabel *priceLabel=[[UILabel alloc]initWithFrame:CGRectMake(211, 65+100*i, 102, 21)];
        NSInteger pricec=[[NSString stringWithFormat:@"%@",[sc objectForKey:@"goodsPrice"]]integerValue]*
        [[NSString stringWithFormat:@"%@",[sc objectForKey:@"goodsNumber"]]integerValue];
        priceLabel.text=[NSString stringWithFormat:@"总价(元)：%d",pricec];
        priceLabel.font=[UIFont systemFontOfSize:12];
        priceLabel.textColor=[UIColor colorWithRed:244/255.0 green:160/255.0 blue:40/255.0 alpha:1];
        framesize=priceLabel.frame;
        pricecount=pricecount+pricec;
        
        [poSView addSubview:image];
        [poSView addSubview:titleLabel];
        [poSView addSubview:shopnameLabel];
        [poSView addSubview:countLabel];
        [poSView addSubview:priceLabel];
    }
    //总价格模块
    pricecountImage.frame=CGRectMake(pricecountImage.frame.origin.x, framesize.origin.y+30, pricecountImage.frame.size.width, pricecountImage.frame.size.height);
    
    pricecountLabel.frame=CGRectMake(pricecountLabel.frame.origin.x, pricecountImage.frame.origin.y, pricecountLabel.frame.size.width, pricecountLabel.frame.size.height);
    
    price.frame=CGRectMake(price.frame.origin.x, pricecountImage.frame.origin.y, price.frame.size.width, price.frame.size.height);
    price.text=[NSString stringWithFormat:@"%d",pricecount];
    
    
    //配送方式模块
    sendway.frame=CGRectMake(sendway.frame.origin.x, pricecountImage.frame.origin.y+10, sendway.frame.size.width, sendway.frame.size.height);
    
    sendwayImage.frame=CGRectMake(sendwayImage.frame.origin.x, sendway.frame.origin.y+10, sendwayImage.frame.size.width, sendwayImage.frame.size.height);
    
    shopname.frame=CGRectMake(shopname.frame.origin.x, sendwayImage.frame.origin.y-9, shopname.frame.size.width, shopname.frame.size.height);
    shopname.text=shopn;
    
    sendwayLabel.frame=CGRectMake(sendwayLabel.frame.origin.x, shopname.frame.origin.y+24, sendwayLabel.frame.size.width, sendwayLabel.frame.size.height);
    
    changesendwayButton.frame=CGRectMake(changesendwayButton.frame.origin.x, sendwayLabel.frame.origin.y-2, changesendwayButton.frame.size.width, changesendwayButton.frame.size.height);
    
    //配送地址模块
    addr.frame=CGRectMake(addr.frame.origin.x, sendwayImage.frame.origin.y+10, addr.frame.size.width, addr.frame.size.height);
    
//    detailLabel.numberOfLines=0;
//    CGSize size =CGSizeMake(detailLabel.frame.size.width,0);
//    UIFont * tfont = detailLabel.font;
//    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];    CGSize  actualsize =[[mydinfo objectForKey:@"postscript"] boundingRectWithSize:size options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
    addrLabel.frame=CGRectMake(addrLabel.frame.origin.x, addr.frame.origin.y+30, addrLabel.frame.size.width, addrLabel.frame.size.height);
    
    changeaddrButton.frame=CGRectMake(changeaddrButton.frame.origin.x, addrLabel.frame.origin.y+addrLabel.frame.size.height, changeaddrButton.frame.size.width, changeaddrButton.frame.size.height);
    
    
}

-(void)changesendway
{
    
}

-(void)changeaddr
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
