//
//  decorateView.m
//  zhubao_iphone
//
//  Created by johnson on 14-9-11.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "decorateView.h"
#import "XNTabBarButton.h"
#import "login.h"
#import "fontindex.h"
#import "findservice.h"
#import "mallindex.h"
#import "serviceIndex.h"
#import "AppDelegate.h"
#import "DataService.h"
#import "ImageCacher.h"

@interface decorateView ()

/**
 *  设置之前选中的按钮
 */
@property (nonatomic, weak) UIButton *selectedBtn;

@end

@implementation decorateView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    list=[[NSMutableArray alloc]initWithCapacity:1];
    
    //添加controller
    [self addcontroller];
    
    //顶部菜单
    [self createtopmenu];
    
    //自定义tabbar
    [self identitytabbar];
    
    //判断是否已登录
    [self islogin];
    
    
}

//添加controller
-(void)addcontroller
{
    fontindex *_fontindex=[[fontindex alloc]init];
    findservice *_findservice=[[findservice alloc]init];
    mallindex *_mallindex=[[mallindex alloc]init];
    serviceIndex *_serviceIndex=[[serviceIndex alloc]init];
    self.viewControllers=[NSArray arrayWithObjects:_fontindex,_findservice,_mallindex,_serviceIndex, nil];
}


//顶部菜单
-(void)createtopmenu
{
    //菜单背景
    UIView *topview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 94)];
    UIImageView *topimg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [topimg setImage:[UIImage imageNamed:@"logo_bg"]];
    
    //logo图片
    UIImageView *logoimg=[[UIImageView alloc]initWithFrame:CGRectMake(24, 20, 70, 30)];
    [logoimg setImage:[UIImage imageNamed:@"logo_title"]];
    [topview addSubview:logoimg];
    
    //登录按钮
    settingbtn=[[UIButton alloc]initWithFrame:CGRectMake(245, 15, 40, 40)];
    [settingbtn setImage:[UIImage imageNamed:@"login_title"] forState:UIControlStateNormal];
    [settingbtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchDown];
    [topview addSubview:settingbtn];
    
    //选择社区背景图
    UIImageView *comimg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 64, 320, 30)];
    [comimg setBackgroundColor:[UIColor colorWithRed:75/255.0 green:192/255.0 blue:250/255.0 alpha:1.0f]];
    [topview addSubview:comimg];
    
    //选择社区
    UILabel *selectcom=[[UILabel alloc]initWithFrame:CGRectMake(85, 64, 50, 30)];
    [selectcom setFont:[UIFont boldSystemFontOfSize:12.0f]];
    selectcom.text=@"选择小区";
    [selectcom setTextColor:[UIColor whiteColor]];
    [topview addSubview:selectcom];
    
    //社区按钮
    UIButton *selectcombtn=[[UIButton alloc]initWithFrame:CGRectMake(215, 68, 20, 20)];
    [selectcombtn setImage:[UIImage imageNamed:@"scombtn"] forState:UIControlStateNormal];
    [selectcombtn addTarget:self action:@selector(showmycom) forControlEvents:UIControlEventTouchDown];
    [topview addSubview:selectcombtn];
    
    //社区text
    scomtext=[[UITextField alloc]initWithFrame:CGRectMake(135, 68, 80, 19)];
    [scomtext setBorderStyle:UITextBorderStyleNone];
    [scomtext setBackgroundColor:[UIColor whiteColor]];
    scomtext.userInteractionEnabled=NO;
    scomtext.font=[UIFont boldSystemFontOfSize:12.0f];
    [topview addSubview:scomtext];
    
    //社区下拉框
    comTView=[[UITableView alloc]initWithFrame:CGRectMake(135, 87, 100, 100)];
    comTView.delegate=self;
    comTView.dataSource=self;
    comTView.hidden=YES;
    

    [self.view addSubview:topimg];
    [self.view addSubview:topview];
    [self.view addSubview:comTView];
}


