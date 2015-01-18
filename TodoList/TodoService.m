//
//  TodoManager.m
//  TodoList
//
//  Created by Julien Sarazin on 19/12/14.
//  Copyright (c) 2014 Julien Sarazin. All rights reserved.
//

#import "TodoService.h"
#import "SessionManager.h"
#import "Todo+JSONSerliazer.h"

@implementation TodoService
static TodoService *sharedInstance = nil;

#pragma mark - Singleton Pattern -
+ (instancetype)sharedInstance{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        if (sharedInstance == nil)
            sharedInstance = [[super allocWithZone:NULL] init];
    });
    return sharedInstance;
}
+ (id)allocWithZone:(NSZone *)zone{
    return [self sharedInstance];
}
- (id)copyWithZone:(NSZone *)zone{
    return self;
}
- (id)init{
    if(nil != (self = [super init]))
    {}
    return self;
}

- (void)createTodo:(Todo *)todo completion:(void (^)(Todo *))completion{
    [[SessionManager sharedInstance] POST:@"/todo" data:@{@"todo" : todo.toJSON} completion:^(NSDictionary *JSON) {
        Todo *createdTodo = [Todo todoFromJSON:JSON];
        if (completion) completion(createdTodo);
    }];
}

- (void)updateTodo:(Todo *)todo completion:(void (^)(Todo *))completion{
    [[SessionManager sharedInstance] PUT:@"/todo" data:@{@"todo" : todo.toJSON} completion:^(NSDictionary *JSON) {
        Todo *updatedTodo = [Todo todoFromJSON:JSON];
        if (completion) completion(updatedTodo);
    }];
}

- (void)deleteTodo:(Todo *)todo completion:(void (^)(Todo *))completion{
    NSString *url = [NSString stringWithFormat:@"/todo/%@", todo._id];
    [[SessionManager sharedInstance] DELETE:url data:nil completion:^(NSDictionary *JSON) {
        Todo *deletedTodo = [Todo todoFromJSON:JSON];
        if (completion) completion(deletedTodo);
    }];
}

- (void)getTodosWithcompletion:(void (^)(NSArray *))completion{
    [[SessionManager sharedInstance] LIST:@"/todos" completion:^(NSArray * JSON) {
        NSMutableArray *todos = [@[] mutableCopy];
        for (NSDictionary *object in JSON){
            Todo *todo = [Todo todoFromJSON:object];
            [todos addObject:todo];
        }
        
        if (completion) completion(todos);
    }];
}

@end
