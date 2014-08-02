//
//  WebService.h
//  ACS
//
//  Created by 陈 星 on 13-5-13.
//
//

#import <Foundation/Foundation.h>

@interface WebService : NSObject

@property (nonatomic, strong) NSString * businessCode ;
@property (nonatomic, strong) NSString * params ;
@property (nonatomic, strong) NSString * datas ;


- (NSString *)GetData ;

- (NSString *)SetData ;

@end
