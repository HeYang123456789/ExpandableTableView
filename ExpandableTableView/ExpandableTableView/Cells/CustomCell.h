//
//  CustomCell.h
//  Objective-CTest
//
//  Created by HEYANG on 15/12/31.
//  Copyright © 2015年 HEYANG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellProtocol.h"

@interface CustomCell : UITableViewCell

/** delegate */
@property (nonatomic,strong)id<CellProtocol> delegate;

#pragma mark - Constants 常量 设置相关的常量
#pragma mark 这些常量的初始值 在后面用懒加载进行处理赋予初始值
/** bigFont */
@property (nonatomic,strong)UIFont *bigFont;
/** smallFont */
@property (nonatomic,strong)UIFont *smallFont;
/** primaryColor */
@property (nonatomic,strong)UIColor *primaryColor;
/** secondaryColor */
@property (nonatomic,strong)UIColor *secondaryColor;

@end
