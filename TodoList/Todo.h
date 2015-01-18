//
//  Todo.h
//  TodoList
//
//  Created by Julien Sarazin on 16/12/14.
//  Copyright (c) 2014 Julien Sarazin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Todo : NSObject
@property (strong, nonatomic) NSString *_id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *details;
@property (strong, nonatomic) NSDate *dueDate;
@property (assign, nonatomic) BOOL done;
@end
