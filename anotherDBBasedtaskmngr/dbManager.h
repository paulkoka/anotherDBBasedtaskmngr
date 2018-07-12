//
//  dbManager.h
//  anotherDBBasedtaskmngr
//
//  Created by paul on 11/07/2018.
//  Copyright © 2018 paul. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TaskItem.h"
#import "sqlite3.h"

@interface dbManager : NSObject

@property (nonatomic) sqlite3* database;
@property (nonatomic, assign) const char* pathToDB;

-(void) createDB;

-(NSMutableArray*) getDataFromDB;

-(void) addTask:(TaskItem*) item;

-(void) deliteTaskByIdentifire:(int) identifire;

-(void) updateTaskItem:(TaskItem*) item;

@end
