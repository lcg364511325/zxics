//
//  editConservationPeople.m
//  zxics
//
//  Created by johnson on 15-3-9.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import "editConservationPeople.h"
#import "residentManager.h"
#import "myFloorList.h"
#import "blockCodeListView.h"
#import "DataService.h"
#import "Commons.h"

@interface editConservationPeople ()

@end

@implementation editConservationPeople

@synthesize nameText;
@synthesize cardtypeText;
@synthesize cardnoText;
@synthesize mobileText;
@synthesize signtimeText;
@synthesize cnameText;
@synthesize floornameText;
@synthesize blockcodeText;
@synthesize cardtypeView;
@synthesize uid;

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
    [self.UINavigationBar setBackgroundImage:[UIImage imageNamed:@"logo_bg"] forBarMetrics:UIBarMetricsDefault];
    
    if(uid==nil || [uid isEqualToString:@""])
    {
        [self.UINavigationItem setTitle:@"添加常住人口"];
    }else{
        [self loaddata];
    }
    myTypeDict = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"身份证",@"2",@"护照",@"3",@"军人证",@"4",@"香港证",@"5",@"台胞证",@"6",@"其他",nil];
    list=[NSArray arrayWithObjects:@"身份证",@"护照",@"军人证",@"香港证",@"台胞证",@"其他",nil];
}

-(void)loaddata
{
    Commons *_Commons=[[Commons alloc]init];
    NSMutableDictionary * pw = [NSMutableDictionary dictionaryWithCapacity:5];
    pw=[DataService PostDataService:[NSString stringWithFormat:@"%@api/getPropertyDetail",domainser] postDatas:[NSString stringWithFormat:@"id=%@",uid]];
    user=[pw objectForKey:@"data"];
    
    //姓名
    NSString *nameStr=[_Commons turnNullValue:@"name" Object:user];
    nameText.text=nameStr;
    
    //证件类型
    NSString *codetypeStr=[_Commons turnNullValue:@"codetype" Object:user];
    if ([codetypeStr isEqualToString:@"1"]) {
        codetypeStr=@"身份证";
    }else if ([codetypeStr isEqualToString:@"2"])
    {
        codetypeStr=@"护照";
    }else if ([codetypeStr isEqualToString:@"3"])
    {
        codetypeStr=@"军人证";
    }else if ([codetypeStr isEqualToString:@"4"])
    {
        codetypeStr=@"香港证";
    }else if ([codetypeStr isEqualToString:@"5"])
    {
        codetypeStr=@"台胞证";
    }else{
        codetypeStr=@"其他";
    }
    cardtypeText.text=codetypeStr;
    
    //证件号
    NSString *codeidStr=[_Commons turnNullValue:@"codeid" Object:user];
    cardnoText.text=codeidStr;
    
    //手机号码
    NSString *mobileStr=[_Commons turnNullValue:@"mobile" Object:user];
    mobileText.text=mobileStr;
    
    //签发日期
    NSString *issuedtimeStr=[_Commons turnNullValue:@"issuedtime" Object:user];
    if (![issuedtimeStr isEqualToString:@""]) {
        issuedtimeStr=[_Commons stringtoDateforsecond:issuedtimeStr];
    }
    signtimeText.text=issuedtimeStr;
    
    //社区名称
    NSString *cnameStr=[_Commons turnNullValue:@"cname" Object:user];
    cnameText.text=cnameStr;
    cid=[_Commons turnNullValue:@"communityid" Object:user];
    
    //楼盘
    NSString *floornameStr=[_Commons turnNullValue:@"fname" Object:user];;
    floornameText.text=floornameStr;
    fid=[_Commons turnNullValue:@"floorid" Object:user];
    
    NSString *pNubmberStr=[NSString stringWithFormat:@"%@",[pw objectForKey:@"pNubmber"]];
    if([pNubmberStr isEqualToString:@"<null>"] || [pNubmberStr isEqualToString:@"(null)"])
    {
        pNubmberStr=@"";
    }
    blockcodeText.text=pNubmberStr;
}



