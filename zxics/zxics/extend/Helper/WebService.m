////
////  WebService.m
////  ACS
////
////  Created by 陈 星 on 13-5-13.
////
////
//
//#import "WebService.h"
//
//@implementation WebService
//
//@synthesize businessCode;
//@synthesize params;
//@synthesize datas;
//
//- (NSString *)GetData
//{
//    //加密参数
//    //NSString * DESbusinessCode = [DesUtil TripleDES:businessCode encryptOrDecrypt:kCCEncrypt];//kCCDecrypt kCCEncrypt
//	//加密参数
//    //NSString * DESparams = [DesUtil TripleDES:params encryptOrDecrypt:kCCEncrypt];//kCCDecrypt kCCEncrypt
//    
//    //封装soap请求消息
//	NSString *soapMessage = [NSString stringWithFormat:
//							 @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
//							 "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
//							 "<soap:Body>\n"
//							 "<ns1:getData xmlns:ns1=\"http://services.mgear.com/\">\n"
//							 "<arg0>%@</arg0>\n"
//                             "<arg1>%@</arg1>"
//							 "</ns1:getData>\n"
//							 "</soap:Body>\n"
//							 "</soap:Envelope>\n", businessCode ,params];
//	//NSLog(@"%@",soapMessage);
//	//请求发送到的路径
//	NSURL *url = [NSURL URLWithString:domainwebservice];
//	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
//	NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//	
//	//以下对请求信息添加属性前四句是必有的，第五句是soap信息。
//	[theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[theRequest addValue: @"http://services.mgear.com/" forHTTPHeaderField:@"SOAPAction"];
//	[theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//	[theRequest setHTTPMethod:@"POST"];
//	[theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//	
//    NSData* retData;
//    NSURLResponse *response;
//    NSError *error = nil;
//    retData = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&response error:&error];
//    
//    NSString * Results =@"";
//    if (retData) {
//        Results =[[NSString alloc] initWithData:retData encoding:NSUTF8StringEncoding];
//    }else{
//        
//        Results =@"{\"result\":\"0\",\"info\":\"请求服务器出错！\"}";
//    }
//    
//    //NSLog(@"%@",Results);
//    
//    return Results;
//}
//
//- (NSString *)SetData
//{
//    //加密参数
//    //NSString * DESbusinessCode = [DesUtil TripleDES:businessCode encryptOrDecrypt:kCCEncrypt];//kCCDecrypt kCCEncrypt
//	//加密参数
//    //NSString * DESdatas = [DesUtil TripleDES:datas encryptOrDecrypt:kCCEncrypt];//kCCDecrypt kCCEncrypt
//    
//    
//	//封装soap请求消息
//	NSString *soapMessage = [NSString stringWithFormat:
//							 @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
//							 "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
//							 "<soap:Body>\n"
//							 "<ns1:setData xmlns:ns1=\"http://services.mgear.com/\">\n"
//							 "<arg0>%@</arg0>\n"
//                             "<arg1>%@</arg1>"
//							 "</ns1:setData>\n"
//							 "</soap:Body>\n"
//							 "</soap:Envelope>\n", businessCode , params];
//	//NSLog(soapMessage);
//	//请求发送到的路径
//	NSURL *url = [NSURL URLWithString:domainwebservice];
//	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
//	NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
//	
//	//以下对请求信息添加属性前四句是必有的，第五句是soap信息。
//	[theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[theRequest addValue: @"http://services.mgear.com/" forHTTPHeaderField:@"SOAPAction"];
//	[theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//	[theRequest setHTTPMethod:@"POST"];
//	[theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
//	
//    NSData* retData;
//    NSURLResponse *response;
//    NSError *error = nil;
//    retData = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&response error:&error];
//    
//    NSString * Results =@"";
//    if (retData) {
//        Results =[[NSString alloc] initWithData:retData encoding:NSUTF8StringEncoding];
//    }else{
//        
//        Results =@"{\"result\":\"0\",\"info\":\"亲，请求服务器出错！\"}";
//    }
//
//    //NSLog(@"%@",Results);
//    
//    return Results;
//}
//
//
//@end
