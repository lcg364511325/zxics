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
#import "successorder.h"
#import "DeliveryaddressCell.h"

@interface placeorder ()

@end

@implementation placeorder

@synthesize shopid;
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
@synthesize messageLabel;
@synthesize scview;
@synthesize tableview;
@synthesize payway;
@synthesize yikaLabel;
@synthesize zhifuLabel;
@synthesize huodaoLabel;
@synthesize yiButton;
@synthesize zhiButton;
@synthesize huoButton;
@synthesize nowcount;

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
    pricecount=0;
    sendwaylist=[[NSMutableArray alloc]initWithCapacity:5];
    addrlist=[[NSMutableArray alloc]initWithCapacity:5];
    
    //查询配送方式和配送地址
    [self findsendwayandaddr];
    
    //商品数据添加
    [self loadgoodsdata];
}

-(IBAction)goback:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

//查询配送方式和配送地址
-(void)findsendwayandaddr
{
    //配送方式查询
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    NSMutableDictionary * sw = [NSMutableDictionary dictionaryWithCapacity:5];
    sw=[DataService PostDataService:[NSString stringWithFormat:@"%@api/mobileFindGoodsSendType",domainser] postDatas:[NSString stringWithFormat:@"orgid=%@",shopid]];
    NSArray *swlist=[sw objectForKey:@"datas"];
    [sendwaylist addObjectsFromArray:swlist];
    NSDictionary *swobject=[swlist objectAtIndex:0];
    swd=[NSString stringWithFormat:@"%@  %@",[swobject objectForKey:@"shipping_name"],[swobject objectForKey:@"insure"]];
    sendwayid=[NSString stringWithFormat:@"%@",[swobject objectForKey:@"shipping_id"]];
    pricecount=pricecount+[[NSString stringWithFormat:@"%@",[swobject objectForKey:@"insure"]]floatValue];
    
    //配送地址查询
    NSMutableDictionary * ar = [NSMutableDictionary dictionaryWithCapacity:5];
    ar=[DataService PostDataService:[NSString stringWithFormat:@"%@api/mobileFindUserGoodsAddress",domainser] postDatas:[NSString stringWithFormat:@"userid=%@",myDelegate.entityl.userid]];
    NSArray *arlist=[ar objectForKey:@"datas"];
    [addrlist addObjectsFromArray:arlist];
    NSDictionary *arobject=[arlist objectAtIndex:0];
    ard=[NSString stringWithFormat:@"%@ %@ (%@收) %@ %@",[arobject objectForKey:@"districtName"],[arobject objectForKey:@"address"],[arobject objectForKey:@"consignee"],[arobject objectForKey:@"mobile"],[arobject objectForKey:@"zipcode"]];
    addrid=[NSString stringWithFormat:@"%@",[arobject objectForKey:@"address_id"]];
}

