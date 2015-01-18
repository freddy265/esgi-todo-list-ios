//
//  AuthenticationManager.h
//  TodoList
//
//  Created by Julien Sarazin on 19/12/14.
//  Copyright (c) 2014 Julien Sarazin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface AuthenticationService : NSObject
+ (instancetype)sharedInstance;

@property (strong, nonatomic, readonly, getter=currentUser) User *user;

- (void)authenticateWithEmail:(NSString *)email password:(NSString *)password
                      success:(void (^)(void))success
                        error:(void (^)(void))error;

- (void)registerUser:(NSDictionary *)userDict
             success:(void (^)(void))success
               error:(void (^)(void))error;
@end
