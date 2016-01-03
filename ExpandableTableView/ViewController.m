//
//  ViewController.m
//  ExpandableTableView
//
//  Created by HEYANG on 16/1/3.
//  Copyright © 2016年 HEYANG. All rights reserved.
//

#import "ViewController.h"

#import "ExpandableTableView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1、创建ExpandableTableView
    ExpandableTableView* extb = [[ExpandableTableView alloc] initWithFrame:self.view.frame];
    //2、设置origin，主要是考虑在有状态栏的情况，就让他下移20
    extb.origin = CGPointMake(0, 20);
    //3、添加到父控件
    [self.view addSubview:extb];
    
}

@end