//商品数据添加
-(void)loadgoodsdata
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    NSMutableDictionary * gl = [NSMutableDictionary dictionaryWithCapacity:5];
    gid=nil;
    for (NSString *rid in ridlist)
    {
        if (gid) {
            gid=[NSString stringWithFormat:@"%@,%@",gid,rid];
        }else
        {
            gid=rid;
        }
    }
    gl=[DataService PostDataService:[NSString stringWithFormat:@"%@api/mobileOrderCarGoods",domainser] postDatas:[NSString stringWithFormat:@"userid=%@&gid=%@",myDelegate.entityl.userid,gid]];
    NSArray *glist=[gl objectForKey:@"datas"];
    
    NSInteger count=[glist count];
    CGRect framesize;
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
        shopn=[NSString stringWithFormat:@"%@",[gdetail objectForKey:@"orgName"]];
        
         UILabel *countLabel=[[UILabel alloc]initWithFrame:CGRectMake(99, 65+100*i, 104, 21)];
        if (nowcount) {
            countLabel.text=[NSString stringWithFormat:@"数量：%@",nowcount];
        }else{
            countLabel.text=[NSString stringWithFormat:@"数量：%@",[sc objectForKey:@"goodsNumber"]];
            countLabel.font=[UIFont systemFontOfSize:12];
        }
        
        UILabel *priceLabel=[[UILabel alloc]initWithFrame:CGRectMake(211, 65+100*i, 102, 21)];
        float pricec=0.00f;
        if (nowcount) {
            pricec=[[NSString stringWithFormat:@"%@",[sc objectForKey:@"goodsPrice"]]integerValue]*
            [[NSString stringWithFormat:@"%@",nowcount]integerValue];
        }else{
            pricec=[[NSString stringWithFormat:@"%@",[sc objectForKey:@"goodsPrice"]]integerValue]*
            [[NSString stringWithFormat:@"%@",[sc objectForKey:@"goodsNumber"]]integerValue];
        }
        priceLabel.text=[NSString stringWithFormat:@"总价(元)：%.2f",pricec];
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
    price.text=[NSString stringWithFormat:@"%.2f元",pricecount];
    
    
    //配送方式模块
    sendway.frame=CGRectMake(sendway.frame.origin.x, pricecountImage.frame.origin.y+22, sendway.frame.size.width, sendway.frame.size.height);
    
    sendwayImage.frame=CGRectMake(sendwayImage.frame.origin.x, sendway.frame.origin.y+20, sendwayImage.frame.size.width, sendwayImage.frame.size.height);
    
    shopname.frame=CGRectMake(shopname.frame.origin.x, sendwayImage.frame.origin.y+2, shopname.frame.size.width, shopname.frame.size.height);
    shopname.text=shopn;
    
    sendwayLabel.frame=CGRectMake(sendwayLabel.frame.origin.x, shopname.frame.origin.y+24, sendwayLabel.frame.size.width, sendwayLabel.frame.size.height);
    sendwayLabel.text=swd;
    
    changesendwayButton.frame=CGRectMake(changesendwayButton.frame.origin.x, sendwayLabel.frame.origin.y-2, changesendwayButton.frame.size.width, changesendwayButton.frame.size.height);
    
    //配送地址模块
    addr.frame=CGRectMake(addr.frame.origin.x, sendwayImage.frame.origin.y+55, addr.frame.size.width, addr.frame.size.height);
    
    addrLabel.text=ard;
    addrLabel.numberOfLines=0;
    CGSize size =CGSizeMake(addrLabel.frame.size.width,0);
    UIFont * tfont = addrLabel.font;
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];    CGSize  actualsize =[ard boundingRectWithSize:size options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
    addrLabel.frame=CGRectMake(addrLabel.frame.origin.x, addr.frame.origin.y+10, addrLabel.frame.size.width, actualsize.height+24);
    
    changeaddrButton.frame=CGRectMake(changeaddrButton.frame.origin.x, addrLabel.frame.origin.y+addrLabel.frame.size.height, changeaddrButton.frame.size.width, changeaddrButton.frame.size.height);
    
    //支付方式
    payway.frame=CGRectMake(addr.frame.origin.x, changeaddrButton.frame.origin.y+20, payway.frame.size.width, addr.frame.size.height);
    
    yiButton.frame=CGRectMake(yiButton.frame.origin.x, payway.frame.origin.y+30, yiButton.frame.size.width, yiButton.frame.size.height);
    yikaLabel.frame=CGRectMake(yikaLabel.frame.origin.x, payway.frame.origin.y+28, yikaLabel.frame.size.width, yikaLabel.frame.size.height);
    
    zhiButton.frame=CGRectMake(zhiButton.frame.origin.x, yiButton.frame.origin.y+30, zhiButton.frame.size.width, zhiButton.frame.size.height);
    zhifuLabel.frame=CGRectMake(zhifuLabel.frame.origin.x, yiButton.frame.origin.y+28, zhifuLabel.frame.size.width, zhifuLabel.frame.size.height);
    
    huoButton.frame=CGRectMake(huoButton.frame.origin.x, zhifuLabel.frame.origin.y+30, huoButton.frame.size.width, huoButton.frame.size.height);
    huodaoLabel.frame=CGRectMake(huodaoLabel.frame.origin.x, zhifuLabel.frame.origin.y+28, huodaoLabel.frame.size.width, huodaoLabel.frame.size.height);
    
    
    //留言模块
    messageLabel.frame=CGRectMake(addr.frame.origin.x, zhifuLabel.frame.origin.y+60, messageLabel.frame.size.width, messageLabel.frame.size.height);
    
    textView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(addr.frame.origin.x, messageLabel.frame.origin.y+40, 280, 30)];
    textView.isScrollable = NO;
    textView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
    
	textView.minNumberOfLines = 1;
	textView.maxNumberOfLines = 6;
    // you can also set the maximum height in points with maxHeight
    // textView.maxHeight = 200.0f;
	textView.returnKeyType = UIReturnKeyGo; //just as an example
	textView.font = [UIFont systemFontOfSize:15.0f];
	textView.delegate = self;
    textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
    textView.backgroundColor = [UIColor whiteColor];
    textView.layer.borderColor=[UIColor blueColor].CGColor;
    textView.layer.borderWidth=1.0f;
    textView.layer.cornerRadius=3.0f;
    [poSView addSubview:textView];
    
    //设置scrollview属性
    poSView.contentSize=CGSizeMake(320, addrLabel.frame.size.height+poSView.frame.size.height+90*count);
    poSView.showsHorizontalScrollIndicator=NO;//不显示水平滑动线
    poSView.showsVerticalScrollIndicator=YES;//不显示垂直滑动线
    poSView.scrollEnabled=YES;//
    
    
}

