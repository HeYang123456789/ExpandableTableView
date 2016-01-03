//
//  SliderCell.m
//  Objective-CTest
//
//  Created by HEYANG on 16/1/1.
//  Copyright © 2016年 HEYANG. All rights reserved.
//

#import "SliderCell.h"

@interface SliderCell ()

@end

@implementation SliderCell

-(void)awakeFromNib{
    [super awakeFromNib];
    self.cellSlider.minimumValue = 0.0;
    self.cellSlider.maximumValue = 10.0;
    self.cellSlider.value = 0.0;
}

- (IBAction)slider:(id)sender {
    UISlider* slider = (UISlider*)sender;
    self.cellSlider.value = slider.value;
    if ([self.delegate respondsToSelector:@selector(showValue:withSelfCell:)]) {
        [self.delegate showValue:slider.value withSelfCell:self];
    }
}



@end
