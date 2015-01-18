//
//  Todo+JSONSerliazer.m
//  TodoList
//
//  Created by Julien Sarazin on 18/01/15.
//  Copyright (c) 2015 Julien Sarazin. All rights reserved.
//

#import "Todo+JSONSerliazer.h"

#define TODO_DATE_FORMAT @"dd/mm/yyyy"
@implementation Todo (JSONSerliazer)

+ (Todo *)todoFromJSON:(NSDictionary *)JSON{
    if (!JSON)
        return nil;
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = TODO_DATE_FORMAT;
    
    Todo *todo = [[Todo alloc] init];
    for (id key in JSON)
        if([todo respondsToSelector:NSSelectorFromString(key)]){
            if([key isEqualToString:@"dueDate"]){
                todo.dueDate = [dateFormatter dateFromString:JSON[key]];
            }
            else if ([key isEqualToString:@"done"])
                todo.done = [key boolValue];
            else
                [todo setValue:JSON[key] forKey:key];
        }
    return todo;
}

- (NSDictionary *)toJSON{
    
    NSMutableDictionary *json = [@{} mutableCopy];
    if (self._id)
        [json setObject:self._id forKey:@"_id"];
    if (self.name)
        [json setObject:self.name forKey:@"name"];
    if (self.details)
        [json setObject:self.details forKey:@"details"];
    if (self.dueDate){
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = TODO_DATE_FORMAT;
        [json setObject:[dateFormatter stringFromDate:self.dueDate] forKey:@"dueDate"];
        [json setObject:(self.done)? @"true" : @"false" forKey:@"done"];
    }
    
    return json;
}
@end
