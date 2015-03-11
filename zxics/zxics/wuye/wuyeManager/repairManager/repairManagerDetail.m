//
//  repairManagerDetail.m
//  zxics
//
//  Created by johnson on 15-3-11.
//  Copyright (c) 2015年 moko. All rights reserved.
//

#import "repairManagerDetail.h"
#import "DataService.h"
#import "Commons.h"
#import "ImageCacher.h"

@interface repairManagerDetail ()

@end

@implementation repairManagerDetail

@synthesize rdetail;
@synthesize imgSview;
@synthesize suSview;

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
    
    [self loadMyView];
}

-(void)loadMyView
{
    Commons *_Commons=[[Commons alloc]init];
    
    //保修人
    NSString *repersonStr=[_Commons turnNullValue:@"name" Object:rdetail];
    UILabel *repersonLable=[[UILabel alloc]init];
    repersonLable.font=[UIFont systemFontOfSize:12.0f];
    repersonLable.text=[NSString stringWithFormat:@"报修人：%@",repersonStr];
    repersonLable.frame=CGRectMake(5, 6, self.view.frame.size.width-10, 18);
    [suSview addSubview:repersonLable];
    
    //标题
    NSString *titleStr=[_Commons turnNullValue:@"title" Object:rdetail];
    UILabel *titleLable=[[UILabel alloc]init];
    titleLable.numberOfLines=0;
    titleLable.font=[UIFont systemFontOfSize:12.0f];
    CGSize titleheight=[_Commons NSStringHeightForLabel:titleLable.font width:repersonLable.frame.size.width Str:[NSString stringWithFormat:@"标题：%@",titleStr]];
    if(titleheight.height<19)
    {
        titleheight.height=0;
    }
    titleLable.text=[NSString stringWithFormat:@"标题：%@",titleStr];
    titleLable.frame=CGRectMake(5, repersonLable.frame.origin.y+24, self.view.frame.size.width-10, titleheight.height+24);
    [suSview addSubview:titleLable];
    
    //保修内容
    NSString *contentsStr=[_Commons turnNullValue:@"contents" Object:rdetail];
    UILabel *contentsLable=[[UILabel alloc]init];
    contentsLable.numberOfLines=0;
    contentsLable.font=[UIFont systemFontOfSize:12.0f];
    CGSize contentsheight=[_Commons NSStringHeightForLabel:contentsLable.font width:repersonLable.frame.size.width Str:[NSString stringWithFormat:@"报修内容：%@",contentsStr]];
    if(contentsheight.height<19)
    {
        contentsheight.height=0;
    }
    contentsLable.text=[NSString stringWithFormat:@"报修内容：%@",contentsStr];
    contentsLable.frame=CGRectMake(5, titleLable.frame.origin.y+titleLable.frame.size.height+6, self.view.frame.size.width-10, contentsheight.height+24);
    [suSview addSubview:contentsLable];
    
    //期望维修时间
    NSString *add_dateStr=[_Commons turnNullValue:@"add_date" Object:rdetail];
    if (![add_dateStr isEqualToString:@""]) {
        add_dateStr=[_Commons stringtoDateforsecond:add_dateStr];
    }
    UILabel *add_dateLable=[[UILabel alloc]init];
    add_dateLable.font=[UIFont systemFontOfSize:12.0f];
    add_dateLable.text=[NSString stringWithFormat:@"期望维修时间：%@",add_dateStr];
    add_dateLable.frame=CGRectMake(5, contentsLable.frame.origin.y+contentsLable.frame.size.height+6, self.view.frame.size.width-10, 18);
    [suSview addSubview:add_dateLable];
    
    //类型
    NSString *pnameStr=[_Commons turnNullValue:@"parameter_name" Object:rdetail];
    UILabel *pnameLable=[[UILabel alloc]init];
    pnameLable.font=[UIFont systemFontOfSize:12.0f];
    pnameLable.text=[NSString stringWithFormat:@"类型：%@",pnameStr];
    pnameLable.frame=CGRectMake(5, add_dateLable.frame.origin.y+24, self.view.frame.size.width-10, 18);
    [suSview addSubview:pnameLable];
    
    //状态
    NSString *sourceStr=[_Commons turnNullValue:@"source" Object:rdetail];
    NSString *sourceValue=@"";
    if ([sourceStr isEqualToString:@"0"]) {
        sourceValue=@"未处理";
    }else if([sourceStr isEqualToString:@"1"]){
        sourceValue=@"已受理";
    }else if([sourceStr isEqualToString:@"2"]){
        sourceValue=@"已派员";
    }else if([sourceStr isEqualToString:@"3"]){
        sourceValue=@"维修完成";
    }else if([sourceStr isEqualToString:@"4"]){
        sourceValue=@"关闭";
    }else{
        sourceValue=@"未知";
    }
    UILabel *sourceLable=[[UILabel alloc]init];
    sourceLable.font=[UIFont systemFontOfSize:12.0f];
    sourceLable.text=[NSString stringWithFormat:@"类型：%@",sourceValue];
    sourceLable.frame=CGRectMake(5, pnameLable.frame.origin.y+24, self.view.frame.size.width-10, 18);
    [suSview addSubview:sourceLable];
    
    int scrollheight=0;
    
    
    if ([sourceStr isEqualToString:@"0"]) {
        
        //未受理
        UIButton *btn=[[UIButton alloc]init];
        [btn setTitle:@"受理" forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"selectedBtn"] forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:12.0f];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.frame=CGRectMake((self.view.frame.size.width-60)/2, sourceLable.frame.origin.y+24, 60, 30);
        [suSview addSubview:btn];
        
        scrollheight=btn.frame.origin.y+btn.frame.size.height-titleLable.frame.origin.y;
        
    }else if ([sourceStr isEqualToString:@"1"])
    {
        //已受理
        
        //第一行
        firstLable=[[UILabel alloc]init];
        firstLable.font=[UIFont systemFontOfSize:12.0f];
        firstLable.frame=CGRectMake(5, sourceLable.frame.origin.y+30, 60, 18);
        firstLable.text=@"维修时间:";
        
        fristText=[[UITextField alloc]init];
        fristText.font=[UIFont systemFontOfSize:12.0f];
        [fristText setBorderStyle:UITextBorderStyleRoundedRect];
        fristText.frame=CGRectMake(57, sourceLable.frame.origin.y+24, self.view.frame.size.width-62, 30);
        
        //第二行
        secondLable=[[UILabel alloc]init];
        secondLable.font=[UIFont systemFontOfSize:12.0f];
        secondLable.frame=CGRectMake(5, fristText.frame.origin.y+41, 60, 18);
        secondLable.text=@"维修人:";
        
        secondText=[[UITextField alloc]init];
        secondText.font=[UIFont systemFontOfSize:12.0f];
        [secondText setBorderStyle:UITextBorderStyleRoundedRect];
        secondText.frame=CGRectMake(57, fristText.frame.origin.y+35, self.view.frame.size.width-62, 30);
        
        //第三行
        
        thirdText=[[UITextField alloc]init];
        thirdText.font=[UIFont systemFontOfSize:12.0f];
        [thirdText setBorderStyle:UITextBorderStyleRoundedRect];
        thirdText.frame=CGRectMake(57, secondText.frame.origin.y+35, self.view.frame.size.width-62, 30);
        
        thirdLable=[[UILabel alloc]init];
        thirdLable.font=[UIFont systemFontOfSize:12.0f];
        thirdLable.frame=CGRectMake(5, secondText.frame.origin.y+41, 60, 18);
        thirdLable.text=@"联系电话:";
        
        [suSview addSubview:firstLable];
        [suSview addSubview:secondLable];
        [suSview addSubview:thirdLable];
        [suSview addSubview:fristText];
        [suSview addSubview:secondText];
        [suSview addSubview:thirdText];
        
        UIButton *btn=[[UIButton alloc]init];
        [btn setTitle:@"派员" forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"selectedBtn"] forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:12.0f];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.frame=CGRectMake((self.view.frame.size.width-60)/2, thirdLable.frame.origin.y+36, 60, 30);
        scrollheight=btn.frame.origin.y+btn.frame.size.height-titleLable.frame.origin.y;
        [suSview addSubview:btn];
        
        scrollheight=btn.frame.origin.y+btn.frame.size.height-titleLable.frame.origin.y;
    }else if([sourceStr isEqualToString:@"2"] || [sourceStr isEqualToString:@"3"] || [sourceStr isEqualToString:@"4"])
    {
        //已派员 || 已完成 || 关闭
        
        //维修时间
        NSString *repair_DateStr=[_Commons turnNullValue:@"repair_Date" Object:rdetail];
        if (![repair_DateStr isEqualToString:@""]) {
            repair_DateStr=[_Commons stringtoDateforsecond:repair_DateStr];
        }
        UILabel *repair_DateLable=[[UILabel alloc]init];
        repair_DateLable.font=[UIFont systemFontOfSize:12.0f];
        repair_DateLable.text=[NSString stringWithFormat:@"维修时间：%@",repair_DateStr];
        repair_DateLable.frame=CGRectMake(5, sourceLable.frame.origin.y+24, self.view.frame.size.width-10, 18);
        [suSview addSubview:repair_DateLable];
        
        //维修人
        NSString *dousernameStr=[_Commons turnNullValue:@"dousername" Object:rdetail];
        UILabel *dousernameLable=[[UILabel alloc]init];
        dousernameLable.font=[UIFont systemFontOfSize:12.0f];
        dousernameLable.text=[NSString stringWithFormat:@"维修人：%@",dousernameStr];
        dousernameLable.frame=CGRectMake(5, repair_DateLable.frame.origin.y+24, self.view.frame.size.width-10, 18);
        [suSview addSubview:dousernameLable];
        
        
        //联系电话
        NSString *dophoneStr=[_Commons turnNullValue:@"dophone" Object:rdetail];
        UILabel *dophoneLable=[[UILabel alloc]init];
        dophoneLable.font=[UIFont systemFontOfSize:12.0f];
        dophoneLable.text=[NSString stringWithFormat:@"联系电话：%@",dophoneStr];
        dophoneLable.frame=CGRectMake(5, dousernameLable.frame.origin.y+24, self.view.frame.size.width-10, 18);
        [suSview addSubview:dophoneLable];
        
        if([sourceStr isEqualToString:@"2"]){
            //已派员
            
            //第一行
            firstLable=[[UILabel alloc]init];
            firstLable.font=[UIFont systemFontOfSize:12.0f];
            firstLable.frame=CGRectMake(5, dophoneLable.frame.origin.y+30, 60, 18);
            firstLable.text=@"维修记录:";
            
            fristText=[[UITextField alloc]init];
            fristText.font=[UIFont systemFontOfSize:12.0f];
            [fristText setBorderStyle:UITextBorderStyleRoundedRect];
            fristText.frame=CGRectMake(57, dophoneLable.frame.origin.y+24, self.view.frame.size.width-62, 30);
            
            //第二行
            secondLable=[[UILabel alloc]init];
            secondLable.font=[UIFont systemFontOfSize:12.0f];
            secondLable.frame=CGRectMake(5, fristText.frame.origin.y+41, 60, 18);
            secondLable.text=@"维修金额:";
            
            secondText=[[UITextField alloc]init];
            secondText.font=[UIFont systemFontOfSize:12.0f];
            [secondText setBorderStyle:UITextBorderStyleRoundedRect];
            secondText.frame=CGRectMake(57, fristText.frame.origin.y+35, self.view.frame.size.width-62, 30);
            
            //第三行
            
            thirdText=[[UITextField alloc]init];
            thirdText.font=[UIFont systemFontOfSize:12.0f];
            [thirdText setBorderStyle:UITextBorderStyleRoundedRect];
            thirdText.frame=CGRectMake(57, secondText.frame.origin.y+35, self.view.frame.size.width-62, 30);
            
            thirdLable=[[UILabel alloc]init];
            thirdLable.font=[UIFont systemFontOfSize:12.0f];
            thirdLable.frame=CGRectMake(5, secondText.frame.origin.y+41, 60, 18);
            thirdLable.text=@"维修结果:";
            
            //第四行
            
            fourthText=[[UITextField alloc]init];
            fourthText.font=[UIFont systemFontOfSize:12.0f];
            [fourthText setBorderStyle:UITextBorderStyleRoundedRect];
            fourthText.frame=CGRectMake(57, thirdText.frame.origin.y+35, self.view.frame.size.width-62, 30);
            
            fourthLable=[[UILabel alloc]init];
            fourthLable.font=[UIFont systemFontOfSize:12.0f];
            fourthLable.frame=CGRectMake(5, thirdLable.frame.origin.y+41, 60, 18);
            fourthLable.text=@"确认人:";
            
            [suSview addSubview:firstLable];
            [suSview addSubview:secondLable];
            [suSview addSubview:thirdLable];
            [suSview addSubview:fristText];
            [suSview addSubview:secondText];
            [suSview addSubview:thirdText];
            [suSview addSubview:fourthLable];
            [suSview addSubview:fourthText];
            
            UIButton *btn=[[UIButton alloc]init];
            [btn setTitle:@"维修完成" forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"selectedBtn"] forState:UIControlStateNormal];
            btn.titleLabel.font=[UIFont systemFontOfSize:12.0f];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.frame=CGRectMake((self.view.frame.size.width-60)/2, fourthLable.frame.origin.y+36, 60, 30);
            scrollheight=btn.frame.origin.y+btn.frame.size.height-titleLable.frame.origin.y;
            [suSview addSubview:btn];
            
            scrollheight=btn.frame.origin.y+btn.frame.size.height;
        }else{
            
            //已完成
            
            //维修记录
            NSString *repair_detailStr=[_Commons turnNullValue:@"repair_detail" Object:rdetail];
            UILabel *repair_detailLable=[[UILabel alloc]init];
            repair_detailLable.numberOfLines=0;
            repair_detailLable.font=[UIFont systemFontOfSize:12.0f];
            CGSize repair_detailh=[_Commons NSStringHeightForLabel:titleLable.font width:repersonLable.frame.size.width Str:[NSString stringWithFormat:@"维修记录：%@",repair_detailStr]];
            if(repair_detailh.height<19)
            {
                repair_detailh.height=0;
            }
            repair_detailLable.text=[NSString stringWithFormat:@"维修记录：%@",repair_detailStr];
            repair_detailLable.frame=CGRectMake(5, dophoneLable.frame.origin.y+24, self.view.frame.size.width-10, repair_detailh.height+24);
            [suSview addSubview:repair_detailLable];
            
            //维修金额
            NSString *depositStr=[_Commons turnNullValue:@"deposit" Object:rdetail];
            UILabel *depositLable=[[UILabel alloc]init];
            depositLable.font=[UIFont systemFontOfSize:12.0f];
            depositLable.text=[NSString stringWithFormat:@"维修金额：%@",depositStr];
            depositLable.frame=CGRectMake(5, repair_detailLable.frame.origin.y+repair_detailLable.frame.size.height+6, self.view.frame.size.width-10, 18);
            [suSview addSubview:depositLable];
            
            //维修结果
            NSString *resultStr=[_Commons turnNullValue:@"results" Object:rdetail];
            UILabel *resultLable=[[UILabel alloc]init];
            resultLable.numberOfLines=0;
            resultLable.font=[UIFont systemFontOfSize:12.0f];
            CGSize resulth=[_Commons NSStringHeightForLabel:titleLable.font width:repersonLable.frame.size.width Str:[NSString stringWithFormat:@"维修结果：%@",resultStr]];
            if(resulth.height<19)
            {
                resulth.height=0;
            }
            resultLable.text=[NSString stringWithFormat:@"维修结果：%@",resultStr];
            resultLable.frame=CGRectMake(5, depositLable.frame.origin.y+24, self.view.frame.size.width-10, resulth.height+24);
            [suSview addSubview:resultLable];
            
            //确认人
            NSString *comfirmStr=[_Commons turnNullValue:@"confirm" Object:rdetail];
            UILabel *comfirmLable=[[UILabel alloc]init];
            comfirmLable.font=[UIFont systemFontOfSize:12.0f];
            comfirmLable.text=[NSString stringWithFormat:@"确认人：%@",comfirmStr];
            comfirmLable.frame=CGRectMake(5, resultLable.frame.origin.y+resultLable.frame.size.height+6, self.view.frame.size.width-10, 18);
            [suSview addSubview:comfirmLable];
            
            scrollheight=comfirmLable.frame.origin.y+comfirmLable.frame.size.height;
            
            if ([sourceStr isEqualToString:@"4"]) {
                
                //居民满意度
                NSString *mydStr=[_Commons turnNullValue:@"myd" Object:rdetail];
                UILabel *mydLable=[[UILabel alloc]init];
                mydLable.font=[UIFont systemFontOfSize:12.0f];
                mydLable.text=[NSString stringWithFormat:@"居民满意度：%@",mydStr];
                mydLable.frame=CGRectMake(5, comfirmLable.frame.origin.y+24, self.view.frame.size.width-10, 18);
                [suSview addSubview:mydLable];
                
                scrollheight=mydLable.frame.origin.y+mydLable.frame.size.height;
            }
        }
    }

    suSview.contentSize=CGSizeMake(self.view.frame.size.width, scrollheight+10);
    
    suSview.showsHorizontalScrollIndicator=NO;//不显示水平滑动线
    suSview.showsVerticalScrollIndicator=YES;//不显示垂直滑动线
    suSview.scrollEnabled=YES;
    
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