//提交数据到服务器
-(IBAction)saveEdit:(id)sender
{
    Commons *_Commons=[[Commons alloc]init];
    NSMutableDictionary * pw = [NSMutableDictionary dictionaryWithCapacity:5];
    NSString *cardtypevalue=@"";
    NSString *porternubmber=@"";
    if (uid) {
        cardtypevalue=[_Commons turnNullValue:@"codetype" Object:user];
        porternubmber=[_Commons turnNullValue:@"porternubmber" Object:user];
    }else{
        cardtypevalue=[myTypeDict objectForKey:cardtypeText.text];
        porternubmber=ids;
        uid=@"";
    }
    AppDelegate *mydelegate=[[UIApplication sharedApplication]delegate];
    
    
    pw=[DataService PostDataService:[NSString stringWithFormat:@"%@api/modifyPopulation",domainser] postDatas:[NSString stringWithFormat:@"id=%@&name=%@&codeid=%@&codetype=%@&mobile=%@&issuedtime=%@&communityid=%@&floorid=%@&porternubmber=%@&createaccount=%@",uid,nameText.text,cardnoText.text,cardtypevalue,mobileText.text,signtimeText.text,cid,fid,porternubmber,mydelegate.entityl.userid]];
    NSString *infoStr=[_Commons turnNullValue:@"info" Object:pw];
    backstate=[_Commons turnNullValue:@"status" Object:pw];
    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:infoStr delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alter show];
}

//alertview响应事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([backstate isEqualToString:@"1"]) {
        [self.navigationController popViewControllerAnimated:NO];
    }
    
}


//选择社区
-(IBAction)selectCommunity:(id)sender
{
    residentManager *_residentManager=[[residentManager alloc]init];
    _residentManager.type=@"1";
    _residentManager.delegate=self;
    [self.navigationController pushViewController:_residentManager animated:NO];
}


//传递值
-(void)passValue:(NSString *)value key:(NSString *)key tag:(NSInteger)tag
{
    if (tag==0) {
        cid=value;
        cnameText.text=key;
    }else if(tag==1){
        fid=value;
        floornameText.text=key;
    }else{
        ids=value;
        blockcodeText.text=key;
    }
}


//选择楼盘
-(IBAction)selectFloor:(id)sender
{
    if (cid==nil || [cid isEqualToString:@""]) {
        NSString *rowString =@"请先选择一个社区！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alter show];
    }else{
        myFloorList *_residentManager=[[myFloorList alloc]init];
        _residentManager.cid=cid;
        _residentManager.delegate=self;
        [self.navigationController pushViewController:_residentManager animated:NO];
    }
}

//选择门房卡
-(IBAction)selectBlock:(id)sender
{
    if (cid==nil || [cid isEqualToString:@""]) {
        NSString *rowString =@"请先选择一个社区！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alter show];
    }else{
        blockCodeListView *_residentManager=[[blockCodeListView alloc]init];
        _residentManager.cid=cid;
        _residentManager.delegate=self;
        [self.navigationController pushViewController:_residentManager animated:NO];
    }
}


//选择日期
- (IBAction)pickerAction:(id)sender{
    // Here we need to pass a full frame
    CustomIOS7AlertView *alertView = [[CustomIOS7AlertView alloc] init];
    
    // Add some custom content to the alert view
    [alertView setContainerView:[self createDemoView]];
    
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
        NSString *dateFromData = [NSString stringWithFormat:@"%@",datePickerView.date];
        NSString *date = [dateFromData substringWithRange:NSMakeRange(0, 10)];
        
        signtimeText.text=date;
        
        [alertView close];
    }
}

//日历选择
- (UIView *)createDemoView
{
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    
    datePickerView = [[UIDatePicker alloc] init];
    datePickerView.frame=CGRectMake(0, 10, 300, 216);
    datePickerView.locale=locale;
	datePickerView.autoresizingMask = UIViewAutoresizingNone;
	datePickerView.datePickerMode = UIDatePickerModeDate;
    [demoView addSubview:datePickerView];
    
    return demoView;
}


//后退
-(IBAction)goback:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}



//显示证件类型下拉框
-(IBAction)showcardtype:(id)sender
{
    cardtypeView.hidden=NO;
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
    NSUInteger row = [indexPath row];
    cell.backgroundColor=[UIColor colorWithRed:85.0f/255 green:224.0f/255 blue:253.0f/255 alpha:1];
    cell.textLabel.text = [list objectAtIndex:row];
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *carttype=[list objectAtIndex:[indexPath row]];
    cardtypeText.text=carttype;
    cardtypeView.hidden=YES;
    
}

//点击tableview以外的地方触发事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self.view];
    if (!CGRectContainsPoint([cardtypeView frame], pt)) {
        //to-do
        cardtypeView.hidden=YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
