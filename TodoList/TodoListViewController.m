//
//  ViewController.m
//  TodoList
//
//  Created by Julien Sarazin on 16/11/14.
//  Copyright (c) 2014 Julien Sarazin. All rights reserved.
//

#import "TodoListViewController.h"
#import "TodoDetailViewController.h"

#import "TodoService.h"
#import "Todo.h"

#define TODO_CELL_ID        @"TodoCellIdentifier"
#define SEGUE_TO_DETAIL_ID  @"ListToDetail"


@interface TodoListViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnAddTodo;
@property (weak, nonatomic) IBOutlet UITableView *tableTodos;
@property (weak, nonatomic) IBOutlet UITextField *fieldTodo;

@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) NSMutableArray *todos;
@property (weak, nonatomic) TodoService *todoService;
@property (weak, nonatomic) Todo *selectedTodo;

@property (strong, nonatomic) UIRefreshControl *refreshControl;
@end

@implementation TodoListViewController
#pragma mark - Privates
- (void)setupModel{
    self.todoService = [TodoService sharedInstance];
}

- (void)setupRefreshControl {
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
    [self.tableTodos addSubview:self.refreshControl];
}

- (void)refreshData {
    [self.refreshControl beginRefreshing];
    [self.todoService getTodosWithcompletion:^(NSArray *todos) {
        self.todos = [[todos sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [[obj1 name] compare:[obj2 name]];
        }] mutableCopy];
        
        [self.tableTodos reloadData];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"MMM d, h:mm a";
        NSString *title = [NSString stringWithFormat:@"Last update: %@", [dateFormatter stringFromDate:[NSDate date]]];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title];
        self.refreshControl.attributedTitle = attributedTitle;
        
        [self.refreshControl endRefreshing];
    }];
}

- (void)configureOutlets{
    self.tableTodos.delegate = self;
    self.tableTodos.dataSource = self;
    
    self.dateFormatter = [NSDateFormatter new];
    self.dateFormatter.dateFormat = @"dd/MM/YYYY";
}

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupModel];
    [self configureOutlets];
    [self setupRefreshControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.tableTodos reloadData];
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:SEGUE_TO_DETAIL_ID]){
        TodoDetailViewController *controller = segue.destinationViewController;
        controller.todo = self.selectedTodo;
    }
}

#pragma mark - Actions
- (IBAction)didTouchAddButton:(id)sender {
    if ([self.fieldTodo.text isEqualToString:@""])
        return;
    
    Todo *newTodo = [[Todo alloc] init];
    newTodo.name = self.fieldTodo.text;
    newTodo.done = false;
    [self.fieldTodo setText:@""];
    
    [self.todoService createTodo:newTodo completion:^(Todo *createdTodo) {
        [self.todos addObject:createdTodo];
        self.todos = [[self.todos sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [[obj1 name] compare:[obj2 name]];
        }] mutableCopy];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableTodos reloadData];
        });
    }];
}


#pragma mark - UITableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.todos.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableTodos dequeueReusableCellWithIdentifier:TODO_CELL_ID];
    
    Todo *todo = self.todos[indexPath.row];
    cell.textLabel.text = todo.name;
    cell.backgroundColor = (todo.done)? [UIColor greenColor] : [UIColor lightGrayColor];
    cell.detailTextLabel.text = [self.dateFormatter stringFromDate:todo.dueDate];
    NSLog(@"dueDate: %@, %@", todo.dueDate, [self.dateFormatter stringFromDate:todo.dueDate]);
    
    return cell;
}


#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedTodo = self.todos[indexPath.row];
    [self performSegueWithIdentifier:SEGUE_TO_DETAIL_ID sender:self];
}

@end