//更改数据页面
- (IBAction)pickerAction:(id)sender{
    
    UIButton *btn=(UIButton *)sender;
    btntag=btn.tag;
    if (btntag==0) {
        list=sendwaylist;
    }else
    {
        list=addrlist;
    }
    [tableview reloadData];
    // Here we need to pass a full frame
    CustomIOS7AlertView *alertView = [[CustomIOS7AlertView alloc] init];
    
    // Add some custom content to the alert view
    [alertView setContainerView:[self scview]];
    
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
        [self loadgoodsdata];
        [alertView close];
    }
}

//初始化tableview数据
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [list count];
    //只有一组，数组数即为行数。
}

// tableview数据显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (btntag==0) {
        static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableSampleIdentifier];
        }
        NSDictionary *detail = [list objectAtIndex:[indexPath row]];
        if (btntag==0) {
            cell.textLabel.text = [NSString stringWithFormat:@"%@  %@",[detail objectForKey:@"shipping_name"],[detail objectForKey:@"insure"]];;
        }else{
            cell.textLabel.text=[NSString stringWithFormat:@"%@ %@ (%@收) %@ %@",[detail objectForKey:@"districtName"],[detail objectForKey:@"address"],[detail objectForKey:@"consignee"],[detail objectForKey:@"mobile"],[detail objectForKey:@"zipcode"]];
        }
        
        return cell;
    }else
    {
        static NSString *TableSampleIdentifier = @"DeliveryaddressCell";
        
        DeliveryaddressCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
        if (cell == nil) {
            NSArray * nib=[[NSBundle mainBundle]loadNibNamed:@"DeliveryaddressCell" owner:self options:nil];
            cell=[nib objectAtIndex:0];
        }
        NSDictionary *dadetail = [list objectAtIndex:[indexPath row]];
        
        cell.addrLabel.text=[NSString stringWithFormat:@"%@ %@ (%@收) %@ %@",[dadetail objectForKey:@"districtName"],[dadetail objectForKey:@"address"],[dadetail objectForKey:@"consignee"],[dadetail objectForKey:@"mobile"],[dadetail objectForKey:@"zipcode"]];
        
        return cell;
    }
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *detail = [list objectAtIndex:[indexPath row]];
    if (btntag==0) {
        pricecount=0;
        swd = [NSString stringWithFormat:@"%@  %@",[detail objectForKey:@"shipping_name"],[detail objectForKey:@"insure"]];
        sendwayid=[NSString stringWithFormat:@"%@",[detail objectForKey:@"shipping_id"]];
        pricecount=pricecount+[[NSString stringWithFormat:@"%@",[detail objectForKey:@"insure"]]integerValue];
    }else{
        ard=[NSString stringWithFormat:@"%@ %@ (%@收) %@ %@",[detail objectForKey:@"districtName"],[detail objectForKey:@"address"],[detail objectForKey:@"consignee"],[detail objectForKey:@"mobile"],[detail objectForKey:@"zipcode"]];
        addrid=[NSString stringWithFormat:@"%@",[detail objectForKey:@"address_id"]];
    }

    
}

//选择支付方式
-(IBAction)selectedpaywao:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    paywayvalue=btn.tag;
    zhiButton.backgroundColor=huoButton.backgroundColor=yiButton.backgroundColor=[UIColor lightGrayColor];
    btn.backgroundColor=[UIColor redColor];
    
}

//生成订单
-(IBAction)createorder:(id)sender
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    NSMutableDictionary * state = [NSMutableDictionary dictionaryWithCapacity:5];
    if (nowcount) {
        state=[DataService PostDataService:[NSString stringWithFormat:@"%@api/mobileCreateGoodsOrderBuyNow",domainser] postDatas:[NSString stringWithFormat:@"pay=%d&addr=%@&lmsn=%@&mId=%@&gId=%@&gNum=%@&ship=%@",paywayvalue,addrid,textView.text,myDelegate.entityl.userid,gid,nowcount,sendwayid]];
    }else{
        state=[DataService PostDataService:[NSString stringWithFormat:@"%@api/mobileCreateGoodsOrder",domainser] postDatas:[NSString stringWithFormat:@"userid=%@&pay=%d&gids=%@&addr=%@&lMsn=%@&ships=%@_%@",myDelegate.entityl.userid,paywayvalue,gid,addrid,textView.text,sendwayid,shopid]];
    }
    NSString *status=[NSString stringWithFormat:@"%@",[state objectForKey:@"status"]];
    if ([status isEqualToString:@"1"]) {
        successorder *_successorder=[[successorder alloc]init];
        _successorder.so=state;
        _successorder.price=[NSString stringWithFormat:@"%.2fs",pricecount];
        _successorder.sendway=[NSString stringWithFormat:@"%d",paywayvalue];;
        [self.navigationController pushViewController:_successorder animated:NO];
    }else
    {
        NSString *rowString =[NSString stringWithFormat:@"%@",[state objectForKey:@"info"]];
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
