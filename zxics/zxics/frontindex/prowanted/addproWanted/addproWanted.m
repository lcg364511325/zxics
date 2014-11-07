//
//  addproWanted.m
//  zxics
//
//  Created by johnson on 14-11-7.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "addproWanted.h"
#import "DataService.h"

@interface addproWanted ()

@end

@implementation addproWanted

@synthesize titleText;
@synthesize addrText;
@synthesize addrDetailtext;
@synthesize userText;
@synthesize phoneText;
@synthesize emailtext;
@synthesize detailText;
@synthesize addrTView;
@synthesize UINavigationBar;

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
    [self.UINavigationBar setBackgroundImage:[UIImage imageNamed:@"logo_bg"] forBarMetrics:UIBarMetricsDefault];
    
    areadetail=nil;
    coutryid=@"";
    provinceid=@"";
    cityid=@"";
    districtid=@"";
    [self setTextView];
}

-(IBAction)goback:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

//创建textview
-(void)setTextView
{
    textView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(emailtext.frame.origin.x, emailtext.frame.origin.y+40, emailtext.frame.size.width, emailtext.frame.size.height)];
    textView.isScrollable = NO;
    textView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
    
	textView.minNumberOfLines = 1;
	textView.maxNumberOfLines = 6;
    // you can also set the maximum height in points with maxHeight
    // textView.maxHeight = 200.0f;
	textView.returnKeyType = UIReturnKeyGo; //just as an example
	textView.font = [UIFont systemFontOfSize:15.0f];
	textView.delegate = self;
    textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
    textView.backgroundColor = [UIColor whiteColor];
    textView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    textView.layer.borderWidth=0.5f;
    textView.layer.cornerRadius=3.0f;
    [self.view addSubview:textView];
}

-(IBAction)selected:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    if (oldbtn) {
        [oldbtn setImage:[UIImage imageNamed:@"noselect"] forState:UIControlStateNormal];
    }
    oldbtn=btn;
    [btn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
    type1=[NSString stringWithFormat:@"%d",btn.tag];
}

//查询地区数据
-(NSArray *)loaddata:(NSString *)cid type:(NSString *)type
{
    NSMutableDictionary * area = [NSMutableDictionary dictionaryWithCapacity:5];
    area=[DataService PostDataService:[NSString stringWithFormat:@"%@api/mobileOrederFindAddress",domainser] postDatas:[NSString stringWithFormat:@"id=%@&type=%@",cid,type]];
    NSArray *arealist=[area objectForKey:@"datas"];
    return arealist;
}

//选择地区
-(IBAction)searcharea:(id)sender
{
    addrTView.hidden=NO;
    list=[self loaddata:@"0" type:@"5"];
    [addrTView reloadData];
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
    NSDictionary *addetail=[list objectAtIndex:row];
    
    cell.textLabel.text =[addetail objectForKey:@"name"];
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *addetail=[list objectAtIndex:[indexPath row]];
    
    NSString *cid=[NSString stringWithFormat:@"%@",[addetail objectForKey:@"id"]];
    NSInteger type=[[NSString stringWithFormat:@"%@",[addetail objectForKey:@"type"]]integerValue];
    NSString *name=[addetail objectForKey:@"name"];
    
    if (oldtype==type) {
        areadetail=oldareadetail;
    }else
    {
        oldtype=type;
    }
    
    if (type==5) {
        coutryid=cid;
    }else if (type==6)
    {
        provinceid=cid;
    }else if (type==7)
    {
        cityid=cid;
    }else if (type==8)
    {
        districtid=cid;
    }
    
    list=[self loaddata:cid type:[NSString stringWithFormat:@"%d",type+1]];
    if ([list count]>0) {
        if (areadetail) {
            areadetail=[NSString stringWithFormat:@"%@%@",areadetail,name];
            addrText.text=areadetail;
            [addrTView reloadData];
        }else{
            areadetail=[NSString stringWithFormat:@"%@",name];
            addrText.text=areadetail;
            [addrTView reloadData];
        }
        
    }else{
        if (areadetail) {
            areadetail=[NSString stringWithFormat:@"%@%@",areadetail,name];
            addrText.text=areadetail;
            areadetail=nil;
            addrTView.hidden=YES;
        }else{
            areadetail=[NSString stringWithFormat:@"%@",name];
            addrText.text=areadetail;
            areadetail=nil;
            addrTView.hidden=YES;
        }
    }
    
}

-(IBAction)submitinfo:(id)sender
{
    if([titleText.text isEqualToString:@""] || [textView.text isEqualToString:@""] || [addrDetailtext.text isEqualToString:@""] || [userText.text isEqualToString:@""] || [phoneText.text isEqualToString:@""] || [emailtext.text isEqualToString:@""] || !type1 || [coutryid isEqualToString:@""] || [provinceid isEqualToString:@""] || [cityid isEqualToString:@""]){
        
        NSString *rowString =@"输入的内容不能为空";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        
    }else{
        
        AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
        NSMutableDictionary * state = [NSMutableDictionary dictionaryWithCapacity:5];
        
        
        state=[DataService PostDataService:[NSString stringWithFormat:@"%@api/mobileNeedRentAndBuyAdd",domainser] postDatas:[NSString stringWithFormat:@"title=%@&rentdetail=%@&renttype=%@&coutryid=%@&provinceid=%@&cityid=%@&townid=%@&address=%@&contacts=%@&phone=%@&emails=%@&createaccount=%@",titleText.text,textView.text,type1,coutryid,provinceid,cityid,districtid,addrDetailtext.text,userText.text,phoneText.text,emailtext.text,myDelegate.entityl.account]];
        
        NSString *rowString =[NSString stringWithFormat:@"%@",[state objectForKey:@"info"]];
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
    
}

//点击tableview以外的地方触发事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self.view];
    if (!CGRectContainsPoint([addrTView frame], pt)) {
        //to-do
        addrTView.hidden=YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
