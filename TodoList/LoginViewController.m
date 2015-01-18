//
//  LoginViewController.m
//  TodoList
//
//  Created by Julien Sarazin on 19/12/14.
//  Copyright (c) 2014 Julien Sarazin. All rights reserved.
//

#import "LoginViewController.h"
#import "AuthenticationService.h"

#import "UITextField+Geometry.h"

#define SEGUE_TO_LIST  @"LoginToList"
#define SEGUE_TO_REGISTRATION @"LoginToRegistration"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *fieldEmail;
@property (weak, nonatomic) IBOutlet UITextField *fieldPassword;

@property (weak, nonatomic) AuthenticationService *authService;

@end

@implementation LoginViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.authService = [AuthenticationService sharedInstance];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.fieldEmail setPaddingLeftTo:10];
    [self.fieldPassword setPaddingLeftTo:10];
}

#pragma mark - Navigation - 
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:SEGUE_TO_REGISTRATION])
        return;
    if ([segue.identifier isEqualToString:SEGUE_TO_LIST])
        return;
}

#pragma mark - Actions -
- (IBAction)didTouchRegisterButton:(id)sender {
    [self performSegueWithIdentifier:SEGUE_TO_REGISTRATION sender:nil];
}

- (IBAction)didTouchConnect:(id)sender {
    [self.authService authenticateWithEmail:self.fieldEmail.text password:self.fieldPassword.text success:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self performSegueWithIdentifier:SEGUE_TO_LIST sender:nil];
        });
    } error:nil];
}
@end
