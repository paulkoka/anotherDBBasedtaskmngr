//
//  dbManager.m
//  anotherDBBasedtaskmngr
//
//  Created by paul on 11/07/2018.
//  Copyright © 2018 paul. All rights reserved.
//

#import "dbManager.h"

static NSString* const DB_NAME = @"tasks.db";

@implementation dbManager


-(void) createDB{
    NSString* pathToDocuments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* pathToDBstring = [pathToDocuments stringByAppendingPathComponent:DB_NAME];
    self.pathToDB = [pathToDBstring UTF8String];
    
    if (sqlite3_open(_pathToDB, &(_database)) == SQLITE_OK) {
        NSLog(@"opened");
        char* errMSG;
        const char* sql_stmt = "create table if not exists todoList (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE, statement BOOL DEFAULT YES, TaskTitle TEXT, taskSubtitle TEXT, additionalInfo TEXT)";
        
        if (sqlite3_exec(_database, sql_stmt, NULL, NULL, &errMSG) == SQLITE_OK) {
            NSLog(@"tableCreated");
        }
    
    }
    
    sqlite3_close(_database);
    
};


-(NSMutableArray*) getDataFromDB{
    
    NSMutableArray* dataContainer = [NSMutableArray array];
    
    if (sqlite3_open(_pathToDB, &(_database)) == SQLITE_OK)
    {
        sqlite3_stmt *stmt;
        NSString* query = @"SELECT * from todoList";
        if (sqlite3_prepare_v2(_database, [query UTF8String], -1, &stmt, NULL) == SQLITE_OK) {
            NSLog(@"start processing data");
            while (sqlite3_step(stmt) == SQLITE_ROW) {
                
                int uniqueID = sqlite3_column_int(stmt, 0);
                BOOL state = (sqlite3_column_int(stmt, 1) == 0);
                char* titleChar = (char *) sqlite3_column_text(stmt, 2);
                char* subtitleChar = (char *) sqlite3_column_text(stmt, 3);
                char* additionalInfoChar = (char *) sqlite3_column_text(stmt, 4);
                
                NSString* title = [NSString string];
                NSString* subtitle = [NSString string];
                NSString* additionalInfo = [NSString string];
              
               
                if (titleChar) {
                    title = [[NSString alloc] initWithUTF8String:titleChar];
                }
                if (subtitleChar) {
                    subtitle = [[NSString alloc] initWithUTF8String: subtitleChar];
                }
                
                if (additionalInfoChar) {
                    additionalInfo = [[NSString alloc] initWithUTF8String:additionalInfoChar];
                }
                
                TaskItem* item = [[TaskItem alloc]  initWithUniqeId:uniqueID withState:state title:title subtitle:subtitle additionalInformation:additionalInfo];
                [dataContainer addObject:item];
   
            }
        }
    }
    return dataContainer;
}


-(void) addTask:(TaskItem*) item{
    if (sqlite3_open(_pathToDB, &(_database)) == SQLITE_OK) {
        NSLog(@"start adding");
        char* errMSG;
        
        NSString* quiery = [NSString stringWithFormat:@"INSERT INTO todoList (TaskTitle, taskSubtitle, additionalInfo) VALUES ('%@', '%@', '%@')", item.titleName, item.subtitleName, item.additonalonfo];
        
        if (sqlite3_exec(_database, [quiery UTF8String], NULL, NULL, &errMSG)== SQLITE_OK) {
            NSLog(@"added sucessfully");
        }
    }
    sqlite3_close(_database);
};


-(void) deliteTaskByIdentifire:(int) identifire{
    if (sqlite3_open(_pathToDB, &(_database)) == SQLITE_OK) {
        char* errMSG;
        
        NSString* quiery = [NSString stringWithFormat:@"DELETE FROM todoList WHERE id = '%d'", identifire];
        
        sqlite3_exec(_database, [quiery UTF8String], NULL, NULL, &errMSG);
        
    }
    sqlite3_close(_database);
};


-(void) updateTaskItem:(TaskItem*) item{
    if (sqlite3_open(_pathToDB, &(_database)) == SQLITE_OK) {
        char* errMSG;

        NSString* quiery = [NSString stringWithFormat:@"update todoList SET TaskTitle = '%@', taskSubtitle = '%@', additionalInfo = '%@' WHERE id = '%d'", item.titleName, item.subtitleName, item.additonalonfo,  item.identifire];

        sqlite3_exec(_database, [quiery UTF8String], NULL, NULL, &errMSG);

    }
    sqlite3_close(_database);
};


@end
