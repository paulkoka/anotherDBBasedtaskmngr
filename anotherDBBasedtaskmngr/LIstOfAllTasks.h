//
//  LIstOfAllTasks.h
//  anotherDBBasedtaskmngr
//
//  Created by paul on 11/07/2018.
//  Copyright © 2018 paul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "dbManager.h"
#import "editingTaskViewController.h"

@interface LIstOfAllTasks : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *listOfTasks;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *addNew;

@property (nonatomic, strong) dbManager* database;
@property (strong, nonatomic) NSMutableArray* datacontainer;

- (IBAction)addNewRecord:(id)sender;

-(void) loadData;

@end
