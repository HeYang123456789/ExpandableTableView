
//
//  CustomCell.m
//  Objective-CTest
//
//  Created by HEYANG on 15/12/31.
//  Copyright © 2015年 HEYANG. All rights reserved.
//

#import "CustomCell.h"


@interface CustomCell ()



@end

@implementation CustomCell

#pragma mark - Constants 常量 懒加载赋予初始值 字体 颜色大小
-(UIFont *)bigFont{
    if (_bigFont == nil) {
        _bigFont = [UIFont fontWithName:@"Avenir-Book" size:17.0f];
    }
    return _bigFont;
}
-(UIFont *)smallFont{
    if (_smallFont == nil) {
        _smallFont = [UIFont fontWithName:@"Avenir-Light" size:17.0f];
    }
    return _smallFont;
}
-(UIColor *)primaryColor{
    if (_primaryColor == nil) {
        _primaryColor = [UIColor blackColor];
    }
    return _primaryColor;
}
-(UIColor *)secondaryColor{
    if (_secondaryColor == nil) {
        _secondaryColor = [UIColor lightGrayColor];
    }
    return _secondaryColor;
}

#pragma mark - UITableViewCell子类共有的属性，所以在这父类里去实现
-(void)awakeFromNib{
    [super awakeFromNib];
    //如果不为空，也就是有内容就设置默认字体和颜色
    if (self.textLabel != nil) {
        self.textLabel.font = self.bigFont;
        self.textLabel.textColor = self.primaryColor;
    }
    if (self.detailTextLabel != nil) {
        self.detailTextLabel.font = self.smallFont;
        self.detailTextLabel.textColor = self.secondaryColor;
    }
    
}

@end











