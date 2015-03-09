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
#import "communityIndex.h"
#import "wuyeIndex.h"

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
    
    //顶部菜单
    [self createtopmenu];
    
    //判断是否已登录
    [self islogin];
}

//添加controller
-(void)addcontroller:(NSString *)orgid
{
    if (orgid) {
        communityIndex *_fontindex=[[communityIndex alloc]init];
        wuyeIndex *_findservice=[[wuyeIndex alloc]init];
        self.viewControllers=[NSArray arrayWithObjects:_fontindex,_findservice,nil];
    }else{
        fontindex *_fontindex=[[fontindex alloc]init];
        findservice *_findservice=[[findservice alloc]init];
        mallindex *_mallindex=[[mallindex alloc]init];
        serviceIndex *_serviceIndex=[[serviceIndex alloc]init];
        self.viewControllers=[NSArray arrayWithObjects:_fontindex,_findservice,_mallindex,_serviceIndex, nil];
    }
}


//顶部菜单
-(void)createtopmenu
{
    //菜单背景
    UIView *topview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    UIImageView *topimg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    [topimg setImage:[UIImage imageNamed:@"logo_bg"]];
    
    //logo图片
    UIImageView *logoimg=[[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 100, 30)];
    [logoimg setImage:[UIImage imageNamed:@"logo_title"]];
    [topview addSubview:logoimg];
    
    //登录按钮
    settingbtn=[[UIButton alloc]initWithFrame:CGRectMake(275, 5, 30, 30)];
    [settingbtn setImage:[UIImage imageNamed:@"login_title"] forState:UIControlStateNormal];
    [settingbtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchDown];
    [topview addSubview:settingbtn];
    

    [self.view addSubview:topimg];
    [self.view addSubview:topview];
}


//自定义tabbar
-(void)identitytabbar
{
    
    //删除现有的tabBar
    [self.tabBar setFrame:CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y-1, self.tabBar.frame.size.width, 50)];
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
        NSString *selStr=@"";
        if (count==2) {
            selStr=@"wuye";
        }else{
            selStr=@"TabBar";
        }
        
        NSString *imageName = [NSString stringWithFormat:@"%@%d", selStr,i + 1];
        NSString *imageNameSel = [NSString stringWithFormat:@"%@%dSel", selStr,i + 1];
        
        UIImage *image = [UIImage imageNamed:imageName];
        UIImage *imageSel = [UIImage imageNamed:imageNameSel];
        
        [myView addButtonWithImage:image selectedImage:imageSel];
    }
}

//判断是否已登录
-(void)islogin
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    if (myDelegate.entityl.userid) {
        
        NSString *orgid=[NSString stringWithFormat:@"%@",myDelegate.entityl.orgId];
        if (orgid!=nil && ![orgid isEqualToString:@""]) {
            
            UILabel *wname=[[UILabel alloc]init];
            wname.font=[UIFont systemFontOfSize:12.0f];
            wname.frame=CGRectMake(self.view.frame.size.width/2+10, (40-40/3)/2, 100, 40/3);
            wname.text=[NSString stringWithFormat:@"%@",myDelegate.entityl.name];
            [self.view addSubview:wname];
            
            [settingbtn setImage:[UIImage imageNamed:@"t_quit"] forState:UIControlStateNormal];
            [settingbtn removeTarget:self action:@selector(login) forControlEvents:UIControlEventTouchDown];
            [settingbtn addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchDown];
            
            
            [self addcontroller:myDelegate.entityl.orgId];
        }else{
            
            //头像
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                // 耗时的操作（异步操作）
                
                [settingbtn setImage:[UIImage imageNamed:@"head_portrait"] forState:UIControlStateNormal];
                NSString *url=[NSString stringWithFormat:@"%@",myDelegate.entityl.headimg];
                NSURL *imgUrl=[NSURL URLWithString:url];
                NSData* data = [NSData dataWithContentsOfURL:imgUrl];
                UIImage *img=[UIImage imageWithData:data];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [settingbtn setImage:img forState:UIControlStateNormal];
                    
                });
            });
            
            
            scomtext.text=myDelegate.entityl.communityName;
            [settingbtn removeTarget:self action:@selector(login) forControlEvents:UIControlEventTouchDown];
            [settingbtn addTarget:self action:@selector(personindex) forControlEvents:UIControlEventTouchDown];
            [self addcontroller:nil];
            
            //选择社区背景图
            UIImageView *comimg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 40, 320, 30)];
            [comimg setBackgroundColor:[UIColor colorWithRed:75/255.0 green:192/255.0 blue:250/255.0 alpha:1.0f]];
            [self.view addSubview:comimg];
            
            //选择社区
            UILabel *selectcom=[[UILabel alloc]initWithFrame:CGRectMake(65, 40, 100, 30)];
            [selectcom setFont:[UIFont boldSystemFontOfSize:15.0f]];
            selectcom.text=@"选择小区:";
            [selectcom setTextColor:[UIColor whiteColor]];
            [self.view addSubview:selectcom];
            
            //社区按钮
            UIButton *selectcombtn=[[UIButton alloc]initWithFrame:CGRectMake(215, 44, 20, 20)];
            [selectcombtn setImage:[UIImage imageNamed:@"scombtn"] forState:UIControlStateNormal];
            [selectcombtn addTarget:self action:@selector(showmycom) forControlEvents:UIControlEventTouchDown];
            [self.view addSubview:selectcombtn];
            
            //社区text
            scomtext=[[UITextField alloc]initWithFrame:CGRectMake(135, 44, 80, 19)];
            [scomtext setBorderStyle:UITextBorderStyleNone];
            [scomtext setBackgroundColor:[UIColor whiteColor]];
            scomtext.userInteractionEnabled=NO;
            scomtext.font=[UIFont boldSystemFontOfSize:12.0f];
            [self.view addSubview:scomtext];
            
            //社区下拉框
            comTView=[[UITableView alloc]initWithFrame:CGRectMake(135, 63, 100, 100)];
            comTView.delegate=self;
            comTView.dataSource=self;
            comTView.hidden=YES;
            [self.view addSubview:comTView];
            
            NSMutableDictionary * comlist = [NSMutableDictionary dictionaryWithCapacity:5];
            comlist=[DataService PostDataService:[NSString stringWithFormat:@"%@api/findCommunityList",domainser] postDatas:[NSString stringWithFormat:@"userid=%@",myDelegate.entityl.userid]];
            NSArray *com=[comlist objectForKey:@"datas"];
            [list removeAllObjects];
            [list addObjectsFromArray:com];
            
            if ([list count]>0) {
                AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
                NSDictionary *retype=[list objectAtIndex:0];
                myDelegate.entityl.communityid=[retype objectForKey:@"id"];
                myDelegate.entityl.communityName=[retype objectForKey:@"name"];
                scomtext.text=myDelegate.entityl.communityName;
            }
        }
        
    }else{
//        [self.view removeFromSuperview];
        [self addcontroller:nil];
    }
    
    //自定义tabbar
    [self identitytabbar];
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
    login * _login=[[login alloc] init];
    
    [self.navigationController pushViewController:_login animated:NO];
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
    cell.textLabel.font=[UIFont boldSystemFontOfSize:10.0f];
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
    scomtext.text=myDelegate.entityl.communityName;
    comTView.hidden=YES;
    
}

//退出登录
-(void)logout
{
    NSString *rowString =@"是否退出登录？";
    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alter show];
}

//alertview响应事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
        myDelegate.entityl=nil;
        
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
