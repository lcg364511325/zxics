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
    functionscroll.contentSize=CGSizeMake(functionscroll.frame.size.width*2, functionscroll.frame.size.height);
    functionscroll.showsHorizontalScrollIndicator=NO;//不显示水平滑动线
    functionscroll.showsVerticalScrollIndicator=NO;//不显示垂直滑动线
    functionscroll.pagingEnabled=YES;//scrollView不会停在页面之间，即只会显示第一页或者第二页，不会各一半显示
    
    //设置pagecontroller
    functionpage.numberOfPages=2;//设置页数为2
    functionpage.currentPage=1;//初始页码为 0
    functionpage.userInteractionEnabled=NO;//pagecontroller不响应点击操作
    [self scrollViewDidEndDecelerating:functionscroll];
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
