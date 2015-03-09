//
//  wyCManagerDetail.m
//  zxics
//
//  Created by johnson on 15-3-6.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import "wyCManagerDetail.h"
#import "Commons.h"
#import "DataService.h"

@interface wyCManagerDetail ()

@end

//解决scrollview无法响应view的touch事件
@implementation UIScrollView (UITouchEvent)

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesBegan:touches withEvent:event];
    [super touchesBegan:touches withEvent:event];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesMoved:touches withEvent:event];
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesEnded:touches withEvent:event];
    [super touchesEnded:touches withEvent:event];
}

@end


@implementation wyCManagerDetail

@synthesize cid;

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
    
    [self loaddata];
}

-(void)loaddata
{
    Commons* _Commons=[[Commons alloc]init];
    NSMutableDictionary * pw = [NSMutableDictionary dictionaryWithCapacity:5];
    pw=[DataService PostDataService:[NSString stringWithFormat:@"%@api/getReplyFixDetail",domainser] postDatas:[NSString stringWithFormat:@"id=%@",cid]];
    NSDictionary *message=[pw objectForKey:@"data"];
    
    suview=[[UIScrollView alloc]init];
    
    //标题
    UILabel *titleLable=[[UILabel alloc]init];
    NSString *titleStr=[_Commons turnNullValue:@"title" Object:message];
    titleLable.font=[UIFont systemFontOfSize:12.0f];
    titleLable.text=[NSString stringWithFormat:@"标题：%@",titleStr];
    titleLable.frame=CGRectMake(7, 5, self.view.frame.size.width-6, 18);
    [suview addSubview:titleLable];
    
    //时间
    UILabel *timeLable=[[UILabel alloc]init];
    NSString *timeStr=[_Commons turnNullValue:@"send_date" Object:message];
    timeStr=[_Commons stringtoDateforsecond:timeStr];
    timeLable.font=[UIFont systemFontOfSize:12.0f];
    timeLable.text=[NSString stringWithFormat:@"时间：%@",timeStr];
    timeLable.frame=CGRectMake(7, titleLable.frame.origin.y+24, self.view.frame.size.width-6, 18);
    [suview addSubview:timeLable];
    
    //发送人
    UILabel *senderLable=[[UILabel alloc]init];
    NSString *senderStr=[_Commons turnNullValue:@"username" Object:message];
    senderLable.font=[UIFont systemFontOfSize:12.0f];
    senderLable.text=[NSString stringWithFormat:@"发送人：%@",senderStr];
    senderLable.frame=CGRectMake(7, timeLable.frame.origin.y+24, self.view.frame.size.width-6, 18);
    [suview addSubview:senderLable];
    
    //信息类型
    UILabel *infotypeLable=[[UILabel alloc]init];
    NSString *infotypeStr=[_Commons turnNullValue:@"type" Object:message];
    if ([infotypeStr isEqualToString:@"consult"]) {
        infotypeStr=@"咨询信息";
    }else{
        infotypeStr=@"投诉信息";
    }
    infotypeLable.font=[UIFont systemFontOfSize:12.0f];
    infotypeLable.text=[NSString stringWithFormat:@"信息类型：%@",infotypeStr];
    infotypeLable.frame=CGRectMake(7, senderLable.frame.origin.y+24, self.view.frame.size.width-6, 18);
    [suview addSubview:infotypeLable];
    
    //介绍内容
    UILabel *jieshaoLable=[[UILabel alloc]init];
    jieshaoLable.numberOfLines=0;
    NSString *jieshaoStr=[_Commons turnNullValue:@"descc" Object:message];
    jieshaoLable.font=[UIFont systemFontOfSize:12.0f];
    jieshaoLable.text=[NSString stringWithFormat:@"介绍内容：%@",jieshaoStr];
    CGSize strHeigh=[_Commons NSStringHeightForLabel:jieshaoLable.font width:self.view.frame.size.width-6 Str:jieshaoStr];
    jieshaoLable.frame=CGRectMake(7, infotypeLable.frame.origin.y+24, self.view.frame.size.width-6, strHeigh.height+18);
    [suview addSubview:jieshaoLable];
    
    //信息内容
    UILabel *detailLable=[[UILabel alloc]init];
    detailLable.numberOfLines=0;
    NSString *detailStr=[_Commons turnNullValue:@"descc" Object:message];
    detailLable.font=[UIFont systemFontOfSize:12.0f];
    detailLable.text=[NSString stringWithFormat:@"信息内容：%@",detailStr];
    strHeigh=[_Commons NSStringHeightForLabel:detailLable.font width:self.view.frame.size.width-6 Str:detailStr];
    detailLable.frame=CGRectMake(7, jieshaoLable.frame.origin.y+jieshaoLable.frame.size.height, self.view.frame.size.width-6, strHeigh.height+18);
    [suview addSubview:detailLable];
    
    //审核状态
    UILabel *approverflagLable=[[UILabel alloc]init];
    NSString *approverflagStr=[_Commons turnNullValue:@"approverflag" Object:message];
    if ([approverflagStr isEqualToString:@"0"]) {
        approverflagStr=@"未审核";
    }else{
        approverflagStr=@"已审核通过";
    }
    approverflagLable.font=[UIFont systemFontOfSize:12.0f];
    approverflagLable.text=[NSString stringWithFormat:@"审核状态：%@",approverflagStr];
    approverflagLable.frame=CGRectMake(7, detailLable.frame.origin.y+detailLable.frame.size.height, self.view.frame.size.width-6, 18);
    [suview addSubview:approverflagLable];
    
    if ([approverflagStr isEqualToString:@"已审核通过"]) {
        
        //审核人
        UILabel *appaccountLable=[[UILabel alloc]init];
        NSString *appaccountStr=[_Commons turnNullValue:@"username" Object:message];
        appaccountLable.font=[UIFont systemFontOfSize:12.0f];
        appaccountLable.text=[NSString stringWithFormat:@"审核人：%@",appaccountStr];
        appaccountLable.frame=CGRectMake(7, approverflagLable.frame.origin.y+24, self.view.frame.size.width-6, 18);
        [suview addSubview:appaccountLable];
        
        //处理状态
        UILabel *dealflagLable=[[UILabel alloc]init];
        NSString *dealflagStr=[_Commons turnNullValue:@"dealflag" Object:message];
        if ([dealflagStr isEqualToString:@"0"]) {
            
            dealflagStr=@"未处理";
            
        }else if ([dealflagStr isEqualToString:@"1"]){
            
            dealflagStr=@"处理完成";
            
        }else if ([dealflagStr isEqualToString:@"2"]){
            
            dealflagStr=@"部分处理完成";
            
        }
        else{
            dealflagStr=@"无法处理";
        }
        dealflagLable.font=[UIFont systemFontOfSize:12.0f];
        dealflagLable.text=[NSString stringWithFormat:@"审核状态：%@",dealflagStr];
        dealflagLable.frame=CGRectMake(7, appaccountLable.frame.origin.y+24, self.view.frame.size.width-6, 18);
        [suview addSubview:dealflagLable];
        
        int scroviewheight=0;
        NSString *assessStr=[_Commons turnNullValue:@"assess" Object:message];
        NSString *rcontentsStr=[_Commons turnNullValue:@"rcontents" Object:message];
        if([assessStr isEqualToString:@""] || !assessStr)
        {
            //添加回复内容
            UILabel *rcontentsLable=[[UILabel alloc]init];
            rcontentsLable.font=[UIFont systemFontOfSize:12.0f];
            rcontentsLable.text=@"回复内容";
            rcontentsLable.frame=CGRectMake(7, dealflagLable.frame.origin.y+32, 52, 18);
            [suview addSubview:rcontentsLable];
            
            //回复内容输入
            rcontentsView=[self setTextView:rcontentsView];
            rcontentsView.minNumberOfLines=1;
            rcontentsView.maxNumberOfLines=5;
            rcontentsView.placeholder=@"请输入";
            rcontentsView.text=rcontentsStr;
            strHeigh=[_Commons NSStringHeightForLabel:rcontentsView.font width:self.view.frame.size.width-72 Str:rcontentsStr];
            rcontentsView.frame=CGRectMake(57, dealflagLable.frame.origin.y+24, self.view.frame.size.width-72, strHeigh.height+18);
            [suview addSubview:rcontentsView];
            oldheight=rcontentsView.frame.size.height;
            
            //回复按钮
            NSString *rid=[_Commons turnNullValue:@"rid" Object:message];
            replybtn=[[UIButton alloc]init];
            replybtn.tag=[rid intValue];
            replybtn.titleLabel.font=[UIFont systemFontOfSize:12.0f];
            [replybtn setTitle:@"回复" forState:UIControlStateNormal];
            [replybtn setBackgroundImage:[UIImage imageNamed:@"selectedBtn"] forState:UIControlStateNormal];
            [replybtn addTarget:self action:@selector(replayResident:) forControlEvents:UIControlEventTouchDown];
            replybtn.frame=CGRectMake((self.view.frame.size.width-60)/2, rcontentsView.frame.origin.y+rcontentsView.frame.size.height+18, 60, 30);
            [suview addSubview:replybtn];
            
            scroviewheight=replybtn.frame.origin.y+replybtn.frame.size.height;
        }else{
            
            //满意度
            UILabel *assessLable=[[UILabel alloc]init];
            if ([assessStr isEqualToString:@"1"]) {
                
                assessStr=@"差";
                
            }else if ([assessStr isEqualToString:@"2"]){
                
                assessStr=@"一般";
                
            }else if ([assessStr isEqualToString:@"3"]){
                
                assessStr=@"满意";
                
            }
            else if ([assessStr isEqualToString:@"4"]){
                
                assessStr=@"不满意";
                
            }
            else if ([assessStr isEqualToString:@"5"]){
                
                assessStr=@"非常满意";
                
            }
            else{
                assessStr=@"非常满意";
            }
            assessLable.font=[UIFont systemFontOfSize:12.0f];
            assessLable.text=[NSString stringWithFormat:@"满意度：%@",dealflagStr];
            assessLable.frame=CGRectMake(7, dealflagLable.frame.origin.y+24, self.view.frame.size.width-6, 18);
            [suview addSubview:assessLable];
            
            //详细评价
            UILabel *assessdetailLable=[[UILabel alloc]init];
            assessdetailLable.numberOfLines=0;
            NSString *assessdetailStr=[_Commons turnNullValue:@"assessdetail" Object:message];
            assessdetailLable.font=[UIFont systemFontOfSize:12.0f];
            assessdetailLable.text=[NSString stringWithFormat:@"详细评价：%@",assessdetailStr];
            strHeigh=[_Commons NSStringHeightForLabel:assessdetailLable.font width:self.view.frame.size.width-6 Str:assessdetailStr];
            assessdetailLable.frame=CGRectMake(7, assessLable.frame.origin.y+24, self.view.frame.size.width-6, strHeigh.height+18);
            [suview addSubview:assessdetailLable];
            
            //回复内容
            UILabel *rcontentsLable=[[UILabel alloc]init];
            rcontentsLable.numberOfLines=0;
            rcontentsLable.font=[UIFont systemFontOfSize:12.0f];
            rcontentsLable.text=[NSString stringWithFormat:@"回复内容：%@",rcontentsStr];
            strHeigh=[_Commons NSStringHeightForLabel:assessdetailLable.font width:self.view.frame.size.width-6 Str:rcontentsStr];
            rcontentsLable.frame=CGRectMake(7, assessdetailLable.frame.origin.y+24, self.view.frame.size.width-6, strHeigh.height+18);
            [suview addSubview:rcontentsLable];
            
            scroviewheight=rcontentsLable.frame.size.height+rcontentsLable.frame.origin.y+rcontentsLable.frame.size.height-timeLable.frame.origin.y;
            
        }
        
        suview.frame=CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height-44);
        suview.contentSize=CGSizeMake(self.view.frame.size.width, scroviewheight+4);
        
        //设置圆角边框
        borderImage=[[UIImageView alloc] init];
        borderImage.frame=CGRectMake(4,2,self.view.frame.size.width-8, scroviewheight+2);
        borderImage.layer.cornerRadius = 5;
        borderImage.layer.masksToBounds = YES;
        //设置边框及边框颜色
        borderImage.layer.borderWidth = 0.8;
        borderImage.layer.borderColor =[ [UIColor colorWithRed:200.0/255 green:199.0/255  blue:204.0/255 alpha:1.0f] CGColor];
        [suview addSubview:borderImage];
        
        suview.showsHorizontalScrollIndicator=NO;//不显示水平滑动线
        suview.showsVerticalScrollIndicator=YES;//不显示垂直滑动线
        suview.scrollEnabled=YES;
        [self.view addSubview:suview];
        
        
    }
    
}

