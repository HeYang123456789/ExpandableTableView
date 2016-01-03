//
//  CellModel.m
//  Objective-CTest
//
//  Created by HEYANG on 15/12/30.
//  Copyright © 2015年 HEYANG. All rights reserved.
//

#import "CellModel.h"

@implementation CellModel

- (instancetype)initWithDic:(NSDictionary*)dic
{
    CellModel* model = [[CellModel alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}



@end
