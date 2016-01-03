//
//  CellProtocol.h
//  Objective-CTest
//
//  Created by HEYANG on 16/1/1.
//  Copyright © 2016年 HEYANG. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CellProtocol <NSObject>

@required


//the protocol function from DatePickerCell
-(void)showDate:(NSString*)dateStr withSelfCell:(UITableViewCell*)selfCell;

//the protocol function from SliderCell
-(void)showValue:(NSInteger)value withSelfCell:(UITableViewCell*)selfCell;

//the protocol function from TextfieldCell
-(void)showString:(NSString*)string withSelfCell:(UITableViewCell*)selfCell;

//the protocol function from TextfieldCell
-(void)showValueWithSwitchState:(BOOL)isOn withSelfCell:(UITableViewCell*)selfCell;



@end
