//
//  mallindex.m
//  zxics
//
//  Created by johnson on 14-9-22.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "mallindex.h"
#import "DataService.h"

@interface mallindex ()

@end

@implementation mallindex

@synthesize onebutton;
@synthesize oneLabel;
@synthesize twoButton;
@synthesize twoLabel;
@synthesize threeButton;
@synthesize threeLabel;
@synthesize fourButton;
@synthesize fourLabel;

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
    

    [self classlistdata];
}

-(void)classlistdata
{
    NSMutableDictionary * class = [NSMutableDictionary dictionaryWithCapacity:5];
    class=[DataService PostDataService:[NSString stringWithFormat:@"%@api/getGoodsClassify",domainser] postDatas:[NSString stringWithFormat:@"pid=%@",@"0"]];
    NSArray *classlist=[class objectForKey:@"datas"];
    
    NSInteger count=[classlist count];
    NSInteger line=0;
    NSInteger row=1;
    for (int i=0; i<count; i++) {
        NSDictionary *dict=[classlist objectAtIndex:i];
        UIButton *btn;
        UILabel *label;
        if ((row=i%4)==0) {
            line=i/4;
        }
        if (row==0) {
            btn=[[UIButton alloc]initWithFrame:CGRectMake(20, 231+50*line, 50, 50)];
            label=[[UILabel alloc]initWithFrame:CGRectMake(30, 283+50*line, 50, 10)];
        }else if (row==1){
            btn=[[UIButton alloc]initWithFrame:CGRectMake(97, 231+50*line, 50, 50)];
            label=[[UILabel alloc]initWithFrame:CGRectMake(107, 283+50*line, 50, 10)];
        }else if (row==2)
        {
            btn=[[UIButton alloc]initWithFrame:CGRectMake(177, 231+50*line, 50, 50)];
            label=[[UILabel alloc]initWithFrame:CGRectMake(177, 283+50*line, 50, 10)];
        }else if (row==3)
        {
            btn=[[UIButton alloc]initWithFrame:CGRectMake(250, 231+50*line, 50, 50)];
            label=[[UILabel alloc]initWithFrame:CGRectMake(260, 283+50*line, 50, 10)];
        }
        label.font=[UIFont systemFontOfSize:12.0f];
        label.text=[dict objectForKey:@"name"];
        label.textAlignment=NSTextAlignmentCenter;
        
        [self.view addSubview:btn];
        [self.view addSubview:label];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
