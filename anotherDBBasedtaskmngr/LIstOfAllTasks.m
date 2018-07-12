//
//  LIstOfAllTasks.m
//  anotherDBBasedtaskmngr
//
//  Created by paul on 11/07/2018.
//  Copyright © 2018 paul. All rights reserved.
//

#import "LIstOfAllTasks.h"
#import "TaskItem.h"


@interface LIstOfAllTasks ()

@end

@implementation LIstOfAllTasks

-(void)loadView{
    [super loadView];

    self.listOfTasks.dataSource = self;
    self.listOfTasks.delegate = self;
    self.database = [[dbManager alloc] init];
    [self.database createDB];
    self.datacontainer = [NSMutableArray arrayWithArray:[self.database getDataFromDB]];

    [self.listOfTasks reloadData];

}

-(void) loadData{
    self.datacontainer = [NSMutableArray arrayWithArray:[self.database getDataFromDB]];
    [self.listOfTasks reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.datacontainer.count;
    
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* myIdentifire = @"taskInfoCell";
    
    UITableViewCell* cell = [self.listOfTasks dequeueReusableCellWithIdentifier:myIdentifire];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myIdentifire];
    }
    
    TaskItem* temp = [self.datacontainer objectAtIndex:indexPath.row];
    
    cell.textLabel.text = temp.titleName;
    cell.detailTextLabel.text = temp.subtitleName;
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    editingTaskViewController *editInfoViewController = [segue destinationViewController];
    editInfoViewController.delegate = self;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        TaskItem* item = [[TaskItem alloc] init];
        
        item = [self.datacontainer objectAtIndex:indexPath.row];
        
        [self.database deliteTaskByIdentifire:item.identifire];
    
        [self loadData];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addNewRecord:(id)sender {
    [self performSegueWithIdentifier:@"idEdit" sender:self];
}
@end
