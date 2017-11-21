//
//  ViewController.m
//  textField
//
//  Created by JiWuChao on 2017/11/19.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

#import "ViewController.h"

#import "UITextField+NumberFormat.h"

@interface ViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textBankNumber;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self textBankNumber];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    return [UITextField inputTextField:textField
         shouldChangeCharactersInRange:range
                     replacementString:string
                        blankLocations:@[@4,@9,@14,@19,@24]
                            limitCount:24];
    
}// @[@6,@15] @[@4,@9,@14,@19,@24] @[@4,@9]


#pragma mark - setupUI

- (UITextField *)textBankNumber {
    if (!_textBankNumber) {
        _textBankNumber = [[UITextField alloc] initWithFrame:CGRectMake(50, 100, 250, 30)];
        _textBankNumber.delegate = self;
        _textBankNumber.backgroundColor = [UIColor lightGrayColor];
        _textBankNumber.keyboardType = UIKeyboardTypeNumberPad;
        _textBankNumber.placeholder = @"请输入~~";
        [self.view addSubview:_textBankNumber];
    }
    return _textBankNumber;
}




@end
