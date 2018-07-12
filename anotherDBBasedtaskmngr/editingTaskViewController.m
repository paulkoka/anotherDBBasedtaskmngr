//
//  editingTaskViewController.m
//  anotherDBBasedtaskmngr
//
//  Created by paul on 11/07/2018.
//  Copyright © 2018 paul. All rights reserved.
//

#import "editingTaskViewController.h"

@interface editingTaskViewController ()<UITextViewDelegate>

@end

@implementation editingTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.taskName.delegate = self;
    self.subtitle.delegate = self;
    self.additionalInfo.delegate = self;
    self.database = [[dbManager alloc] init];
    [self.database createDB];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    [textView resignFirstResponder];
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)Save:(id)sender {
    TaskItem* item = [[TaskItem alloc] init];
    item.titleName = self.taskName.text;
    item.subtitleName = self.subtitle.text;
    item.additonalonfo = self.additionalInfo.text;
    
    [self.database addTask:item];
    
    [self.navigationController popViewControllerAnimated:YES];
    

        // Prepare the query string.
        // If the recordIDToEdit property has value other than -1, then create an update query. Otherwise create an insert query.
        NSString *query;

}
@end