//创建textview
-(HPGrowingTextView*)setTextView:(HPGrowingTextView*)textView
{
    textView = [[HPGrowingTextView alloc] init];
    textView.isScrollable = NO;
    textView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
	textView.returnKeyType = UIReturnKeyGo; //just as an example
	textView.delegate = self;
    textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
    textView.backgroundColor = [UIColor whiteColor];
    textView.layer.borderColor=[UIColor colorWithRed:200.0/255 green:199.0/255  blue:204.0/255 alpha:1.0f].CGColor;
    textView.layer.borderWidth=1.0f;
    textView.layer.cornerRadius=3.0f;
    return textView;
}

- (void)growingTextViewDidChange:(HPGrowingTextView *)growingTextView;
{
    if (growingTextView==rcontentsView) {
        int newheight=rcontentsView.frame.size.height;
        if (newheight!=oldheight) {
            
            replybtn.frame=CGRectMake((self.view.frame.size.width-60)/2, replybtn.frame.origin.y+newheight-oldheight, 60, 30);
            suview.frame=CGRectMake(0, 44, self.view.frame.size.width, suview.frame.size.height+newheight-oldheight);
            borderImage.frame=CGRectMake(4,2,self.view.frame.size.width-8, borderImage.frame.size.height+newheight-oldheight);
            oldheight=newheight;
            
            int pointtobottom=self.view.frame.size.height-(rcontentsView.frame.origin.y + rcontentsView.frame.size.height+44);
            if (pointtobottom<216) {
                int offset = 216-pointtobottom;//键盘高度216
                
                NSTimeInterval animationDuration = 0.30f;
                [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
                [UIView setAnimationDuration:animationDuration];
                
                //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
                if(offset > 0)
                    self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
                
                [UIView commitAnimations];
                oldframe=frame;
            }
        }
    }
}

-(void)replayResident:(UIButton *)btn;
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    NSMutableDictionary * pw = [NSMutableDictionary dictionaryWithCapacity:5];
    pw=[DataService PostDataService:[NSString stringWithFormat:@"%@api/upReply",domainser] postDatas:[NSString stringWithFormat:@"mid=%@&rid=%d&contents=%@&createaccount=%@",cid,btn.tag,rcontentsView.text,myDelegate.entityl.account]];
    NSString *rowString =[pw objectForKey:@"info"];
    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alter show];
}

-(IBAction)goback:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [rcontentsView resignFirstResponder];
    oldframe=self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

- (void)growingTextViewDidBeginEditing:(HPGrowingTextView *)growingTextView
{
    frame = growingTextView.frame;
    if (oldframe.origin.y!=frame.origin.y) {
        int pointtobottom=self.view.frame.size.height-(frame.origin.y + frame.size.height+44);
        if (pointtobottom<216) {
            int offset = 216-pointtobottom;//键盘高度216
            
            NSTimeInterval animationDuration = 0.30f;
            [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
            [UIView setAnimationDuration:animationDuration];
            
            //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
            if(offset > 0)
                self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
            
            [UIView commitAnimations];
            oldframe=frame;
        }
    }
}

- (void)growingTextViewDidEndEditing:(HPGrowingTextView *)growingTextView
{
    if (oldframe.origin.y!=frame.origin.y) {
        self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