//自定义tabbar
-(void)identitytabbar
{
    
    //删除现有的tabBar
    [self.tabBar setFrame:CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y-11, self.tabBar.frame.size.width, 60)];
    CGRect rect = self.tabBar.bounds; //这里要用bounds来加, 否则会加到下面去.看不见
    //LogFrame(self.tabBar);
    
    //测试添加自己的视图
    NSUInteger count=self.viewControllers.count;
    UIImageView *bgimg=[[UIImageView alloc]initWithFrame:rect];
    [bgimg setImage:[UIImage imageNamed:@"footer_bg1"]];
    for (int i=0; i<count-1; i++) {
        if (i>0) {
            UIImageView *lineimg=[[UIImageView alloc]init];
            [lineimg setImage:[UIImage imageNamed:@"footer_line"]];
            NSInteger width=self.view.frame.size.width/count;
            lineimg.frame=CGRectMake(width*(i+1), 0, 2, 50);
            [bgimg addSubview:lineimg];
        }
    }
    [self.tabBar addSubview:bgimg];
    XNTabBar *myView = [[XNTabBar alloc] init]; //设置代理必须改掉前面的类型,不能用UIView
    myView.delegate = self; //设置代理
    myView.frame = rect;
    [self.tabBar addSubview:myView]; //添加到系统自带的tabBar上, 这样可以用的的事件方法. 而不必自己去写
    
    //为控制器添加按钮
    for (int i=0; i<count; i++) { //根据有多少个子视图控制器来进行添加按钮
        
        NSString *imageName = [NSString stringWithFormat:@"TabBar%d", i + 1];
        NSString *imageNameSel = [NSString stringWithFormat:@"TabBar%dSel", i + 1];
        
        UIImage *image = [UIImage imageNamed:imageName];
        UIImage *imageSel = [UIImage imageNamed:imageNameSel];
        
        [myView addButtonWithImage:image selectedImage:imageSel];
    }
}

//判断是否已登录
-(void)islogin
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    if (myDelegate.entityl) {
        //头像
        NSString *url=[NSString stringWithFormat:@"%@",myDelegate.entityl.headimg];
        NSURL *imgUrl=[NSURL URLWithString:url];
        NSData* data = [NSData dataWithContentsOfURL:imgUrl];
        UIImage *img=[UIImage imageWithData:data];
        [settingbtn setImage:img forState:UIControlStateNormal];
        settingbtn.layer.cornerRadius = settingbtn.frame.size.width / 2;
        settingbtn.clipsToBounds = YES;
        settingbtn.layer.borderWidth = 3.0f;
        settingbtn.layer.borderColor = [UIColor whiteColor].CGColor;
        
        scomtext.text=myDelegate.entityl.communityName;
        [settingbtn removeTarget:self action:@selector(login) forControlEvents:UIControlEventTouchDown];
        [settingbtn addTarget:self action:@selector(personindex) forControlEvents:UIControlEventTouchDown];
    }
}

/**永远别忘记设置代理*/
- (void)tabBar:(XNTabBar *)tabBar selectedFrom:(NSInteger)from to:(NSInteger)to {
    self.selectedIndex = to;
    CATransition *animation =[CATransition animation];
    [animation setDuration:0.75f];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromRight];
    [self.view.layer addAnimation:animation forKey:@"change"];
    
    int index = self.selectedIndex;
    NSLog(@"tabbarSelected index:%d",index);
}


//点击settingview以外的地方触发事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self.view];
    if (!CGRectContainsPoint([comTView frame], pt)) {
        //to-do
        comTView.hidden=YES;
    }
}

//登录页面跳转
-(void)login
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

//个人管理首页
-(void)personindex
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    if (myDelegate.entityl) {
        personIndex * add = [[personIndex alloc] initWithNibName:NSStringFromClass([personIndex class]) bundle:nil];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:add];
        [self presentViewController:nav animated:NO completion:nil];
    }else{
        NSString *rowString =@"请先登陆！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
}

// 显示社区列表
-(void)showmycom
{
    comTView.hidden=NO;
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    if (myDelegate.entityl) {
        NSMutableDictionary * comlist = [NSMutableDictionary dictionaryWithCapacity:5];
        comlist=[DataService PostDataService:[NSString stringWithFormat:@"%@api/findCommunityList",domainser] postDatas:[NSString stringWithFormat:@"userid=%@",myDelegate.entityl.userid]];
        NSArray *com=[comlist objectForKey:@"datas"];
        [list removeAllObjects];
        [list addObjectsFromArray:com];
        
        [comTView reloadData];
    }
}

//alertview响应事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
}

//初始化tableview数据
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [list count];
    //只有一组，数组数即为行数。
}

// tableview数据显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableSampleIdentifier];
    }
    cell.textLabel.font=[UIFont boldSystemFontOfSize:12.0f];
    NSUInteger row = [indexPath row];
    NSDictionary *retype=[list objectAtIndex:row];
    cell.textLabel.text = [retype objectForKey:@"name"];
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    NSUInteger row = [indexPath row];
    NSDictionary *retype=[list objectAtIndex:row];
    myDelegate.entityl.communityid=[retype objectForKey:@"id"];
    myDelegate.entityl.communityName=[retype objectForKey:@"name"];
    NSString *rowString =@"切换成功";
    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alter show];
    scomtext.text=myDelegate.entityl.communityName;
    comTView.hidden=YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
