//
//  DataHandler.h
//  Lab3-JohanHjalmarsson
//
//  Created by Johan Hjalmarsson on 2018-01-26.
//  Copyright © 2018 Johan Hjalmarsson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataHandler : NSObject

@property (nonatomic) NSMutableArray *tableList;
@property (nonatomic) NSMutableArray *toDoList;
@property (nonatomic) NSMutableArray *haveDoneList;
-(NSObject*)taskDone:(int)listIndex;
-(void)addTaskToList:(NSString*)task:(BOOL)important;
-(void)refreshList;
-(NSObject*)deleteTaskAtSection:(int)list listIndex:(int)listIndex;
-(NSString*)importansString:(BOOL)important;
-(NSMutableArray*)getList;
-(void)taskToHaveDoneList:(NSObject*)task;
-(NSString*)sectionName:(int)sectionId;
-(void)taskIsImportant:(BOOL)isImportant index:(int)index;
-(bool)isImportant:(int)task;
-(NSString*)getButtonTitle:(int)id;

@end
