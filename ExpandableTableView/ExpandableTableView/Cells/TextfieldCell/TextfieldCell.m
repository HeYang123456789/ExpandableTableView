//
//  TextfieldCell.m
//  Objective-CTest
//
//  Created by HEYANG on 16/1/1.
//  Copyright © 2016年 HEYANG. All rights reserved.
//

#import "TextfieldCell.h"

@interface TextfieldCell () <UITextFieldDelegate>



@end

@implementation TextfieldCell

-(void)awakeFromNib{
    [super awakeFromNib];
    
    if (self.textfield != nil) {
        self.textfield.font = self.bigFont;
        //这个属性必须在父类的.h文件中写出，否则访问不到
        self.textfield.delegate = self;
        //要用textfield的代理是为了使用代理协议的一个return会触发的方法
    }
}

#pragma mark - textfield.delegate协议的方法
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(showString:withSelfCell:)]) {
        [self.delegate showString:self.textfield.text withSelfCell:self];
    }
    return true;
}



@end
