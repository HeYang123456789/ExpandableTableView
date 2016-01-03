//
//  CellModel.h
//  Objective-CTest
//
//  Created by HEYANG on 15/12/30.
//  Copyright © 2015年 HEYANG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CellModel : NSObject
/*
 additionalRows = 2;
 cellIdentifier = idCellNormal;
 isExpandable = 1;
 isExpanded = 0;
 isVisible = 1;
 primaryTitle = "";
 secondaryTitle = Fullname;
 value = "";
 */
/** additionalRows = 2 */
@property (nonatomic,strong)NSNumber *additionalRows;
/** cellIdentifier */
@property (nonatomic,strong)NSString *cellIdentifier;
/** isExpandable */
@property (nonatomic,assign)BOOL isExpandable;
/** isExpanded */
@property (nonatomic,assign)BOOL isExpanded;
/** isVisible */
@property (nonatomic,assign)BOOL isVisible;
/** primaryTitle */
@property (nonatomic,strong)NSString *primaryTitle;
/** secondaryTitle */
@property (nonatomic,strong)NSString *secondaryTitle;
/** value */
@property (nonatomic,strong)NSString *value;
/** ExpandedRows */
@property (nonatomic,strong)NSNumber *expandedRows;

/*参数为字典对象的初始化方法*/
- (instancetype)initWithDic:(NSDictionary*)dic;


@end
