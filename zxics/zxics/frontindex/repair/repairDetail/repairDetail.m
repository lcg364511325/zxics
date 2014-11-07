//
//  repairDetail.m
//  zxics
//
//  Created by johnson on 14-8-18.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "repairDetail.h"
#import "Commons.h"
#import "DataService.h"

@interface repairDetail ()

@end

@implementation repairDetail

@synthesize titleLabel;
@synthesize typeLabel;
@synthesize dateLabel;
@synthesize contentLabel;
@synthesize stateLabel;
@synthesize re;
@synthesize reSView;
@synthesize resultname;

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
    [self loaddata];
}

-(void)loaddata
{
    titleLabel.text=[re objectForKey:@"title"];
    
    //查询报修类型
    NSMutableDictionary * type = [NSMutableDictionary dictionaryWithCapacity:1];
    type=[DataService PostDataService:[NSString stringWithFormat:@"%@api/findParameter",domainser] postDatas:@"type=repairsParame"];
    NSArray *typelist=[type objectForKey:@"datas"];
    
    NSString *repairtype=[NSString stringWithFormat:@"%@",[re objectForKey:@"type"]];
    for (NSDictionary *object in typelist) {
        NSString *objectvalue=[NSString stringWithFormat:@"%@",[object objectForKey:@"value"]];
        if ([objectvalue isEqualToString:repairtype]) {
            typeLabel.text=[NSString stringWithFormat:@"报修类型：%@",[object objectForKey:@"name"]];
        }
    }
    
    
    Commons *_Commons=[[Commons alloc]init];
    dateLabel.text=[NSString stringWithFormat:@"期望维修时间：%@",[_Commons stringtoDate:[re objectForKey:@"addDate"]]];
    
    contentLabel.numberOfLines=0;
    CGSize size =CGSizeMake(contentLabel.frame.size.width,0);
    UIFont * tfont = contentLabel.font;
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
    
    CGSize  actualsize =[[re objectForKey:@"contents"] boundingRectWithSize:size options:
                         NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
    contentLabel.text=[NSString stringWithFormat:@"保修内容：%@",[re objectForKey:@"contents"]];
    contentLabel.frame=CGRectMake(contentLabel.frame.origin.x, contentLabel.frame.origin.y, contentLabel.frame.size.width, actualsize.height+24);
    
    
    NSInteger repairsource=[[NSString stringWithFormat:@"%@",[re objectForKey:@"source"]] integerValue];
    NSString *status;
    if(repairsource==0)
    {
        status=@"未处理";
    }else if(repairsource==1)
    {
        status=@"已受理";
    }else if(repairsource==2)
    {
        status=@"已派员";
    }else if(repairsource==3)
    {
        status=@"维修完成";
    }else if(repairsource==4)
    {
        status=@"关闭";
    }
    stateLabel.text=[NSString stringWithFormat:@"保修状态：%@",status];
    stateLabel.frame=CGRectMake(stateLabel.frame.origin.x, contentLabel.frame.origin.y+contentLabel.frame.size.height, stateLabel.frame.size.width, stateLabel.frame.size.height);
    
    if (repairsource>1) {
        //维修人员
        UILabel * dousernameLabel=[[UILabel alloc]initWithFrame:CGRectMake(dateLabel.frame.origin.x, stateLabel.frame.origin.y+30, dateLabel.frame.size.width, dateLabel.frame.size.height)];
        dousernameLabel.font=[UIFont systemFontOfSize:12.0f];
        dousernameLabel.text=[NSString stringWithFormat:@"维修人员：%@",[re objectForKey:@"dousername"]];
        
        [reSView addSubview:dousernameLabel];
        
        //维修人员联系方式
        UILabel * dophoneLabel=[[UILabel alloc]initWithFrame:CGRectMake(dateLabel.frame.origin.x, dousernameLabel.frame.origin.y+30, dateLabel.frame.size.width, dateLabel.frame.size.height)];
        dophoneLabel.font=[UIFont systemFontOfSize:12.0f];
        dophoneLabel.text=[NSString stringWithFormat:@"联系方式：%@",[re objectForKey:@"dophone"]];
        
        [reSView addSubview:dophoneLabel];
        
        if (repairsource>3) {
            //维修结果说明
            UILabel * resultsLabel=[[UILabel alloc]init];
            resultsLabel.font=[UIFont systemFontOfSize:12.0f];
            actualsize =[[re objectForKey:@"contents"] boundingRectWithSize:size options:
                         NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
            resultsLabel.frame=CGRectMake(dateLabel.frame.origin.x, dophoneLabel.frame.origin.y+30, dateLabel.frame.size.width, actualsize.height+24);
            resultsLabel.text=[NSString stringWithFormat:@"维修结果：%@",[re objectForKey:@"results"]];
            [reSView addSubview:resultsLabel];
            
            if (repairsource==4) {
                
                
                //评价
                UILabel * assessLabel=[[UILabel alloc]initWithFrame:CGRectMake(dateLabel.frame.origin.x, resultsLabel.frame.origin.y+resultsLabel.frame.size.height, dateLabel.frame.size.width, dateLabel.frame.size.height)];
                assessLabel.font=[UIFont systemFontOfSize:12.0f];
                assessLabel.text=[NSString stringWithFormat:@"用户评价：%@",resultname];
                
                [reSView addSubview:assessLabel];
            }
        }
        
        
    }
    
    
    reSView.contentSize=CGSizeMake(320, stateLabel.frame.origin.y-titleLabel.frame.origin.y+stateLabel.frame.size.height+10);
    reSView.showsHorizontalScrollIndicator=NO;//不显示水平滑动线
    reSView.showsVerticalScrollIndicator=YES;//不显示垂直滑动线
    reSView.scrollEnabled=YES;
    
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
