//
//  DatePickerCell.m
//  Objective-CTest
//
//  Created by HEYANG on 16/1/1.
//  Copyright © 2016年 HEYANG. All rights reserved.
//

#import "DatePickerCell.h"

@interface DatePickerCell ()

@property (weak, nonatomic) IBOutlet UIDatePicker *exDatePicker;

@end

@implementation DatePickerCell



//点击这个set按钮，将UIDatePicker当前的日期数据进行格式化处理，并发送到需要的地方
- (IBAction)setButton:(id)sender {
    NSLog(@"%@",self.exDatePicker.date);
    //需要对date进行格式化转为NSString
    //1、创建日期格式器
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    //2、设置日期格式器的样式
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    //3、获取最终的日期样式
    NSString* dateStr = [dateFormatter stringFromDate:self.exDatePicker.date];
    NSLog(@"dateStr:%@",dateStr);
    
    if ([self.delegate respondsToSelector:@selector(showDate:withSelfCell:)]) {
        [self.delegate showDate:dateStr withSelfCell:self];
    }
}

@end
