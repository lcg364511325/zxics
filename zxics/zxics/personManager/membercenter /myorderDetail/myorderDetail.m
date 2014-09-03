//
//  myorderDetail.m
//  zxics
//
//  Created by johnson on 14-8-8.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "myorderDetail.h"
#import "AppDelegate.h"
#import "DataService.h"
#import "Commons.h"
#import "myorder.h"
#import "yikatong.h"
#import "AlixPayOrder.h"
#import "AlixLibService.h"
#import "PartnerConfig.h"
#import "DataSigner.h"
#import "AlixPayResult.h"
#import "DataVerifier.h"

@interface myorderDetail ()

@end

@implementation myorderDetail

@synthesize orderscrollview;
@synthesize secondview;
@synthesize orderid;
@synthesize customernameLabel;
@synthesize consigneeLabel;
@synthesize orderCtimeLabel;
@synthesize consigneephoneLabel;
@synthesize paywayLabel;
@synthesize zipcodeLabel;
@synthesize consigneezipcodeLabel;
@synthesize distributionwayLabel;
@synthesize distributionchargeLabel;
@synthesize orderaffirmLabel;
@synthesize orderpayTLabel;
@synthesize ordersendTLabel;
@synthesize consigneeaddrLabel;
@synthesize shipperLabel;
@synthesize shipperconLabel;
@synthesize detailLabel;
@synthesize orderdetailLabel;
@synthesize paybutton;
@synthesize deleteButton;
@synthesize orderstate;

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
    
    _result = @selector(paymentResult:);
    
    [self loaddata];
}

