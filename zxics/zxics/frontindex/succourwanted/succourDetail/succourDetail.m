//
//  succourDetail.m
//  zxics
//
//  Created by johnson on 14-9-5.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "succourDetail.h"
#import "Commons.h"

@interface succourDetail ()

@end

@implementation succourDetail

@synthesize suSView;
@synthesize sud;

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
    [self loaddate];
}

-(void)loaddate
{
    
    //标题
    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 280, 30)];
    title.font=[UIFont systemFontOfSize:12.0f];
    title.text=[NSString stringWithFormat:@"标题：%@",[sud objectForKey:@"title"]];
    [suSView addSubview:title];
    
    CGFloat y=title.frame.origin.y;
    CGFloat height=title.frame.size.height;
    
    //申请内容
    UILabel *applydetail=[[UILabel alloc] init];
    applydetail.font=[UIFont systemFontOfSize:12.0f];
    applydetail.numberOfLines=0;
    id detail=[sud objectForKey:@"contents"] ;
    if (detail==[NSNull null]) {
        applydetail.text=@"申请内容：";
        applydetail.frame=CGRectMake(10, title.frame.origin.y+30, 280, 30);
    }else{
        applydetail.text=[NSString stringWithFormat:@"申请内容：%@",[sud objectForKey:@"contents"]];
        CGSize size =CGSizeMake(275,0);
        UIFont * tfont = applydetail.font;
        NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
        
        CGSize  actualsize =[[sud objectForKey:@"contents"] boundingRectWithSize:size options:
                             NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
        
        applydetail.frame=CGRectMake(10, title.frame.origin.y+30, 280, actualsize.height+24);
    }
    [suSView addSubview:applydetail];
    
    //手机号码
    UILabel *phoneno=[[UILabel alloc]initWithFrame:CGRectMake(10, applydetail.frame.origin.y+applydetail.frame.size.height, 280, 30)];
    phoneno.font=[UIFont systemFontOfSize:12.0f];
    phoneno.text=[NSString stringWithFormat:@"手机号码：%@",[sud objectForKey:@"phone"]];
    [suSView addSubview:phoneno];
    
    //电子邮箱
    UILabel *email=[[UILabel alloc]initWithFrame:CGRectMake(10, phoneno.frame.origin.y+30, 280, 30)];
    email.font=[UIFont systemFontOfSize:12.0f];
    email.text=[NSString stringWithFormat:@"邮箱：%@",[sud objectForKey:@"email"]];
    [suSView addSubview:email];
    
    //详细地址
    UILabel *addr=[[UILabel alloc]initWithFrame:CGRectMake(10, email.frame.origin.y+30, 280, 30)];
    addr.font=[UIFont systemFontOfSize:12.0f];
    addr.text=[NSString stringWithFormat:@"详细地址：%@",[sud objectForKey:@"address"]];
    [suSView addSubview:addr];
    
    //申请类型
    UILabel *applytype=[[UILabel alloc]initWithFrame:CGRectMake(10, addr.frame.origin.y+30, 280, 30)];
    applytype.font=[UIFont systemFontOfSize:12.0f];
    applytype.text=[NSString stringWithFormat:@"申请类型：%@",[sud objectForKey:@"typeName"]];
    [suSView addSubview:applytype];
    
    //申请时间
    UILabel *dateLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, applytype.frame.origin.y+30, 280, 30)];
    dateLabel.font=[UIFont systemFontOfSize:12.0f];
    Commons *_Commons=[[Commons alloc]init];
    NSString *timestr=[sud objectForKey:@"createtime"];
    dateLabel.text=[NSString stringWithFormat:@"申请时间：%@",[_Commons stringtoDateforsecond:timestr]];
    [suSView addSubview:dateLabel];
    
    //受理状态
    UILabel *appstate=[[UILabel alloc]initWithFrame:CGRectMake(10, dateLabel.frame.origin.y+30, 280, 30)];
    appstate.font=[UIFont systemFontOfSize:12.0f];
    NSString *dealflag=[NSString stringWithFormat:@"%@",[sud objectForKey:@"dealflag"]];
    NSString *approverflag=[NSString stringWithFormat:@"%@",[sud objectForKey:@"approverflag"]];
    id rank=[sud objectForKey:@"rank"];
    if ([dealflag isEqualToString:@"0"] && ![approverflag isEqualToString:@"1"]) {
        if ([approverflag isEqualToString:@"0"]) {
            appstate.text=@"受理状态：未受理";
        }else
        {
            appstate.text=@"受理状态：受理不通过";
        }
        [suSView addSubview:appstate];
        
        y=appstate.frame.origin.y;
        height=appstate.frame.size.height;
    }else if ([dealflag isEqualToString:@"0"] && [approverflag isEqualToString:@"1"])
    {
        appstate.text=@"受理状态：受理通过";
        [suSView addSubview:appstate];
        
        //受理时间
        UILabel *appdateLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, appstate.frame.origin.y+30, 280, 30)];
        appdateLabel.font=[UIFont systemFontOfSize:12.0f];
        timestr=[sud objectForKey:@"apptime"];
        appdateLabel.text=[NSString stringWithFormat:@"受理时间：%@",[_Commons stringtoDateforsecond:timestr]];
        [suSView addSubview:appdateLabel];
        
        //处理状态
        UILabel *dealstate=[[UILabel alloc]initWithFrame:CGRectMake(10, appdateLabel.frame.origin.y+30, 280, 30)];
        dealstate.font=[UIFont systemFontOfSize:12.0f];
        dealstate.text=@"处理状态：未处理";
        [suSView addSubview:dealstate];
        
        y=dealstate.frame.origin.y;
        height=dealstate.frame.size.height;
    }else if (![dealflag isEqualToString:@"0"] && [approverflag isEqualToString:@"1"])
    {
        appstate.text=@"受理状态：受理通过";
        [suSView addSubview:appstate];
        
        //受理时间
        UILabel *appdateLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, appstate.frame.origin.y+30, 280, 30)];
        appdateLabel.font=[UIFont systemFontOfSize:12.0f];
        timestr=[sud objectForKey:@"apptime"];
        appdateLabel.text=[NSString stringWithFormat:@"受理时间：%@",[_Commons stringtoDateforsecond:timestr]];
        [suSView addSubview:appdateLabel];
        
        //处理状态
        UILabel *dealstate=[[UILabel alloc]initWithFrame:CGRectMake(10, appdateLabel.frame.origin.y+30, 280, 30)];
        dealstate.font=[UIFont systemFontOfSize:12.0f];
        if ([dealflag isEqualToString:@"1"]) {
            dealstate.text=@"处理状态：处理完成";
        }else if ([dealflag isEqualToString:@"2"])
        {
            dealstate.text=@"处理状态：部分处理完成";
        }else if ([dealflag isEqualToString:@"3"])
        {
            dealstate.text=@"处理状态：无法处理处理";
        }
        [suSView addSubview:dealstate];
        
        y=dealstate.frame.origin.y;
        height=dealstate.frame.size.height;
        id replytime=[sud objectForKey:@"replytime"];
        if (replytime!=[NSNull null]) {
            
            //回复内容
            UILabel *rcontents=[[UILabel alloc]init];
            rcontents.numberOfLines=0;
            rcontents.font=[UIFont systemFontOfSize:12.0f];
            rcontents.text=[NSString stringWithFormat:@"回复内容：%@",[sud objectForKey:@"rcontents"]];
            CGSize size =CGSizeMake(275,0);
            UIFont * tfont = rcontents.font;
            NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
            
            CGSize  actualsize =[[sud objectForKey:@"rcontents"] boundingRectWithSize:size options:
                                 NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
            
            rcontents.frame=CGRectMake(10, dealstate.frame.origin.y+30, 280, actualsize.height+24);
            [suSView addSubview:rcontents];
            
            //回复时间
            UILabel *replytime=[[UILabel alloc]initWithFrame:CGRectMake(10, rcontents.frame.origin.y+rcontents.frame.size.height, 280, 30)];
            replytime.font=[UIFont systemFontOfSize:12.0f];
            timestr=[sud objectForKey:@"replytime"];
            replytime.text=[NSString stringWithFormat:@"回复时间：%@",[_Commons stringtoDateforsecond:timestr]];
            [suSView addSubview:replytime];
            
            y=replytime.frame.origin.y;
            height=replytime.frame.size.height;
            if (rank!=[NSNull null] && ![[NSString stringWithFormat:@"%@",rank] isEqualToString:@"0"])
            {
                //满意度
                UILabel *rankLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, replytime.frame.origin.y+30, 280, 30)];
                rankLabel.font=[UIFont systemFontOfSize:12.0f];
                if ([[NSString stringWithFormat:@"%@",rank] isEqualToString:@"4"]) {
                    rankLabel.text=@"满意度：差";
                }else if ([[NSString stringWithFormat:@"%@",rank] isEqualToString:@"3"])
                {
                    rankLabel.text=@"满意度：不满意";
                }else if ([[NSString stringWithFormat:@"%@",rank] isEqualToString:@"2"])
                {
                    rankLabel.text=@"满意度：一般";
                }else if ([[NSString stringWithFormat:@"%@",rank] isEqualToString:@"1"])
                {
                    rankLabel.text=@"满意度：满意";
                }else if ([[NSString stringWithFormat:@"%@",rank] isEqualToString:@"5"])
                {
                    rankLabel.text=@"满意度：非常满意";
                }
                [suSView addSubview:rankLabel];
                
                
                id comments=[sud objectForKey:@"comments"];
                UILabel *commentsLabel=[[UILabel alloc]init];
                commentsLabel.font=[UIFont systemFontOfSize:12.0f];
                
                if (comments!=[NSNull null]) {
                    commentsLabel.numberOfLines=0;
                    commentsLabel.text=[NSString stringWithFormat:@"详细评价：%@",comments];
                    CGSize size =CGSizeMake(275,0);
                    UIFont * tfont = commentsLabel.font;
                    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
                    
                    CGSize  actualsize =[[sud objectForKey:@"comments"] boundingRectWithSize:size options:
                                         NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
                    
                    commentsLabel.frame=CGRectMake(10, rankLabel.frame.origin.y+30, 280, actualsize.height+24);
                    [suSView addSubview:rcontents];
                }else{
                    commentsLabel.text=@"详细评价：无";
                    commentsLabel.frame=CGRectMake(10, rankLabel.frame.origin.y+30, 280, 30);
                    [suSView addSubview:rcontents];
                }
                [suSView addSubview:commentsLabel];
                y=commentsLabel.frame.origin.y;
                height=commentsLabel.frame.size.height;
            }
        }
    }
    suSView.contentSize=CGSizeMake(self.view.frame.size.width, y-title.frame.origin.y+height+20);
    
    //设置圆角边框
    UIImageView *borderImage=[[UIImageView alloc] init];
    borderImage.frame=CGRectMake(4,title.frame.origin.y+2,self.view.frame.size.width-8, y-title.frame.origin.y+height+20);
    borderImage.layer.cornerRadius = 5;
    borderImage.layer.masksToBounds = YES;
    //设置边框及边框颜色
    borderImage.layer.borderWidth = 0.8;
    borderImage.layer.borderColor =[ [UIColor colorWithRed:200.0/255 green:199.0/255  blue:204.0/255 alpha:1.0f] CGColor];
    [suSView addSubview:borderImage];
    
    suSView.showsHorizontalScrollIndicator=NO;//不显示水平滑动线
    suSView.showsVerticalScrollIndicator=YES;//不显示垂直滑动线
    suSView.scrollEnabled=YES;
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
