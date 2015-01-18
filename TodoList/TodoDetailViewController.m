//
//  TodoDetailViewController.m
//  TodoList
//
//  Created by Julien Sarazin on 25/11/14.
//  Copyright (c) 2014 Julien Sarazin. All rights reserved.
//

#import "TodoDetailViewController.h"
#import "UITextField+Geometry.h"

@interface TodoDetailViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *switchDone;
@property (weak, nonatomic) IBOutlet UITextField *fieldName;
@property (weak, nonatomic) IBOutlet UITextView *txtDetails;
@property (weak, nonatomic) IBOutlet UIDatePicker *dpDueDate;

- (void)setupFromModel;
- (void)updateModelFromOutlets;
@end

@implementation TodoDetailViewController

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupFromModel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [self.fieldName setPaddingLeftTo:5];
}

#pragma mark - Overrides
- (void)setTodo:(Todo *)todo{
    _todo = todo;
    
    [self setupFromModel];
}

#pragma mark - Actions
- (IBAction)updateAction:(id)sender {
    [self updateModelFromOutlets];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Privates
- (void)setupFromModel{
    self.switchDone.on   = self.todo.done;
    self.fieldName.text  = self.todo.name;
    self.txtDetails.Text = self.todo.details;
    self.dpDueDate.date  = (self.todo.dueDate)? self.todo.dueDate : [NSDate date];
}

- (void)updateModelFromOutlets{
    self.todo.done = self.switchDone.isOn;
    self.todo.name = self.fieldName.text;
    self.todo.details = self.txtDetails.text;
    self.todo.dueDate = self.dpDueDate.date;
}
@end
