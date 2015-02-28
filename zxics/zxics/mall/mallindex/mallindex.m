//
//  mallindex.m
//  zxics
//
//  Created by johnson on 14-9-22.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "mallindex.h"
#import "DataService.h"
#import "goodslist.h"

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
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作（异步操作）
        
        NSMutableDictionary * class = [NSMutableDictionary dictionaryWithCapacity:5];
        class=[DataService PostDataService:[NSString stringWithFormat:@"%@api/getGoodsClassify",domainser] postDatas:[NSString stringWithFormat:@"pid=%@",@"0"]];
        NSArray *classlist=[class objectForKey:@"datas"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
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
                    btn=[[UIButton alloc]initWithFrame:CGRectMake(20, 191+70*line, 50, 50)];
                    label=[[UILabel alloc]initWithFrame:CGRectMake(20, 243+70*line, 50, 10)];
                }else if (row==1){
                    btn=[[UIButton alloc]initWithFrame:CGRectMake(97, 191+70*line, 50, 50)];
                    label=[[UILabel alloc]initWithFrame:CGRectMake(97, 243+70*line, 50, 10)];
                }else if (row==2)
                {
                    btn=[[UIButton alloc]initWithFrame:CGRectMake(177, 191+70*line, 50, 50)];
                    label=[[UILabel alloc]initWithFrame:CGRectMake(177, 243+70*line, 50, 10)];
                }else if (row==3)
                {
                    btn=[[UIButton alloc]initWithFrame:CGRectMake(250, 191+70*line, 50, 50)];
                    label=[[UILabel alloc]initWithFrame:CGRectMake(250, 243+70*line, 50, 10)];
                }
                label.font=[UIFont systemFontOfSize:10.0f];
                label.text=[dict objectForKey:@"name"];
                label.textAlignment=NSTextAlignmentCenter;
                
                NSString *logo=[NSString stringWithFormat:@"%@",[dict objectForKey:@"logo"]];
                NSString *gid=[NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]];
                NSURL *imgUrl=[NSURL URLWithString:logo];
                btn.tag=[gid integerValue];
                
                if (hasCachedImage(imgUrl)) {
                    [btn setImage:[UIImage imageWithContentsOfFile:pathForURL(imgUrl)] forState:UIControlStateNormal];
                }else
                {
                    NSData* data = [NSData dataWithContentsOfURL:imgUrl];
                    UIImage *img=[UIImage imageWithData:data];
                    [btn setImage:img forState:UIControlStateNormal];
                }
                [btn addTarget:self action:@selector(searchgoods:) forControlEvents:UIControlEventTouchDown];
                
                [self.view addSubview:btn];
                [self.view addSubview:label];
            }
            
        });
    });

}

//查找商品
-(void)searchgoods:(UIButton *)btn
{
    goodslist *_goodslist=[[goodslist alloc]init];
    NSMutableDictionary * class = [NSMutableDictionary dictionaryWithCapacity:5];
    class=[DataService PostDataService:[NSString stringWithFormat:@"%@api/getGoodsClassify",domainser] postDatas:[NSString stringWithFormat:@"pid=%d",btn.tag]];
    NSArray *classlist=[class objectForKey:@"datas"];
    NSMutableString *inlayindex=[[NSMutableString alloc] init];
    for (NSDictionary *index in classlist) {
        if (inlayindex.length!=0) {
            [inlayindex appendString:@","];
            [inlayindex appendString:[NSString stringWithFormat:@"%@",[index objectForKey:@"id"]]];
        }else{
            [inlayindex appendString:[NSString stringWithFormat:@"%@",[index objectForKey:@"id"]]];
        }
    }
    _goodslist.cid=inlayindex;
    [self.navigationController pushViewController:_goodslist animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
