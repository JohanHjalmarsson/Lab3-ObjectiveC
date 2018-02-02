//
//  DataHandler.m
//  Lab3-JohanHjalmarsson
//
//  Created by Johan Hjalmarsson on 2018-01-26.
//  Copyright © 2018 Johan Hjalmarsson. All rights reserved.
//

#import "DataHandler.h"

@interface DataHandler ()

@property (nonatomic) NSString *important;
@property (nonatomic) NSString *notImportant;
@property (nonatomic) NSMutableArray *testArray;

@end

@implementation DataHandler

-(instancetype)init {
    self = [super init];
    if(self) {
        self.important = @"1";
        self.notImportant = @"0";
        [self setUpListFromUserDefaults];
    }
    return self;
}

-(void)saveListToUserDefaults {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:self.toDoList forKey:@"toDoList"];
    [userDefaults setObject:self.haveDoneList forKey:@"haveDoneList"];
}

- (void)setUpListFromUserDefaults {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:@"toDoList"] && [userDefaults objectForKey:@"haveDoneList"]) {
        NSArray *tempToDoList = [userDefaults objectForKey:@"toDoList"];
        NSArray *tempHaveDoneList = [userDefaults objectForKey:@"haveDoneList"];
        self.toDoList = tempToDoList.mutableCopy;
        self.haveDoneList = tempHaveDoneList.mutableCopy;
    } else {
        self.toDoList = [[NSMutableArray alloc] init];
        self.haveDoneList = [[NSMutableArray alloc] init];
    }
}

- (void) refreshList {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.tableList = [userDefaults objectForKey:@"tableList"];
}

-(NSMutableArray*)getList {
    NSMutableArray *list = [[NSMutableArray alloc] init];
    [list addObject:self.toDoList];
    [list addObject:self.haveDoneList];
    return list;
}

-(void)taskToHaveDoneList:(NSObject*)task {
    [self.haveDoneList addObject:task];
    [self saveListToUserDefaults];
    //[self setUpListFromUserDefaults];
}

-(NSObject*)deleteTaskAtSection:(int)list listIndex:(int)listIndex {
    NSObject *task;
    if (list == 0) {
        task  = [self.toDoList objectAtIndex:listIndex];
        [self.toDoList removeObjectAtIndex:listIndex];
    }
    else if (list == 1) {
        [self.haveDoneList removeObjectAtIndex:listIndex];
    }
    [self saveListToUserDefaults];
    return task;
}

-(NSString*)importansString:(BOOL)important {
    NSString *string;
    if (important) {
        string = @"Viktigt";
    } else {
        string = @"Inte viktigt";
    }
    return string;
}

-(NSString*)sectionName:(int)sectionId {
    NSString *sectionName;
    if(sectionId == 0) {
        sectionName = @"Att göra";
    }
    else if (sectionId == 1) {
        sectionName = @"Genomförda";
    }
    return sectionName;
}

-(bool)isImportant:(int)task {
    return [[[self.toDoList objectAtIndex:task] objectAtIndex:1] isEqualToString:self.important];
}

-(void)addTaskToList:(NSString*)task:(BOOL)important {
    if (important) {
        [self.toDoList addObject:@[task, self.important]];
    } else {
        [self.toDoList addObject:@[task, self.notImportant]];
    }
    [self saveListToUserDefaults];
}

-(void)taskIsImportant:(BOOL)isImportant index:(int)index {
    NSString *string = [[self.toDoList objectAtIndex:index] objectAtIndex:0];
    NSArray *temp;
    if (isImportant) {
        temp = @[string, self.important];
    } else {
        temp = @[string, self.notImportant];
    }
    
    [self.toDoList removeObjectAtIndex:index];
    [self.toDoList insertObject:temp atIndex:index];
    [self saveListToUserDefaults];
}

-(NSString*)getButtonTitle:(int)id {
    NSString *title;
    switch (id) {
        case 0:
            title = @"Klar";
            break;
        case 1:
            title = @"Flagga av";
            break;
        case 2:
            title = @"Flagga";
            break;
        case 3:
            title = @"Rensa";
            break;
        default:
            title = @"Error";
    }
    return title;
}


@end
