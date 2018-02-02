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
    self.dataList = [self.dataHandler getList];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
        cell.imageView.image = [UIImage imageNamed:@"circle"];
    } else {
        cell.imageView.image = nil;
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.dataHandler sectionName:(int)section];
}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *array;
    if (indexPath.section == 0) {
        UITableViewRowAction *button = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:[self.dataHandler getButtonTitle:0] handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
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
