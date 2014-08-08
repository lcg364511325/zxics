//
//  fontindex.m
//  zxics
//
//  Created by johnson on 14-8-4.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "fontindex.h"

@interface fontindex ()

@end

@implementation fontindex

@synthesize functionscroll;
@synthesize functionpage;

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
    cplist * _cplist=[[cplist alloc] init];
    
    [self.navigationController pushViewController:_cplist animated:NO];
}

//个人管理首页
-(IBAction)personindex:(id)sender
{
    personIndex * _personIndex=[[personIndex alloc] init];
    
    [self.navigationController pushViewController:_personIndex animated:NO];
}

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

//登录页面跳转
-(IBAction)login:(id)sender
{
    login * _login=[[login alloc] init];
    
    [self.navigationController pushViewController:_login animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
