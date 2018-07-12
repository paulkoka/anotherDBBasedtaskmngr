//
//  editingTaskViewController.h
//  anotherDBBasedtaskmngr
//
//  Created by paul on 11/07/2018.
//  Copyright © 2018 paul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskItem.h"
#import "dbManager.h"

@protocol editingTaskViewController

-(void)editingInfoWasFinished;

@end

@interface editingTaskViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *taskName;
@property (weak, nonatomic) IBOutlet UITextField *subtitle;
@property (weak, nonatomic) IBOutlet UITextView *additionalInfo;

@property (nonatomic, strong) dbManager* database;

@property (nonatomic, strong) id<editingTaskViewController> delegate;

- (IBAction)Save:(id)sender;

@end
