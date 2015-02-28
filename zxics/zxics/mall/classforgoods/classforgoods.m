//
//  classforgoods.m
//  zxics
//
//  Created by johnson on 14-9-9.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "classforgoods.h"
#import "DataService.h"
#import "goodslist.h"

@interface classforgoods ()

@end

@implementation classforgoods

@synthesize classTView;
@synthesize delegate;

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
    list=[[NSMutableArray alloc]initWithCapacity:1];
    NSDictionary *all=[NSDictionary dictionaryWithObjectsAndKeys:@"全部",@"name",@"all",@"id", nil];
    [list addObject:all];
    [list addObjectsFromArray:[self classlistdata:@"0"]];
}

-(NSArray *)classlistdata:(NSString *)pid
{
    NSMutableDictionary * class = [NSMutableDictionary dictionaryWithCapacity:5];
    class=[DataService PostDataService:[NSString stringWithFormat:@"%@api/getGoodsClassify",domainser] postDatas:[NSString stringWithFormat:@"pid=%@",pid]];
    NSArray *classlist=[class objectForKey:@"datas"];
    return classlist;
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
    NSDictionary *classdetails=[list objectAtIndex:row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[classdetails objectForKey:@"name"]];
    return cell;
}

//tableview点击操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *classdetails=[list objectAtIndex:[indexPath row]];
    NSString *value=[NSString stringWithFormat:@"%@",[classdetails objectForKey:@"id"]];
    [list removeAllObjects];
    [list addObjectsFromArray:[self classlistdata:value]];
    if ([list count]>0) {
        [classTView reloadData];
    }else{
        NSString *valueStr=@"";
        if (![value isEqualToString:@"all"]) {
            valueStr=value;
        }
        [delegate passValue:valueStr key:nil tag:0];
        [self.navigationController popViewControllerAnimated:NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
