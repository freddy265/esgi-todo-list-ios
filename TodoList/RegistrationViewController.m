//
//  RegistrationViewController.m
//  TodoList
//
//  Created by Julien Sarazin on 18/01/15.
//  Copyright (c) 2015 Julien Sarazin. All rights reserved.
//

#import "RegistrationViewController.h"
#import "AuthenticationService.h"

#import "UITextField+Geometry.h"

@interface RegistrationViewController ()
@property (weak, nonatomic) IBOutlet UITextField *fieldName;
@property (weak, nonatomic) IBOutlet UITextField *fieldEmail;
@property (weak, nonatomic) IBOutlet UITextField *fieldPassword;
@property (weak, nonatomic) IBOutlet UITextField *fieldConfirmPassword;

@property (strong, nonatomic) AuthenticationService *authService;

@end

@implementation RegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.authService = [AuthenticationService sharedInstance];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.fieldName setPaddingLeftTo:10];
    [self.fieldEmail setPaddingLeftTo:10];
    [self.fieldPassword setPaddingLeftTo:10];
    [self.fieldConfirmPassword setPaddingLeftTo:10];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

- (IBAction)didTouchRegisterButton:(id)sender {
    if (self.fieldEmail.text.length == 0 || self.fieldPassword.text.length == 0)
        return;
    
    if (![self.fieldPassword.text isEqualToString:self.fieldConfirmPassword.text])
        return;
    
    NSDictionary *userDict = @{
                               @"user": @{
                                       @"name" : self.fieldName.text,
                                       @"email": self.fieldEmail.text,
                                       @"password": self.fieldPassword.text
                                       }
                               };
    
    [self.authService registerUser:userDict success:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    } error:nil];
    
}

- (IBAction)didTouchCancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end