-(void)loaddata
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    NSMutableDictionary * myd = [NSMutableDictionary dictionaryWithCapacity:5];
    myd=[DataService PostDataService:[NSString stringWithFormat:@"%@api/mobileOrderNews",domainser] postDatas:[NSString stringWithFormat:@"oid=%@",orderid]];
    NSArray *mydinfolist=[myd objectForKey:@"datas"];
    NSDictionary *mydinfo=[mydinfolist objectAtIndex:0];
    
    allprice=[NSString stringWithFormat:@"%@",[mydinfo objectForKey:@"order_amount"]];
    payid=[NSString stringWithFormat:@"%@",[mydinfo objectForKey:@"pay_id"]];
    //下单人的姓名
    customernameLabel.text=myDelegate.entityl.name;
    
    //收货人姓名
    consigneeLabel.text=[NSString stringWithFormat:@"%@",[mydinfo objectForKey:@"consignee"]];
    
    //订单生成时间
    Commons *_Commons=[[Commons alloc]init];
    NSString *timestr=[mydinfo objectForKey:@"add_time"];
    orderCtimeLabel.text=[_Commons stringtoDateforsecond:timestr];
    
    //收货人手机
    consigneephoneLabel.text=[NSString stringWithFormat:@"%@",[mydinfo objectForKey:@"mobile"]];
    
    //支付方式
    paywayLabel.text=[NSString stringWithFormat:@"%@",[mydinfo objectForKey:@"pay_name"]];
    
    //邮箱
    zipcodeLabel.text=[NSString stringWithFormat:@"%@",[mydinfo objectForKey:@"email"]];
    
    //收货人邮编
    consigneezipcodeLabel.text=[NSString stringWithFormat:@"%@",[mydinfo objectForKey:@"zipcode"]];
    
    //配送方式名称
    distributionwayLabel.text=[NSString stringWithFormat:@"%@",[mydinfo objectForKey:@"shipping_name"]];
    
    //配送费用
    distributionchargeLabel.text=[NSString stringWithFormat:@"%@",[mydinfo objectForKey:@"shipping_fee"]];
    
    //订单确认时间
    timestr=[mydinfo objectForKey:@"confirm_time"];
    orderaffirmLabel.text=[_Commons stringtoDateforsecond:timestr];
    
    //订单支付时间
    timestr=[mydinfo objectForKey:@"pay_time"];
    orderpayTLabel.text=[_Commons stringtoDateforsecond:timestr];
    
    //订单配送时间
    timestr=[mydinfo objectForKey:@"shipping_time"];
    ordersendTLabel.text=[_Commons stringtoDateforsecond:timestr];
    
    //收货人详细地址
    consigneeaddrLabel.text=[NSString stringWithFormat:@"%@",[mydinfo objectForKey:@"address"]];
    
    //发货人
    shipperLabel.text=[NSString stringWithFormat:@"%@",[mydinfo objectForKey:@"sname"]];
    
    //发货人联系方式
    shipperconLabel.text=[NSString stringWithFormat:@"%@",[mydinfo objectForKey:@"smobile"]];
    
    //订单附言
    detailLabel.text=[NSString stringWithFormat:@"订单附言：%@",[mydinfo objectForKey:@"postscript"]];
    detailLabel.numberOfLines=0;
    CGSize size =CGSizeMake(detailLabel.frame.size.width,0);
    UIFont * tfont = detailLabel.font;
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];    CGSize  actualsize =[[mydinfo objectForKey:@"postscript"] boundingRectWithSize:size options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
    detailLabel.frame=CGRectMake(detailLabel.frame.origin.x, detailLabel.frame.origin.y, detailLabel.frame.size.width, actualsize.height+24);
    
    //订单详情标题
    orderdetailLabel.frame=CGRectMake(orderdetailLabel.frame.origin.x, detailLabel.frame.origin.y+actualsize.height+20, orderdetailLabel.frame.size.width, orderdetailLabel.frame.size.height);
    
    NSMutableDictionary * gd = [NSMutableDictionary dictionaryWithCapacity:5];
    gd=[DataService PostDataService:[NSString stringWithFormat:@"%@api/mobileOrderGoodsDetails",domainser] postDatas:[NSString stringWithFormat:@"oid=%@",orderid]];
    NSArray *goodsdetaillist=[gd objectForKey:@"datas"];
    
    int i=0;
    CGRect framesize;
    for (NSDictionary *goodsdetail in goodsdetaillist) {
        //商品名称
        UILabel *goodsnameLabel=[[UILabel alloc]initWithFrame:CGRectMake(detailLabel.frame.origin.x, orderdetailLabel.frame.origin.y+40+230*i, 298, 21)];
        goodsnameLabel.text=[NSString stringWithFormat:@"商品名称：%@",[goodsdetail objectForKey:@"goods_name"]];
        
        //商品编号
        UILabel *goodsnoLabel=[[UILabel alloc]initWithFrame:CGRectMake(detailLabel.frame.origin.x, goodsnameLabel.frame.origin.y+30, 298, 21)];
        goodsnoLabel.text=[NSString stringWithFormat:@"商品号：%@",[goodsdetail objectForKey:@"goods_sn"]];
        
        //购买数量
        UILabel *goodscountLabel=[[UILabel alloc]initWithFrame:CGRectMake(detailLabel.frame.origin.x, goodsnoLabel.frame.origin.y+30, 298, 21)];
        goodscountLabel.text=[NSString stringWithFormat:@"数量：%@",[goodsdetail objectForKey:@"goods_number"]];
        
        //店家售价
        UILabel *shoppriLabel=[[UILabel alloc]initWithFrame:CGRectMake(detailLabel.frame.origin.x, goodscountLabel.frame.origin.y+30, 298, 21)];
        shoppriLabel.text=[NSString stringWithFormat:@"实际售价(元)：%@",[goodsdetail objectForKey:@"goods_price"]];
        
        //市场价
        UILabel *marketpriLabel=[[UILabel alloc]initWithFrame:CGRectMake(detailLabel.frame.origin.x, shoppriLabel.frame.origin.y+30, 298, 21)];
        marketpriLabel.text=[NSString stringWithFormat:@"市场售价(元)：%@",[goodsdetail objectForKey:@"market_price"]];
        
        //是否实物
        UILabel *isreadLabel=[[UILabel alloc]initWithFrame:CGRectMake(detailLabel.frame.origin.x, marketpriLabel.frame.origin.y+30, 298, 21)];
        NSString *isread=[NSString stringWithFormat:@"%@",[goodsdetail objectForKey:@"is_real"]];
        if ([isread isEqualToString:@"0"]) {
            
            isreadLabel.text=@"是否实物：否";
        }else if ([isread isEqualToString:@"1"])
        {
            isreadLabel.text=@"是否实物：是";
        }
        
        //发货状态
        UILabel *issendLabel=[[UILabel alloc]initWithFrame:CGRectMake(detailLabel.frame.origin.x, isreadLabel.frame.origin.y+30, 298, 21)];
        NSString *issend=[NSString stringWithFormat:@"%@",[goodsdetail objectForKey:@"send_number"]];
        if ([issend isEqualToString:@"0"]) {
            
            issendLabel.text=@"是否已发货：否";
        }else if ([isread isEqualToString:@"1"])
        {
            issendLabel.text=@"是否已发货：是";
        }
        [secondview addSubview:goodsnameLabel];
        [secondview addSubview:goodsnoLabel];
        [secondview addSubview:goodscountLabel];
        [secondview addSubview:shoppriLabel];
        [secondview addSubview:marketpriLabel];
        [secondview addSubview:isreadLabel];
        [secondview addSubview:issendLabel];
        framesize=issendLabel.frame;
        i++;
    }
    
    
    //按钮位置
    if ([orderstate isEqualToString:@"0"]) {
        deleteButton.hidden=NO;
        
        paybutton.frame=CGRectMake(paybutton.frame.origin.x, framesize.origin.y+40, paybutton.frame.size.width, paybutton.frame.size.height);
        deleteButton.frame=CGRectMake(deleteButton.frame.origin.x, framesize.origin.y+40, deleteButton.frame.size.width, deleteButton.frame.size.height);
    }else{
        paybutton.frame=CGRectMake(paybutton.frame.origin.x-60, framesize.origin.y+40, paybutton.frame.size.width, paybutton.frame.size.height);
    }
    
    //设置scrollview属性
    secondview.frame=CGRectMake(0, 0, 320, paybutton.frame.size.height+paybutton.frame.origin.y-customernameLabel.frame.origin.y+10);
    [orderscrollview addSubview:secondview];
    orderscrollview.contentSize=CGSizeMake(320, secondview.frame.size.height);
    orderscrollview.showsHorizontalScrollIndicator=NO;//不显示水平滑动线
    orderscrollview.showsVerticalScrollIndicator=YES;//不显示垂直滑动线
    orderscrollview.scrollEnabled=YES;//
}


