//
//  User+JSONSerializer.h
//  TodoList
//
//  Created by Julien Sarazin on 18/01/15.
//  Copyright (c) 2015 Julien Sarazin. All rights reserved.
//

#import "User.h"

@interface User (JSONSerializer)
+ (User *)userFromJSON:(NSDictionary *)JSON;
@end
