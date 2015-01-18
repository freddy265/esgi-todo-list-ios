//
//  Todo.m
//  TodoList
//
//  Created by Julien Sarazin on 16/12/14.
//  Copyright (c) 2014 Julien Sarazin. All rights reserved.
//

#import "Todo.h"

@implementation Todo
- (instancetype)init{
    self = [super init];
    if (self){
        self.name = @"unnamed";
        self.details = @"no details";
        self.dueDate = [NSDate date];
    }
    
    return self;
}
@end
