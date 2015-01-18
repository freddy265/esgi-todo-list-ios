//
//  User.h
//  TodoList
//
//  Created by Julien Sarazin on 19/12/14.
//  Copyright (c) 2014 Julien Sarazin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject 
@property (strong, nonatomic) NSString *_id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *email;
@end
