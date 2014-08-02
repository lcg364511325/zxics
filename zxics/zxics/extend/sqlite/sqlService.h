//
//  sqlService.h
//  ACS
//
//  Created by 陈 星 on 13-5-2.
//
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface sqlService : NSObject
{
    sqlite3 *_database;
}

@property (nonatomic) sqlite3 *_database;

-(BOOL) initializeDb;
-(BOOL) openDB;
-(BOOL) HandleSql:(NSString*)sql;
-(BOOL) execSql:(NSString*)sql;
//执行sql
-(BOOL) execSqlandClose:(NSString *)sql;
//关闭数据库连接
-(BOOL) closeDB;
//查询记录的条数
- (int)getcount:(NSString *)sqls;
//清空数据
- (BOOL)ClearTableDatas:(NSString *)tableName;

//清空数据
- (BOOL)ClearAllTableDatas;



@end
