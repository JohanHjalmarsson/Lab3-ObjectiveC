//
//  AddTaskViewController.m
//  Lab3-JohanHjalmarsson
//
//  Created by Johan Hjalmarsson on 2018-01-26.
//  Copyright © 2018 Johan Hjalmarsson. All rights reserved.
//

#import "AddTaskViewController.h"
#import "DataHandler.h"

@interface AddTaskViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userInput;
@property (nonatomic) DataHandler *dataHandler;
@property (weak, nonatomic) IBOutlet UISwitch *importantSwitch;
@property (weak, nonatomic) IBOutlet UILabel *importantLabel;

@end

@implementation AddTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataHandler = [[DataHandler alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addButtonClicked:(id)sender {
    [self.dataHandler addTaskToList:self.userInput.text :self.importantSwitch.on];
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)importanSwitchSwitched:(id)sender {
    self.importantLabel.text = [self.dataHandler importansString:self.importantSwitch.on];
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
