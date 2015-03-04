//
//  common.m
//  dzqz_6
//
//  Created by xing on 13-10-26.
//  Copyright (c) 2013年 moko. All rights reserved.
//

#import "Commons.h"

@implementation Commons

//设备唯一码 每次安装时都将重新生成
-(NSString*) UUID {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy(NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    
    return result;
}
//MD5加密
+ (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

//判断返回数据状态
-(BOOL) IsSuccess:(NSString *) result{
    //NSLog(@"ret:%@",result);
    
//    NSDictionary * dictResult = [result objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
//    
//    NSString * ret = [dictResult objectForKey:@"result"] ;
//    
//    if ([ret intValue]  == 0 ) {
//        return false;
//    }
//    else
//    {
//        return true;
//    }
    return true;
}

-(NSString *)getGoldtypename:(NSString *)codevalue{
    
    if ([codevalue isEqualToString:@"1"]) {
        return @"18K黄";
    }
    else if ([codevalue isEqualToString:@"2"]){
        return @"18K白";
    }
    else if ([codevalue isEqualToString:@"3"]){
        return @"18K双色";
    }
    else if ([codevalue isEqualToString:@"4"]){
        return @"18K玫瑰金";
    }
    else if ([codevalue isEqualToString:@"5"]){
        return @"PT900";
    }
    else if ([codevalue isEqualToString:@"6"]){
        return @"PT950";
    }
    else if ([codevalue isEqualToString:@"7"]){
        return @"PD950";
    }
    
    return codevalue;
}


-(NSString *)getGoldtypevalue:(NSString *)name
{
    if ([name isEqualToString:@"18K黄"]) {
        return @"1";
    }
    else if ([name isEqualToString:@"18K白"]){
        return @"2";
    }
    else if ([name isEqualToString:@"18K双色"]){
        return @"3";
    }
    else if ([name isEqualToString:@"18K玫瑰金"]){
        return @"4";
    }
    else if ([name isEqualToString:@"PT900"]){
        return @"5";
    }
    else if ([name isEqualToString:@"PT950"]){
        return @"6";
    }
    else if ([name isEqualToString:@"PD950"]){
        return @"7";
    }
    
    return name;
}

//时间戳转时间(到天)
-(NSString *)stringtoDate:(id)str
{
    if (str!=[NSNull null]) {
        NSString *time =[NSString stringWithFormat:@"%@",str];
        NSString *aaa=[time substringToIndex:10];
        NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
        [formatter setTimeZone:timeZone];
        NSDate *date=[NSDate dateWithTimeIntervalSince1970:[aaa intValue]];
        return [formatter stringFromDate:date];
    }else{
        return @"";
    }
}

-(NSString *)stringtoDateforsecond:(id)str
{
    if (str!=[NSNull null]) {
        NSString *time =[NSString stringWithFormat:@"%@",str];
        NSString *aaa=[time substringToIndex:10];
        NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
        [formatter setTimeZone:timeZone];
        NSDate *date=[NSDate dateWithTimeIntervalSince1970:[aaa intValue]];
        return [formatter stringFromDate:date];
    }else{
        return @"";
    }
}

#pragma mark - UIWebViewDelegate
//webviewHtml内容自适应屏幕宽度
- (NSString *)webViewDidFinishLoad:(UIWebView *)webView webStr:(NSString *)webStr
{
    
    //js获取body宽度
    NSString *bodyWidth= [webView stringByEvaluatingJavaScriptFromString: @"document.body.scrollWidth"];
    
    int widthOfBody = [bodyWidth intValue];
    
    //获取实际要显示的html
    NSString *html = [self htmlAdjustWithPageWidth:widthOfBody
                                              html:webStr
                                           webView:webView];
    
    //加载实际要现实的html
    return html;
}

//获取宽度已经适配于webView的html。这里的原始html也可以通过js从webView里获取
- (NSString *)htmlAdjustWithPageWidth:(CGFloat )pageWidth
                                 html:(NSString *)html
                              webView:(UIWebView *)webView
{
    NSMutableString *str = [NSMutableString stringWithString:html];
    //计算要缩放的比例
    CGFloat initialScale = webView.frame.size.width/pageWidth;
    //将</head>替换为meta+head
    NSString *stringForReplace = [NSString stringWithFormat:@"<meta name=\"viewport\" content=\" initial-scale=%f, minimum-scale=0.1, maximum-scale=2.0, user-scalable=yes\"></head>",initialScale];
    
    NSRange range =  NSMakeRange(0, str.length);
    //替换
    [str replaceOccurrencesOfString:@"</head>" withString:stringForReplace options:NSLiteralSearch range:range];
    return str;
}

//计算文本获得对应的高度
-(CGSize)NSStringHeightForLabel:(UIFont*)font width:(int)width Str:(NSString *)Str
{
    CGSize size =CGSizeMake(width,0);
    UIFont * tfont = font;
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
    
    CGSize  actualsize =[Str boundingRectWithSize:size options:
                         NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
    return actualsize;
}


//把<null>和(null)转为@“”
-(NSString *)turnNullValue:(NSString *)key Object:(NSDictionary *)Object
{
    NSString *str=[NSString stringWithFormat:@"%@",[Object objectForKey:key]];
    if ([str isEqualToString:@"<null>"] || [str isEqualToString:@"(null)"]) {
        return @"";
    }else{
        return str;
    }
}

@end
