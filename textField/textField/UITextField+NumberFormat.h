//
//  UITextField+NumberFormat.h
//  textField
//
//  Created by JiWuChao on 2017/11/21.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (NumberFormat)
/**
 textField中输入的空格格式化

 @param textField <#textField description#>
 @param range <#range description#>
 @param string <#string description#>
 @param blankLocation 要加的空格的位置 比如手机号11 位 如果需要 344的显示格式 空格位置就是 @[@4,@9]
                      身份证号最大 18位 684格式 空格位置 位@[@6,@15]
                      银行卡号最大 24 空格位置 @[@4,@9,@14,@19,@24] 不同的账号显示格式可以自定义
 @param limitCount 限制的长度 超过此限制长度 则不能输入 如果输入的为0 则不显示输入的长度
 @return textField中输入的身份证号 ，手机号，银行卡号 有需要在中间加入空格的需求 此扩展就是为了解决这类问题的
 
 */
+ (BOOL)inputTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
     replacementString:(NSString *)string
        blankLocations:(NSArray <NSNumber *>*)blankLocation
            limitCount:(NSInteger )limitCount;

@end
