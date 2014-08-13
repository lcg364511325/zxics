//
//  fontindex.m
//  zxics
//
//  Created by johnson on 14-8-4.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "fontindex.h"
#import "download.h"
#import "goodslist.h"

@interface fontindex ()

@end

@implementation fontindex

@synthesize functionscroll;
@synthesize functionpage;
@synthesize loginbutton;

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
    
    //设置scrollview属性
    _secondview.frame=CGRectMake(functionscroll.frame.size.width,               functionscroll.contentOffset.y, 320, 284);
    [functionscroll addSubview:_secondview];
    functionscroll.contentSize=CGSizeMake(functionscroll.frame.size.width*2, functionscroll.frame.size.height);
    functionscroll.showsHorizontalScrollIndicator=NO;//不显示水平滑动线
    functionscroll.showsVerticalScrollIndicator=NO;//不显示垂直滑动线
    functionscroll.pagingEnabled=YES;//scrollView不会停在页面之间，即只会显示第一页或者第二页，不会各一半显示
    
    //设置pagecontroller
    functionpage.numberOfPages=2;//设置页数为2
    functionpage.currentPage=0;//初始页码为 0
    functionpage.userInteractionEnabled=NO;//pagecontroller不响应点击操作
    
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    if (myDelegate.entityl) {
        loginbutton.titleLabel.text=@"退出";
    }else{
        loginbutton.titleLabel.text=@"登录";
    }
    
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if(scrollView==functionscroll){
        
        CGPoint offset = scrollView.contentOffset;
        functionpage.currentPage = offset.x / (self.view.bounds.size.width); //计算当前的页码
        [functionscroll setContentOffset:CGPointMake(functionscroll.frame.size.width * (functionpage.currentPage),               functionscroll.contentOffset.y) animated:YES]; //设置scrollview的显示为当前滑动到的页面
    }
}

//特殊人群关怀页面跳转
-(IBAction)specialpeople:(id)sender
{
    SpecialPeople * _SpecialPeople=[[SpecialPeople alloc] init];
    
    [self.navigationController pushViewController:_SpecialPeople animated:NO];
}

//生活管家页面跳转
-(IBAction)lifemd:(id)sender
{
    lifemd * _lifemd=[[lifemd alloc] init];
    
    [self.navigationController pushViewController:_lifemd animated:NO];
}

//投诉管理页面跳转
-(IBAction)complainlist:(id)sender
{
    complainlist * _complainlist=[[complainlist alloc] init];
    
    [self.navigationController pushViewController:_complainlist animated:NO];
}

//社区活动，物业通知页面跳转
-(IBAction)cplist:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    NSInteger btntag=btn.tag;
    cplist * _cplist=[[cplist alloc] init];
    _cplist.btntag=[NSString stringWithFormat:@"%d",btntag];
    [self.navigationController pushViewController:_cplist animated:NO];
}

//个人管理首页
-(IBAction)personindex:(id)sender
{
    personIndex * _personIndex=[[personIndex alloc] init];
    
    [self.navigationController pushViewController:_personIndex animated:NO];
}

//物业报修
-(IBAction)repairlist:(id)sender
{
    repairlist * _repairlist=[[repairlist alloc] init];
    
    [self.navigationController pushViewController:_repairlist animated:NO];
}

//在线调查页面跳转
-(IBAction)surveylist:(id)sender
{
    surveylist * _surveylist=[[surveylist alloc] init];
    
    [self.navigationController pushViewController:_surveylist animated:NO];
}

//下载管理页面跳转
-(IBAction)download:(id)sender
{
    download * _download=[[download alloc] init];
    
    [self.navigationController pushViewController:_download animated:NO];
}

//用户咨询页面跳转
-(IBAction)consultlist:(id)sender
{
    consultlist * _consultlist=[[consultlist alloc] init];
    
    [self.navigationController pushViewController:_consultlist animated:NO];
}

//招商信息页面跳转
-(IBAction)Merchantslist:(id)sender
{
    Merchantslist * _Merchantslist=[[Merchantslist alloc] init];
    
    [self.navigationController pushViewController:_Merchantslist animated:NO];
}

//常见问题页面跳转
-(IBAction)questionslist:(id)sender
{
    questionslist * _questionslist=[[questionslist alloc] init];
    
    [self.navigationController pushViewController:_questionslist animated:NO];
}

//物业出租出售页面跳转
-(IBAction)rentorshelllist:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    NSInteger btntag=btn.tag;
    rentorshelllist * _rentorshelllist=[[rentorshelllist alloc] init];
    _rentorshelllist.btntag=[NSString stringWithFormat:@"%d",btntag];
    [self.navigationController pushViewController:_rentorshelllist animated:NO];
}

//求租求购页面跳转
-(IBAction)prowantedlist:(id)sender
{
    prowantedlist * _prowantedlist=[[prowantedlist alloc] init];
    
    [self.navigationController pushViewController:_prowantedlist animated:NO];
}

//服务指南页面跳转
-(IBAction)serviceIndex:(id)sender
{
    serviceIndex * _serviceIndex=[[serviceIndex alloc] init];
    
    [self.navigationController pushViewController:_serviceIndex animated:NO];
}

//社区商城页面跳转
-(IBAction)goodslist:(id)sender
{
    goodslist * _goodslist=[[goodslist alloc] init];
    
    [self.navigationController pushViewController:_goodslist animated:NO];
}

//登录页面跳转
-(IBAction)login:(id)sender
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    if (myDelegate.entityl) {
        myDelegate.entityl=nil;
        NSString *rowString =@"退出成功";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        [self reloadInputViews];
    }else
    {
        login * _login=[[login alloc] init];
        
        [self.navigationController pushViewController:_login animated:NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
