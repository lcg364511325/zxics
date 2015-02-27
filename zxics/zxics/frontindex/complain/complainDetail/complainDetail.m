//
//  complainDetail.m
//  zxics
//
//  Created by johnson on 14-8-5.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "complainDetail.h"
#import "Commons.h"
#import "assess.h"

@interface complainDetail ()

@end

@implementation complainDetail

@synthesize complainaboutLabel;
@synthesize titleLabel;
@synthesize introduceLabel;
@synthesize detailsLabel;
@synthesize complainDateLabel;
@synthesize complainstateLabel;
@synthesize dealdateLabel;
@synthesize dealstateLabel;
@synthesize complaininfo;
@synthesize comscrollview;
@synthesize replycontentLabel;
@synthesize replydataLabel;
@synthesize assessLabel;
@synthesize assessdetailLabel;

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
    //加载数据
    [self loaddata];
}


//加载数据
-(void)loaddata
{
    //投诉对象
    NSString * subtype=[NSString stringWithFormat:@"%@",[complaininfo objectForKey:@"subtype"]];
    if ([subtype isEqualToString:@"0"]) {
        complainaboutLabel.text=@"网站服务";
    }else if ([subtype isEqualToString:@"1"])
    {
        complainaboutLabel.text=@"商铺服务";
    }else if ([subtype isEqualToString:@"2"])
    {
        complainaboutLabel.text=@"物业";
    }
    
    
    titleLabel.text=[complaininfo objectForKey:@"title"];
    
    //介绍
    introduceLabel.text=[NSString stringWithFormat:@"介绍：%@",[complaininfo objectForKey:@"descc"]];
    
    introduceLabel.numberOfLines=0;
    CGSize size =CGSizeMake(introduceLabel.frame.size.width,0);
    UIFont * tfont = introduceLabel.font;
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
    
    CGSize  actualsize =[[complaininfo objectForKey:@"descc"] boundingRectWithSize:size options:
                         NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;

    introduceLabel.frame=CGRectMake(introduceLabel.frame.origin.x, introduceLabel.frame.origin.y, introduceLabel.frame.size.width, actualsize.height+24);
    
    //投诉内容
     detailsLabel.text=[NSString stringWithFormat:@"投诉内容：%@",[complaininfo objectForKey:@"contents"]];
    detailsLabel.numberOfLines=0;
    actualsize =[[complaininfo objectForKey:@"contents"] boundingRectWithSize:size options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
    detailsLabel.frame=CGRectMake(detailsLabel.frame.origin.x, introduceLabel.frame.origin.y+introduceLabel.frame.size.height, detailsLabel.frame.size.width, actualsize.height+24);
    
    //投诉时间
    Commons *_Commons=[[Commons alloc]init];
    complainDateLabel.frame=CGRectMake(complainDateLabel.frame.origin.x, detailsLabel.frame.origin.y+actualsize.height+24, complainDateLabel.frame.size.width, complainDateLabel.frame.size.height);
    complainDateLabel.text=[NSString stringWithFormat:@"投诉时间：%@",[_Commons stringtoDateforsecond:[complaininfo objectForKey:@"send_date"]]];
    
    NSInteger resultvalue=[[complaininfo objectForKey:@"dealflag"] integerValue];
    NSInteger app=[[complaininfo objectForKey:@"approverflag"] integerValue];
    NSString *assess=[NSString stringWithFormat:@"%@",[complaininfo objectForKey:@"assess"]];
    NSString *rid=[NSString stringWithFormat:@"%@",[complaininfo objectForKey:@"rid"]];
    
    //判断受理状态
    complainstateLabel.frame=CGRectMake(complainstateLabel.frame.origin.x, complainDateLabel.frame.origin.y+30, complainstateLabel.frame.size.width, complainstateLabel.frame.size.height);
    if (resultvalue==0 && app!=1) {
        if (app==0) {
            complainstateLabel.text=@"受理状态：未受理";
        }else
        {
            complainstateLabel.text=@"受理状态：受理不通过";
        }
    }else if (resultvalue!=0 && app==1)
    {
        complainstateLabel.text=@"受理状态：受理通过";
        
        //受理通过后的处理状态判断
        dealdateLabel.frame=CGRectMake(dealdateLabel.frame.origin.x, complainstateLabel.frame.origin.y+30, dealdateLabel.frame.size.width, dealdateLabel.frame.size.height);
        dealstateLabel.frame=CGRectMake(dealstateLabel.frame.origin.x, dealdateLabel.frame.origin.y+30, dealstateLabel.frame.size.width, dealstateLabel.frame.size.height);
        dealdateLabel.text=[NSString stringWithFormat:@"受理时间：%@",[_Commons stringtoDateforsecond:[complaininfo objectForKey:@"apptime"]]];
        if (resultvalue==1) {
            dealstateLabel.text=@"处理状态：处理完成";
        }else if (resultvalue==2)
        {
            dealstateLabel.text=@"处理状态：部分处理完成";
        }else if (resultvalue==3)
        {
            dealstateLabel.text=@"处理状态：无法处理";
        }
        assessbutton.frame=CGRectMake(120, dealstateLabel.frame.origin.y+30, 50, 21);
        //是否已回复
        if (rid!=nil && ![rid isEqualToString:@"<null>"]) {
            
            CGSize size1 =CGSizeMake(245,0);
            UILabel *replycontentview=[[UILabel alloc]init];
            replycontentview.font=[UIFont systemFontOfSize:10.0f];
            replycontentview.numberOfLines=0;
            NSString *recontentsStr=[self flattenHTML:[NSString stringWithFormat:@"%@",[complaininfo objectForKey:@"reply_contents"]]];
            replycontentview.text=[NSString stringWithFormat:@"回复内容：%@",recontentsStr];
            actualsize =[recontentsStr boundingRectWithSize:size1 options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
            replycontentview.frame=CGRectMake(detailsLabel.frame.origin.x, dealstateLabel.frame.origin.y+30, detailsLabel.frame.size.width, actualsize.height+24);
            [comscrollview addSubview:replycontentview];
            
            replydataLabel.frame=CGRectMake(dealstateLabel.frame.origin.x, replycontentview.frame.origin.y+actualsize.height+24, replydataLabel.frame.size.width, replydataLabel.frame.size.height);
            replydataLabel.text=[NSString stringWithFormat:@"回复时间：%@",[_Commons stringtoDateforsecond:[complaininfo objectForKey:@"reply_createtime"]]];
            
            //是否已评价
            if (![assess isEqualToString:@"0"] && ![assess isEqualToString:@"<null>"] ) {
                assessLabel.frame=CGRectMake(assessLabel.frame.origin.x, replydataLabel.frame.origin.y+30, assessLabel.frame.size.width, assessLabel.frame.size.height);
                if ([assess isEqualToString:@"4"]) {
                    assessLabel.text=@"满意度：差";
                }else if ([assess isEqualToString:@"3"])
                {
                    assessLabel.text=@"满意度：不满意";
                }else if ([assess isEqualToString:@"2"])
                {
                    assessLabel.text=@"满意度：一般";
                }else if ([assess isEqualToString:@"1"])
                {
                    assessLabel.text=@"满意度：满意";
                }else if ([assess isEqualToString:@"5"])
                {
                    assessLabel.text=@"满意度：非常满意";
                }
                
                assessdetailLabel.numberOfLines=0;
                actualsize =[[complaininfo objectForKey:@"assessdetail"] boundingRectWithSize:size options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
                assessdetailLabel.frame=CGRectMake(assessdetailLabel.frame.origin.x, assessLabel.frame.origin.y+30, assessdetailLabel.frame.size.width, actualsize.height+24);
                assessdetailLabel.text=[NSString stringWithFormat:@"详细评价：%@",[complaininfo objectForKey:@"assessdetail"]];
            }else{
                assessbutton=[[UIButton alloc]init];
                [assessbutton setTitle:@"评价" forState:UIControlStateNormal];
                [assessbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                assessbutton.titleLabel.font=[UIFont systemFontOfSize:12.0f];
                [assessbutton setBackgroundImage:[UIImage imageNamed:@"login"] forState:UIControlStateNormal];
                [assessbutton addTarget:self action:@selector(assess) forControlEvents:UIControlEventTouchDown];
                assessbutton.frame=CGRectMake(120, replydataLabel.frame.origin.y+30, 50, 21);
            }
            
        }
        
    }
    [comscrollview addSubview:assessbutton];
    
    int nowHeight=0;
    if (rid!=nil && ![rid isEqualToString:@"<null>"])
    {
        if (![assess isEqualToString:@"0"] && ![assess isEqualToString:@"<null>"] )
        {
            nowHeight=assessdetailLabel.frame.origin.y-complainaboutLabel.frame.origin.y+assessdetailLabel.frame.size.height;
        }else{
            nowHeight=replydataLabel.frame.origin.y-complainaboutLabel.frame.origin.y+replydataLabel.frame.size.height;
        }
    }else{
        nowHeight=complainstateLabel.frame.origin.y-complainaboutLabel.frame.origin.y+complainstateLabel.frame.size.height+20;
    }
    comscrollview.contentSize=CGSizeMake(self.view.frame.size.width, nowHeight);
    
    //设置圆角边框
    UIImageView *borderImage=[[UIImageView alloc] init];
    borderImage.frame=CGRectMake(4,complainaboutLabel.frame.origin.y-10,self.view.frame.size.width-8, nowHeight+20);
    borderImage.layer.cornerRadius = 5;
    borderImage.layer.masksToBounds = YES;
    //设置边框及边框颜色
    borderImage.layer.borderWidth = 0.8;
    borderImage.layer.borderColor =[ [UIColor colorWithRed:200.0/255 green:199.0/255  blue:204.0/255 alpha:1.0f] CGColor];
    [comscrollview addSubview:borderImage];
    
    comscrollview.showsHorizontalScrollIndicator=NO;//不显示水平滑动线
    comscrollview.showsVerticalScrollIndicator=YES;//不显示垂直滑动线
    comscrollview.scrollEnabled=YES;
    
}

-(IBAction)goback:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)assess
{
    assess *_assess=[[assess alloc]init];
    _assess.mid=[NSString stringWithFormat:@"%@",[complaininfo objectForKey:@"id"]];
    [self.navigationController pushViewController:_assess animated:NO];
}

- (NSString *)flattenHTML:(NSString *)html {
    
    NSScanner *theScanner;
    NSString *text = nil;
    
    theScanner = [NSScanner scannerWithString:html];
    
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [NSString stringWithFormat:@"%@>", text]
                                               withString:@""];
    } // while //
    
    NSLog(@"-----===%@",html);
    return html;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
