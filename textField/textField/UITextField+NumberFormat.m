//
//  UITextField+NumberFormat.m
//  textField
//
//  Created by JiWuChao on 2017/11/21.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

#import "UITextField+NumberFormat.h"

@implementation UITextField (NumberFormat)

+ (BOOL)inputTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
     replacementString:(NSString *)string
        blankLocations:(NSArray<NSNumber *> *)blankLocation
            limitCount:(NSInteger)limitCount {
    
        BOOL limit = YES;
        if (limitCount == 0) {
            limit = NO;
        }
        if (textField) {
            NSString *text = textField.text;
            if ([string isEqualToString:@""]) { // 删除
                if (range.length == 1) {// 删除一位
                    if (range.location == text.length - 1) { // location是下标 此句表示删除的最后一位
                        return YES;
                    } else { // 不是最后一位
                        NSInteger offset = range.location;
                        if (range.location < text.length && [text characterAtIndex:range.location] == ' ' && [textField.selectedTextRange isEmpty]) {
                            [textField deleteBackward];
                            offset --;
                        }
                        [textField deleteBackward];
                        textField.text = [self insertString:textField.text withBlankLocations:blankLocation];
                        //设置光标的位置
                        [self setCursorLocation:textField withOffset:offset];
                        return NO;
                    }
                } else if (range.length > 1) {
                    BOOL lastOne = NO;
                    if (range.location + range.length == text.length) {//是否是最后一位
                        lastOne = YES;
                    }
                    [textField deleteBackward];
                    textField.text = [self insertString:textField.text withBlankLocations:blankLocation];
                    NSInteger offset = range.location;
                    if (lastOne) {
                        // 最后一个不需要设置光标
                    } else {
                        [self setCursorLocation:textField withOffset:offset];
                    }
                    return NO;
                } else {
                    return YES;
                }
            } else if (string.length > 0) {
                if (limit) {
                    if ([self removeBlankString:textField.text].length + string.length - range.length > limitCount ) {// [self whiteSpaseString:textField.text].length 目前textfield中有的 内容的长度 string.length 即将加入的内容的长度 range.length
                        return NO;
                    }
                }
            }
            [textField insertText:string];
            textField.text = [self insertString:textField.text withBlankLocations:blankLocation];
            NSInteger offset = range.location + string.length;
            
            for (NSNumber *location in blankLocation) {
                if (range.location == location.integerValue) {
                    offset ++;
                }
            }
            [self setCursorLocation:textField withOffset:offset];
            return NO;
            
        } else {
            return YES;
        }
        return YES;
}

// 在指定的位置添加空格
+(NSString*)insertString:(NSString*)string withBlankLocations:(NSArray<NSNumber *>*)locations {
    if (!string) {
        return nil;
    }
    NSMutableString* mutableString = [NSMutableString stringWithString:[string stringByReplacingOccurrencesOfString:@" " withString:@""]];
    for (NSNumber *location in locations) {
        if (mutableString.length > location.integerValue) {
            [mutableString insertString:@" " atIndex:location.integerValue];
        }
    }
    return  mutableString;
}

// 去除空格
+(NSString*)removeBlankString:(NSString*)string {
    return [string stringByReplacingOccurrencesOfString:@" " withString:@""];
}

// 设置光标
+ (void)setCursorLocation:(UITextField *)textField withOffset:(NSInteger) offset{
    UITextPosition *newPostion = [textField positionFromPosition:textField.beginningOfDocument offset:offset] ;
    textField.selectedTextRange = [textField textRangeFromPosition:newPostion toPosition:newPostion];
}

@end
