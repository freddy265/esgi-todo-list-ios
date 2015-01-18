//
//  UITextField+Geometry.m
//  TodoList
//
//  Created by Julien Sarazin on 26/11/14.
//  Copyright (c) 2014 Julien Sarazin. All rights reserved.
//

#import "UITextField+Geometry.h"

@implementation UITextField (Geometry)
- (void)setPaddingLeftTo:(NSUInteger)padding{
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, padding, self.frame.size.height)];
    leftView.backgroundColor = self.backgroundColor;
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways;
}
@end
