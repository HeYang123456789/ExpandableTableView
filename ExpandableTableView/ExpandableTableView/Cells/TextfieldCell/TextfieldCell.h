//
//  TextfieldCell.h
//  Objective-CTest
//
//  Created by HEYANG on 16/1/1.
//  Copyright © 2016年 HEYANG. All rights reserved.
//

#import "CustomCell.h"

@interface TextfieldCell : CustomCell

//写在这里是为了ExpandableTableView能对textfield.placeholder赋值
@property (weak, nonatomic) IBOutlet UITextField *textfield;

@end
