//
//  successorder.m
//  zxics
//
//  Created by johnson on 14-8-27.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "successorder.h"
#import "myorderDetail.h"
#import "yikatong.h"
#import "membercenter.h"
#import "AlixPayOrder.h"
#import "AlixLibService.h"
#import "PartnerConfig.h"
#import "DataSigner.h"
#import "AlixPayResult.h"
#import "DataVerifier.h"
#import "DataService.h"

@interface successorder ()

@end

@implementation successorder

@synthesize so;
@synthesize ordernoLabel;
@synthesize phoneLabel;
@synthesize sendway;
@synthesize price;
@synthesize payButton;
@synthesize checkorderButton;

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
    
    ordernoLabel.text=[NSString stringWithFormat:@"%@",[so objectForKey:@"info"]];
    phoneLabel.text=[NSString stringWithFormat:@"(提示：虚拟商品订单在成功支付后，取货/消费凭证信息将通过短信形式发送到手机号：%@，请注意查收，谢谢)",[so objectForKey:@"mobile"]];
    
    if ([sendway isEqualToString:@"5"]) {
        payButton.hidden=YES;
        checkorderButton.frame=CGRectMake(160, checkorderButton.frame.origin.y, checkorderButton.frame.size.width, checkorderButton.frame.size.height);
    }
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
    membercenter *_membercenter=[[membercenter alloc]init];
    [self.navigationController pushViewController:_membercenter animated:NO];
}

//查看订单
-(IBAction)checkorder:(id)sender
{
    myorderDetail *_myorderDetail=[[myorderDetail alloc]init];
    _myorderDetail.orderid=[NSString stringWithFormat:@"%@",[so objectForKey:@"oId"]];
    _myorderDetail.orderstate=@"0";
    [self.navigationController pushViewController:_myorderDetail animated:NO];
}


//支付
-(IBAction)pay:(id)sender
{
    if ([sendway isEqualToString:@"4"]) {
        yikatong *_yikatong=[[yikatong alloc]init];
        _yikatong.price=price;
        _yikatong.orderid=[NSString stringWithFormat:@"%@",[so objectForKey:@"oId"]];
        [self.navigationController pushViewController:_yikatong animated:NO];
    }else if ([sendway isEqualToString:@"2"])
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
    myd=[DataService PostDataService:[NSString stringWithFormat:@"%@api/mobileOrderNews",domainser] postDatas:[NSString stringWithFormat:@"oid=%@",[NSString stringWithFormat:@"%@",[so objectForKey:@"oId"]]]];
    NSArray *mydinfolist=[myd objectForKey:@"datas"];
    NSDictionary *mydinfo=[mydinfolist objectAtIndex:0];
    AlixPayOrder *order = [[AlixPayOrder alloc] init];
    order.partner = PartnerID;
    order.seller = SellerID;
    
    order.tradeNO = [mydinfo objectForKey:@"order_sn"]; //订单ID（由商家自行制定）
	order.productName = @"a"; //商品标题
	order.productDescription = @"b"; //商品描述
	order.amount = [NSString stringWithFormat:@"%.2f",[price floatValue]]; //商品价格
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
