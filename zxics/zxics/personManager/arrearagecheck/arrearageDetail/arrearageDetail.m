//
//  arrearageDetail.m
//  zxics
//
//  Created by johnson on 14-8-7.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "arrearageDetail.h"
#import "Commons.h"

@interface arrearageDetail ()

@end

@implementation arrearageDetail

@synthesize acc;
@synthesize accSView;
@synthesize tname;
@synthesize batchLabel;
@synthesize orgnameLabel;
@synthesize floornameLabel;
@synthesize moneyLabel;
@synthesize chargenameLabel;
@synthesize chargetypeLabel;
@synthesize chargewayLabel;
@synthesize areamoneyLabel;
@synthesize operTLabel;
@synthesize endTLabel;
@synthesize stateLabel;
@synthesize detailLabel;
@synthesize chargenoLabel;
@synthesize paymoney;

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
    
    [self loaddata];
}

-(void)loaddata
{
    NSDictionary *pc=[acc objectForKey:@"pc"];
    chargenoLabel.text=[NSString stringWithFormat:@"%@",[pc objectForKey:@"chargecode"]];
    
    batchLabel.text=[NSString stringWithFormat:@"%@",[pc objectForKey:@"times"]];
    
    orgnameLabel.text=[NSString stringWithFormat:@"%@",[acc objectForKey:@"shopName"]];
    
    floornameLabel.text=[NSString stringWithFormat:@"%@",[acc objectForKey:@"floorName"]];
    
    moneyLabel.text=[NSString stringWithFormat:@"%@",[pc objectForKey:@"charge"]];
    //收费名称
    chargenameLabel.text=tname;
    
    NSString *plantype=[NSString stringWithFormat:@"%@",[pc objectForKey:@"plantype"]];
    if ([plantype isEqualToString:@"0"]) {
        chargetypeLabel.text=@"自动生成";
    }else
    {
        chargetypeLabel.text=@"手动添加";
    }
    
    NSString *chargetype=[NSString stringWithFormat:@"%@",[pc objectForKey:@"chargetype"]];
    if ([chargetype isEqualToString:@"0"]) {
        chargewayLabel.text=@"按面积收费";
    }else
    {
        chargewayLabel.text=@"手动输入";
    }
    
    areamoneyLabel.text=[NSString stringWithFormat:@"%@",[pc objectForKey:@"price"]];
    
    Commons *_commons=[[Commons alloc]init];
    NSString *timestr=[NSString stringWithFormat:@"%@",[pc objectForKey:@"starttime"]];
    operTLabel.text=[_commons stringtoDate:timestr];
    
    timestr=[NSString stringWithFormat:@"%@",[pc objectForKey:@"endtime"]];
    endTLabel.text=[_commons stringtoDate:timestr];
    
    NSString *palystate=[NSString stringWithFormat:@"%@",[pc objectForKey:@"palystate"]];
    if ([palystate isEqualToString:@"0"]) {
        stateLabel.text=@"欠费";
        
    }else if ([palystate isEqualToString:@"1"])
    {
        stateLabel.text=@"已交";
        paymoney.title=nil;
    }
    
    detailLabel.text=[NSString stringWithFormat:@"%@",[pc objectForKey:@"comments"]];
    detailLabel.numberOfLines=0;
    CGSize size =CGSizeMake(detailLabel.frame.size.width,0);
    UIFont * tfont = detailLabel.font;
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
    CGSize  actualsize =[[pc objectForKey:@"comments"] boundingRectWithSize:size options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
    detailLabel.frame=CGRectMake(detailLabel.frame.origin.x, detailLabel.frame.origin.y, detailLabel.frame.size.width, actualsize.height+24);
    
    accSView.contentSize=CGSizeMake(320, detailLabel.frame.size.height+accSView.frame.size.height-250);
    accSView.showsHorizontalScrollIndicator=NO;//不显示水平滑动线
    accSView.showsVerticalScrollIndicator=YES;//不显示垂直滑动线
    accSView.scrollEnabled=YES;
    
}

-(IBAction)goback:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}


//缴费页面跳转
-(IBAction)payment:(id)sender
{
    Paymentfunction *_Paymentfunction=[[Paymentfunction alloc]init];
    [self.navigationController pushViewController:_Paymentfunction animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
