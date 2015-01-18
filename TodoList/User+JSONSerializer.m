//
//  User+JSONSerializer.m
//  TodoList
//
//  Created by Julien Sarazin on 18/01/15.
//  Copyright (c) 2015 Julien Sarazin. All rights reserved.
//

#import "User+JSONSerializer.h"

@implementation User (JSONSerializer)
+ (User *)userFromJSON:(NSDictionary *)JSON{
    if (!JSON)
        return nil;
    
    User *user = [[User alloc] init];
    for (id key in JSON)
        if([user respondsToSelector:NSSelectorFromString(key)])
            [user setValue:JSON[key] forKey:key];
    
    return user;
}
@end
