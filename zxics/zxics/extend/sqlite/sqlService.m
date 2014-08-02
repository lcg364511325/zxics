//
//  sqlService.m
//  ACS
//
//  Created by 陈 星 on 13-5-2.
//
//

#import "sqlService.h"

@implementation sqlService

@synthesize _database;

- (id)init
{
    return self;
}

- (void)dealloc
{
    //[super dealloc]; 
}

//将根目录下面的数据库文件复制到sqlite的指定目录下面
-(BOOL)initializeDb{
    
	//NSLog(@"initializeDB");
    
	//look to see if DB is in known location (~/Documents/$DATABASE_FILE_NAME)
	//START:code.DatabaseShoppingList.findDocumentsDirectory
	NSArray*searchPaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
	NSString * documentFolderPath=[searchPaths objectAtIndex:0];
    
	//查看文件目录
    
	NSLog(@"查看文件目录:%@",documentFolderPath);
    
	NSString * dbFilePath=[documentFolderPath stringByAppendingPathComponent:kFileallname];
    
	//END:code.DatabaseShoppingList.findDocumentsDirectory
    
    //[dbFilePath retain];
    
    //START:code.DatabaseShoppingList.copyDatabaseFileToDocuments
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:dbFilePath]){
        
        //didn't find db,need to copy
        
        NSString*backupDbPath=[[NSBundle mainBundle]pathForResource:kfilename ofType:kfiletype];
        
        if(backupDbPath==nil){
            
            //couldn't find backup db to copy,bail
            
            return NO;
            
        }else{
            
            BOOL copiedBackupDb=[[NSFileManager defaultManager] copyItemAtPath:backupDbPath toPath:dbFilePath error:nil];
            
            if(!copiedBackupDb){
                
                //copying backup db failed,bail
                
                return NO;
                
            }
            //NSLog(@"数据库拷贝成功");
        }
        
    }
    
    //NSLog(@"bottomo finitialize Db");
    
    return YES;
    
    //END:code.DatabaseShoppingList.copyDatabaseFileToDocuments
}

//获取document目录并返回数据库目录
- (NSString *)dataFilePath{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //NSLog(@"=======%@",documentsDirectory);
    return [documentsDirectory stringByAppendingPathComponent:kFileallname];//这里很神奇，可以定义成任何类型的文件，也可以不定义成.db文件，任何格式都行，定义成.sb文件都行，达到了很好的数据隐秘性
    
}

//创建，打开数据库
- (BOOL)openDB {
    
    //如果数据库已经打开了，则直接返回
    if(_database)return TRUE;
    
    //获取数据库路径
    NSString *path = [self dataFilePath];
    
    //NSLog(@"%@",path);
    
    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //判断数据库是否存在
    BOOL find = [fileManager fileExistsAtPath:path];
    
    //如果数据库存在，则用sqlite3_open直接打开（不要担心，如果数据库不存在sqlite3_open会自动创建）
    if (find) {
        
        //NSLog(@"Database file have already existed.");
        
        //打开数据库，这里的[path UTF8String]是将NSString转换为C字符串，因为SQLite3是采用可移植的C(而不是
        //Objective-C)编写的，它不知道什么是NSString.
        if(sqlite3_open([path UTF8String], &_database) != SQLITE_OK) {
            
            //如果打开数据库失败则关闭数据库
            sqlite3_close(self._database);
            //NSLog(@"Error: open database file.");
            return NO;
        }
        
        return YES;
    }
    
    return NO;
}