//删除订单
-(IBAction)deleteorder:(id)sender
{
    NSMutableDictionary * state = [NSMutableDictionary dictionaryWithCapacity:5];
    state=[DataService PostDataService:[NSString stringWithFormat:@"%@api/mobileDelectMyOrder",domainser] postDatas:[NSString stringWithFormat:@"oId=%@",orderid]];
    NSString *rowString =@"确定删除此订单？";
    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alter.delegate=self;
    [alter show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        NSMutableDictionary * state = [NSMutableDictionary dictionaryWithCapacity:5];
        state=[DataService PostDataService:[NSString stringWithFormat:@"%@api/mobileDelectMyOrder",domainser] postDatas:[NSString stringWithFormat:@"oId=%@",orderid]];
        NSString *rowString =[NSString stringWithFormat:@"%@",[state objectForKey:@"info"]];
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alter.delegate=self;
        [alter show];
        [self goback:nil];
    }
}

-(IBAction)payfororder:(id)sender
{
    if ([payid isEqualToString:@"4"]) {
        yikatong *_yikatong=[[yikatong alloc]init];
        _yikatong.price=allprice;
        _yikatong.orderid=[NSString stringWithFormat:@"%@",orderid];
        [self.navigationController pushViewController:_yikatong animated:NO];
    }else if ([payid isEqualToString:@"2"])
    {
        [self zhifubao];
    }
}

//支付宝支付
-(void)zhifubao
{
    NSString *appScheme = @"zxics";
    NSString* orderInfo = [self getOrderInfo];
    NSString* signedStr = [self doRsa:orderInfo];
    
    NSLog(@"%@",signedStr);
    
    NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                             orderInfo, signedStr, @"RSA"];
    [AlixLibService payOrder:orderString AndScheme:appScheme seletor:_result target:self];
}


/*
 *初始化订单信息
 */
-(NSString*)getOrderInfo
{
    NSMutableDictionary * myd = [NSMutableDictionary dictionaryWithCapacity:5];
    myd=[DataService PostDataService:[NSString stringWithFormat:@"%@api/mobileOrderNews",domainser] postDatas:[NSString stringWithFormat:@"oid=%@",[NSString stringWithFormat:@"%@",orderid]]];
    NSArray *mydinfolist=[myd objectForKey:@"datas"];
    NSDictionary *mydinfo=[mydinfolist objectAtIndex:0];
    AlixPayOrder *order = [[AlixPayOrder alloc] init];
    order.partner = PartnerID;
    order.seller = SellerID;
    
    order.tradeNO = [mydinfo objectForKey:@"order_sn"]; //订单ID（由商家自行制定）
	order.productName = @"a"; //商品标题
	order.productDescription = @"b"; //商品描述
	order.amount = [NSString stringWithFormat:@"%.2f",[allprice floatValue]]; //商品价格
	order.notifyURL =  @"http%3A%2F%2Fwwww.xxx.com"; //回调URL
	
	return [order description];
}

-(NSString*)doRsa:(NSString*)orderInfo
{
    id<DataSigner> signer;
    signer = CreateRSADataSigner(PartnerPrivKey);
    NSString *signedString = [signer signString:orderInfo];
    return signedString;
}

//wap回调函数
-(void)paymentResult:(NSString *)resultd
{
    //结果处理
#if ! __has_feature(objc_arc)
    AlixPayResult* result = [[[AlixPayResult alloc] initWithString:resultd] autorelease];
#else
    AlixPayResult* result = [[AlixPayResult alloc] initWithString:resultd];
#endif
	if (result)
    {
		
		if (result.statusCode == 9000)
        {
			/*
			 *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
			 */
            
            //交易成功
            NSString* key = AlipayPubKey;//签约帐户后获取到的支付宝公钥
			id<DataVerifier> verifier;
            verifier = CreateRSADataVerifier(key);
            
			if ([verifier verifyString:result.resultString withSign:result.signString])
            {
                //验证签名成功，交易结果无篡改
			}
        }
        else
        {
            //交易失败
        }
    }
    else
    {
        //失败
    }
    
}


-(IBAction)goback:(id)sender
{
    myorder *_myorder=[[myorder alloc]init];
    [self.navigationController pushViewController:_myorder animated:NO];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
