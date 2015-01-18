//
//  Todo+JSONSerliazer.h
//  TodoList
//
//  Created by Julien Sarazin on 18/01/15.
//  Copyright (c) 2015 Julien Sarazin. All rights reserved.
//

#import "Todo.h"

@interface Todo (JSONSerliazer)
+ (Todo *)todoFromJSON:(NSDictionary *)JSON;
- (NSDictionary *)toJSON;
@end