//直接执行sql方法，比如修改，删除，插入的操作
-(BOOL)HandleSql:(NSString *)sql
{
    //判断数据库是否打开
    if ([self openDB]) {
        
        sqlite3_stmt *statement;
        //组织SQL语句
        const char *sqlT = [sql UTF8String];
        //将SQL语句放入sqlite3_stmt中
        int success = sqlite3_prepare_v2(_database, sqlT, -1, &statement, NULL);
        if (success != SQLITE_OK) {
            NSLog(@"Error: SQL语句 failed to HandleSql:%@",sql);
            sqlite3_close(_database);
            return NO;
        }
        
        //执行SQL语句。这里是更新数据库
        success = sqlite3_step(statement);
        //释放statement
        sqlite3_finalize(statement);
        
        //如果执行失败
        if (success == SQLITE_ERROR) {
            NSLog(@"Error: 执行失败 HandleSql:%@",sql);
            //关闭数据库
            sqlite3_close(_database);
            return NO;
        }
        //执行成功后依然要关闭数据库
        sqlite3_close(_database);
        return YES;
    }
    return NO;
}

//此方法不关闭数据库，要手动关闭调方法closeDB关闭
-(BOOL) execSql:(NSString *)sql {
    
    //先判断数据库是否打开
    if ([self openDB]) {
        
        char *errorMsg = nil;
        
        if(SQLITE_OK != sqlite3_exec(_database, [sql UTF8String],NULL,NULL,&errorMsg))
        {
            //sqlite3_close(_database);
            
            NSLog(@"error:%@",sql);
            
            NSLog(@"error:%s",errorMsg);
            
            return NO;
        }
        
        //NSLog(@"%@",insertSql);
        
        //sqlite3_close(_database);
        
        return YES;
        
    }
    return NO;
}

//执行sql
-(BOOL) execSqlandClose:(NSString *)sql {
    
    //先判断数据库是否打开
    if ([self openDB]) {
        
        char *errorMsg = nil;
        
        if(SQLITE_OK != sqlite3_exec(_database, [sql UTF8String],NULL,NULL,&errorMsg))
        {
            sqlite3_close(_database);
            
            NSLog(@"error:%@",sql);
            
            NSLog(@"error:%s",errorMsg);
            
            return NO;
        }
        
        //NSLog(@"%@",insertSql);
        
        sqlite3_close(_database);
        
        return YES;
        
    }
    return NO;
}

//关闭数据库连接
-(BOOL) closeDB
{
    @try {
        
        if(_database)sqlite3_close(_database);
        return YES;
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }

    return NO;
}

//清空数据
- (BOOL)ClearTableDatas:(NSString *)tableName{
    if ([self openDB]) {
        
        sqlite3_stmt *statement;
        
        //组织SQL语句
        NSString * t1 = @" delete from ";
        NSString * ts = [t1 stringByAppendingString:tableName];
        const char * sql =[ts UTF8String];
        
        //将SQL语句放入sqlite3_stmt中
        int success = sqlite3_prepare_v2(_database, sql, -1, &statement, NULL);
        if (success != SQLITE_OK) {
            //NSLog(@"Error: failed to delete:TB_Door");
            sqlite3_close(_database);
            return NO;
        }
        
        //执行SQL语句。这里是更新数据库
        success = sqlite3_step(statement);
        //释放statement
        sqlite3_finalize(statement);
        
        //如果执行失败
        if (success == SQLITE_ERROR) {
            //NSLog(@"Error: failed to delete the database with message.");
            //关闭数据库
            sqlite3_close(_database);
            return NO;
        }
        //执行成功后依然要关闭数据库
        sqlite3_close(_database);
        return YES;
    }
    return NO;
}

//查询记录的条数
- (int)getcount:(NSString *)sqls {
    
    //判断数据库是否打开
    if ([self openDB]) {
        
        sqlite3_stmt *statement = nil;
        
        const char *sql = [sqls UTF8String];
        if (sqlite3_prepare_v2(_database, sql, -1, &statement, NULL) != SQLITE_OK) {
            //NSLog(@"Error: failed to prepare statement with message:search TB_MyDoor.");
            return 0;
        } else {
            int row=0;
            //查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值。
            while (sqlite3_step(statement) == SQLITE_ROW) {
                row++;
            }
            
            return row;
            
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(_database);
    }
    
    return 0;
}



//以下是业务查询操作///////////////////////////////////////////////////////////////////////


@end
