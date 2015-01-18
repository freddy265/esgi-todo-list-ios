//
//  AuthenticationManager.m
//  TodoList
//
//  Created by Julien Sarazin on 19/12/14.
//  Copyright (c) 2014 Julien Sarazin. All rights reserved.
//

#import "AuthenticationService.h"
#import "SessionManager.h"
#import "User+JSONSerializer.h"

@interface AuthenticationService ()
@property (strong, nonatomic, readwrite) User *user;

@end

@implementation AuthenticationService
static AuthenticationService *sharedInstance = nil;

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

- (void)authenticateWithEmail:(NSString *)email password:(NSString *)password
                      success:(void (^)(void))success
                        error:(void (^)(void))error {
    [[SessionManager sharedInstance] POST:@"/login" data:@{@"email":email, @"password":password} completion:^(NSDictionary *json) {
        
        if (!json && error)
            error();
        
        self.user = [User userFromJSON:json];
        if (self.user && success)
            success();
    }];
}

- (void)registerUser:(NSDictionary *)userDict success:(void (^)(void))success error:(void (^)(void))error{
    [[SessionManager sharedInstance] POST:@"/user" data:userDict completion:^(NSDictionary *json) {
        if (!json && error)
            error();
        
        self.user = [User userFromJSON:json];
        if (success)
            success();
    }];
}
@end
