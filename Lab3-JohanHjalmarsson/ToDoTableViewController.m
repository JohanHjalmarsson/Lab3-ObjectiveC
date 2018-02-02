//
//  ToDoTableViewController.m
//  Lab3-JohanHjalmarsson
//
//  Created by Johan Hjalmarsson on 2018-01-26.
//  Copyright © 2018 Johan Hjalmarsson. All rights reserved.
//

#import "ToDoTableViewController.h"
#import "DataHandler.h"
#import "UIColorConvert.h"

@interface ToDoTableViewController ()

@property (nonatomic) DataHandler *dataHandler;
@property (nonatomic) NSMutableArray *dataList;
@property (strong, nonatomic) IBOutlet UITableView *viewWindow;

@end

@implementation ToDoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self setUpList];
    
}

- (void) loadView {
    [super loadView];
    self.dataList = [self.dataHandler getList];
    [self.tableView reloadData];
}


- (void)viewWillAppear:(BOOL)animated {
    [self setUpList];
    [self.tableView reloadData];
}
- (void)setUpList {
    self.dataHandler = [[DataHandler alloc] init];
   // [self.dataHandler testData];
    self.dataList = [self.dataHandler getList];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [[self.dataList objectAtIndex:section]count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [[[self.dataList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectAtIndex:0];
    
    
    if ([[[[self.dataList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectAtIndex:1] isEqualToString:@"1"] &&
        indexPath.section == 0) {
       // cell.accessoryType = UITableViewCellAccessoryCheckmark;
        //cell.textLabel.text = [NSString stringWithFormat:@"(!) %@", [[[self.dataList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectAtIndex:0]];
        cell.imageView.image = [UIImage imageNamed:@"circle"];
    } else {
        cell.imageView.image = nil;
    }
   
    
   
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.dataHandler sectionName:(int)section];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

// KOLLA IN DETTA!
// Override to support editing the table view.

// Override to support editing the table view.
/*
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // VARFÖR FUNKAR DET INTE??????????
        //[[self.dataList objectAtIndex:indexPath.section] removeObjectAtIndex:indexPath.row];
        NSObject *task = [self.dataHandler taskDone:(int)indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.dataHandler taskToHaveDoneList:task];
        //[self loadView];
        [self.tableView reloadData];
    }
    //else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    //}
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/
/*
- (NSString *)tableView:(UITableView *)tableView
titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Task Done!";
}
*/
/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// KOLLA IN DETTA!

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *array;
    if (indexPath.section == 0) {
        UITableViewRowAction *button = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:[self.dataHandler getButtonTitle:0] handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
            //[self.dataHandler taskToHaveDoneList:[self.dataHandler taskDone:(int)indexPath.row]];
            NSObject *task = [self.dataHandler deleteTaskAtSection:(int)indexPath.section listIndex:(int)indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.dataHandler taskToHaveDoneList:task];
            [self.tableView reloadData];
            
            
            
        }];
        
        UITableViewRowAction *button2;
        if ([self.dataHandler isImportant:(int)indexPath.row]) {
            button2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:[self.dataHandler getButtonTitle:1] handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
                
                [self.dataHandler taskIsImportant:NO index:(int)indexPath.row];
                [self.tableView reloadData];
            }];
            
        } else {
             button2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:[self.dataHandler getButtonTitle:2] handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
                
                [self.dataHandler taskIsImportant:YES index:(int)indexPath.row];
                [self.tableView reloadData];
            }];
        }
       
        button.backgroundColor = [[UIColor alloc] initWithRgbRed:76.0f green:217.0f blue:100.0f];
        button2.backgroundColor = [[UIColor alloc] initWithRgbRed:255.0f green:149.0f blue:0.0f];
        array = @[button, button2];
    } else {
        UITableViewRowAction *button = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:[self.dataHandler getButtonTitle:3] handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
            
            [self.dataHandler deleteTaskAtSection:(int)indexPath.section listIndex:(int)indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView reloadData];
            
        }];
        button.backgroundColor = [UIColor redColor];
        array = @[button];
    }
    return array;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

@end
