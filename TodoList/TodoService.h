//
//  TodoManager.h
//  TodoList
//
//  Created by Julien Sarazin on 19/12/14.
//  Copyright (c) 2014 Julien Sarazin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Todo.h"

@interface TodoService : NSObject
#pragma mark - Singleton Pattern -
+ (instancetype)sharedInstance;

- (void)createTodo:(Todo *)todo completion:(void (^)(Todo *))completion;
- (void)updateTodo:(Todo *)todo completion:(void (^)(Todo *))completion;
- (void)deleteTodo:(Todo *)todo completion:(void (^)(Todo *))completion;
- (void)getTodosWithcompletion:(void (^)(NSArray *))completion;

@end
