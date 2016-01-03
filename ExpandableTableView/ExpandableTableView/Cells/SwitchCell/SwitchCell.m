//
//  SwitchCell.m
//  Objective-CTest
//
//  Created by HEYANG on 16/1/1.
//  Copyright © 2016年 HEYANG. All rights reserved.
//

#import "SwitchCell.h"

@interface SwitchCell ()

@property (weak, nonatomic) IBOutlet UILabel *switchLabel;

@end

@implementation SwitchCell


-(void)awakeFromNib{
    [super awakeFromNib];
    self.switchLabel.font = self.bigFont;
}
- (IBAction)cellSwitch:(id)sender {
    UISwitch* _switch = (UISwitch*)sender;
    if ([self.delegate respondsToSelector:@selector(showValueWithSwitchState:withSelfCell:)]) {
        [self.delegate showValueWithSwitchState:_switch.isOn withSelfCell:self];
    }
}

@end
