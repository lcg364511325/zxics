//
//  topupmoney.m
//  zxics
//
//  Created by johnson on 14-8-8.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "topupmoney.h"
#import "AppDelegate.h"
#import "DataService.h"
#import "AlixPayOrder.h"
#import "AlixLibService.h"
#import "PartnerConfig.h"
#import "DataSigner.h"
#import "AlixPayResult.h"
#import "DataVerifier.h"

@interface topupmoney ()

@end

@implementation topupmoney

@synthesize topupmoneyLabel;
@synthesize topupnoLabel;
@synthesize ordernoLabel;

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
    [self.UINavigationBar setBackgroundImage:[UIImage imageNamed:@"logo_bg"] forBarMetrics:UIBarMetricsDefault];    [self loaddata];
}

-(void)loaddata
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    NSMutableDictionary * vc = [NSMutableDictionary dictionaryWithCapacity:5];
    vc=[DataService PostDataService:[NSString stringWithFormat:@"%@api/findOtherKa",domainser] postDatas:[NSString stringWithFormat:@"userid=%@",myDelegate.entityl.userid]];
    topupnoLabel.text=[NSString stringWithFormat:@"%@",[vc objectForKey:@"thisUserKa"]];
    
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    ordernoLabel.text=[NSString stringWithFormat:@"c%@",[formatter stringFromDate:date]];
}

//账号充值
-(IBAction)topupmoney:(id)sender
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    NSMutableDictionary * state = [NSMutableDictionary dictionaryWithCapacity:5];
    state=[DataService PostDataService:[NSString stringWithFormat:@"%@api/saveorder",domainser] postDatas:[NSString stringWithFormat:@"order=%@&pCode=%@&money=%@&userid=%@",ordernoLabel.text,@"alipay",topupmoneyLabel.text,myDelegate.entityl.userid]];
    NSString *status=[NSString stringWithFormat:@"%@",[state objectForKey:@"status"]];
    if ([status isEqualToString:@"1"]) {
        [self zhifubao];
    }else{
        NSString *rowString =@"充值失败";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
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
    AlixPayOrder *order = [[AlixPayOrder alloc] init];
    order.partner = PartnerID;
    order.seller = SellerID;
    
    order.tradeNO = ordernoLabel.text; //订单ID（由商家自行制定）
	order.productName = @"账户充值"; //商品标题
	order.productDescription = @"账户充值"; //商品描述
	order.amount = [NSString stringWithFormat:@"%.2f",[topupmoneyLabel.text floatValue]]; //商品价格
	order.notifyURL =  [NSString stringWithFormat:@"%@api/mobilePayReturnAlipy",domainser]; //回调URL
	
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
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
