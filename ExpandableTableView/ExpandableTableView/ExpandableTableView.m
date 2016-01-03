//
//  ExpandableTableView.m
//  Objective-CTest
//
//  Created by HEYANG on 15/12/31.
//  Copyright © 2015年 HEYANG. All rights reserved.
//

#import "ExpandableTableView.h"
#import "CellModel.h"

#import "DatePickerCell.h"
#import "NormalCell.h"
#import "SliderCell.h"
#import "SwitchCell.h"
#import "TextfieldCell.h"
#import "ValuePickerCell.h"

#import "CellProtocol.h"

@interface ExpandableTableView () <UITableViewDataSource,UITableViewDelegate,CellProtocol>

/** models array */
@property (nonatomic,strong)NSMutableArray *cellModels;

/** visible cell array */
@property (nonatomic,strong)NSMutableArray *visibleCellRows;

/** UITableViewCell */
@property (nonatomic,strong)NSIndexPath *currentIndexPath;

@end

@implementation ExpandableTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor cyanColor];
        self.delegate = self;
        self.dataSource = self;
        [self configureTableView];
        [self getIndicesOfVisibleRows];
    }
    return self;
}

-(void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

//初始化方法 注册价值nib
-(void)configureTableView{
    [self registerNib:[UINib nibWithNibName:@"NormalCell" bundle:nil] forCellReuseIdentifier:@"idCellNormal"];
    [self registerNib:[UINib nibWithNibName:@"TextfieldCell" bundle:nil] forCellReuseIdentifier:@"idCellTextfield"];
    [self registerNib:[UINib nibWithNibName:@"DatePickerCell" bundle:nil] forCellReuseIdentifier:@"idCellDatePicker"];
    [self registerNib:[UINib nibWithNibName:@"SwitchCell" bundle:nil] forCellReuseIdentifier:@"idCellSwitch"];
    [self registerNib:[UINib nibWithNibName:@"ValuePickerCell" bundle:nil] forCellReuseIdentifier:@"idCellValuePicker"];
    [self registerNib:[UINib nibWithNibName:@"SliderCell" bundle:nil] forCellReuseIdentifier:@"idCellSlider"];
}

#pragma mark - 当前显示的cell的row和模型数组中的cell和row的转换，并存储在一个二维数组中
-(void)getIndicesOfVisibleRows{
    [self.visibleCellRows removeAllObjects];
    for (NSArray* sectionArr in self.cellModels) {
        NSMutableArray* tempArr = [NSMutableArray array];
        for (int row = 0; row < sectionArr.count; row++) {
            CellModel* model = (CellModel*)sectionArr[row];
            if (model.isVisible == YES) {
                [tempArr addObject:[NSNumber numberWithInt:row]];
            }
        }
        [self.visibleCellRows addObject:tempArr];
    }
}
//通过当前点击的indexPath，来获取对应
-(CellModel*)getCellModelsRowWithSection:(NSInteger)section row:(NSInteger)row{
    //这里涉及到的格式装换需要整理笔记
//    NSLog(@"%@",indexPath);
    NSArray* array = self.visibleCellRows[section];
//    NSLog(@"%@",array[indexPath.row]);
    NSInteger modelsRow = (int)[array[row] integerValue];
//    NSLog(@"%ld--%d", indexPath.section,modelsRow);
    return self.cellModels[section][modelsRow];
}

#pragma mark - 懒加载，实现字典装模型
-(NSMutableArray *)cellModels{
    if (_cellModels == nil) {
        _cellModels = [NSMutableArray array];
        
        for (NSArray* array in [self loadCellModel]) {
            NSMutableArray* subArray = [NSMutableArray array];
            for (NSDictionary* dic in array) {
                CellModel* model = [[CellModel alloc] initWithDic:dic];
                [subArray addObject:model];
            }
            [_cellModels addObject:subArray];
        }
    }
    return _cellModels;
}
-(NSMutableArray *)visibleCellRows{
    if (_visibleCellRows == nil) {
        _visibleCellRows = [NSMutableArray array];
    }
    return _visibleCellRows;
}
//加载plist文件，并返回字典模型数组
-(NSMutableArray*)loadCellModel{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"CellDescriptor.plist" ofType:nil];
    NSMutableArray* models = [NSMutableArray arrayWithContentsOfFile:filePath];
    return models;
}

#pragma mark - UITableViewDataSource协议方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.visibleCellRows.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray* arr =  self.visibleCellRows[section];
    return arr.count;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"Hello";
}
#pragma mark 设置UITableViewCell的属性
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CellModel* model = [self getCellModelsRowWithSection:indexPath.section row:indexPath.row];
    

    CustomCell* _cell = [tableView dequeueReusableCellWithIdentifier:model.cellIdentifier forIndexPath:indexPath];
    _cell.delegate = self;
    
    
    //想要对应的子类方法和属性，必须要是子类类型才能使用，所以需要强制向子类转型
    if ([model.cellIdentifier isEqualToString:@"idCellNormal"]) {
        NormalCell* cell = (NormalCell*)_cell;
        cell.textLabel.text = model.primaryTitle;
        cell.detailTextLabel.text = model.secondaryTitle;
        return cell;
    }else if ([model.cellIdentifier isEqualToString:@"idCellTextfield"]){
        TextfieldCell* cell = (TextfieldCell*)_cell;
        cell.textfield.placeholder = model.primaryTitle;
        return cell;
    }else if ([model.cellIdentifier isEqualToString:@"idCellDatePicker"]){
        DatePickerCell* cell = (DatePickerCell*)_cell;
        return cell;
    }else if ([model.cellIdentifier isEqualToString:@"idCellSwitch"]){
        SwitchCell* cell = (SwitchCell*)_cell;
        return cell;
    }else if ([model.cellIdentifier isEqualToString:@"idCellValuePicker"]){
        ValuePickerCell* cell = (ValuePickerCell*)_cell;
        cell.textLabel.text = model.primaryTitle;
        return cell;
    }else if ([model.cellIdentifier isEqualToString:@"idCellSlider"]){
        SliderCell* cell = (SliderCell*)_cell;
        cell.cellSlider.value = [model.value floatValue];
        return cell;
    }
    return _cell;
}

#pragma mark - UITableViewDelegate协议方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //首先获取对应在模型数组的cellmodel的行数
    NSInteger rowInModels = [self.visibleCellRows[indexPath.section][indexPath.row] integerValue];
    //接着就是获取当前indexPath对应的cellmodel
    CellModel* model = [self getCellModelsRowWithSection:indexPath.section row:indexPath.row];
    
    if (model.isExpandable == YES) {
        if (model.isExpanded == NO) {
            //当可展开的父cell没有展开的时候
            for (NSInteger i = rowInModels+1; i<=rowInModels+[model.additionalRows integerValue]; i++) {
                CellModel* model = self.cellModels[indexPath.section][i];
                model.isVisible = YES;
            }
            model.isExpanded = YES;
        }else if (model.isExpanded == YES){
            for (NSInteger i = rowInModels+1; i<=rowInModels+[model.additionalRows integerValue]; i++) {
                CellModel* model = self.cellModels[indexPath.section][i];
                model.isVisible = NO;
            }
            model.isExpanded = NO;
        }
    }else{
        //如果是idCellValuePicker的话
        if ([model.cellIdentifier isEqualToString:@"idCellValuePicker"]) {
            NSInteger parentRow = rowInModels - [model.expandedRows integerValue];
            //如果点击了子控件idCellValuePicker，那么父控件是展开状态的
            CellModel* p_model = self.cellModels[indexPath.section][parentRow];
            for (NSInteger i = parentRow+1; i<= parentRow + [p_model.additionalRows integerValue]; i++) {
                CellModel* s_model = self.cellModels[indexPath.section][i];
                s_model.isVisible = NO;
            }
            //别忘了要把当前点击的value的PrimaryTitle赋值给parent
            NSString* str = model.primaryTitle;
            p_model.primaryTitle = str;
            model.isExpanded = NO;
        }
    }
    [self getIndicesOfVisibleRows];
    [self reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]
        withRowAnimation:UITableViewRowAnimationFade];
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CellModel* model = [self getCellModelsRowWithSection:indexPath.section row:indexPath.row];
    if ([model.cellIdentifier isEqualToString:@"idCellNormal"]) {
        return 60;
    }else if ([model.cellIdentifier isEqualToString:@"idCellDatePicker"]){
        return 270;
    }
    return 44;
}


#pragma mark - CellProtocol协议方法
#pragma mark DatePicker的代理 将当前的日期时间显示到parent的cell上
-(void)showDate:(NSString *)dateStr withSelfCell:(UITableViewCell *)selfCell{
    NSIndexPath* childPath = [self indexPathForCell:selfCell];
    CellModel *childCellModel = [self getCellModelsRowWithSection:childPath.section row:childPath.row];
    CellModel *parentCellModel = [self getCellModelsRowWithSection:childPath.section row:(childPath.row - [childCellModel.expandedRows integerValue])];
    parentCellModel.primaryTitle = dateStr;
    [self reloadData];
}

#pragma mark slider的代理
-(void)showValue:(NSInteger)value withSelfCell:(UITableViewCell *)selfCell{
    
    NSIndexPath* childPath;
    if (self.currentIndexPath == nil) {
        childPath = [self indexPathForCell:selfCell];
        //如果引用存储的indexPath和之前的不一样，就赋予当前indexPath
        if (self.currentIndexPath != childPath) {
            self.currentIndexPath = childPath;
        }
    }
    //获取当前的点击的cell的位置 section -- row
    NSInteger currentSection = self.currentIndexPath.section;
    NSInteger currentRow = self.currentIndexPath.row;
    //获取当前点击的cell对应的cellModel
    CellModel *childCellModel = [self getCellModelsRowWithSection:currentSection row:currentRow];
    
    //获取对应父cell的位置
    NSInteger parSection = currentSection;
    NSInteger parRow = currentRow - [childCellModel.expandedRows integerValue];
    //获取对应父cell的cellModel
    CellModel *parentCellModel = [self getCellModelsRowWithSection:parSection row:parRow];
    
    NSString* strValue = [NSString stringWithFormat:@"%ld",value];
    childCellModel.value = strValue;
    parentCellModel.primaryTitle = strValue;
    [self reloadData];
}


#pragma mark textfield delegate

-(void)showString:(NSString*)string withSelfCell:(UITableViewCell *)selfCell{
    
    //1、获取当前cell的在模型数组中的位置
    NSIndexPath* currentIndexPath = [self indexPathForCell:selfCell];
    NSInteger currentSection = currentIndexPath.section;
    NSInteger currentRow = currentIndexPath.row;
    //2、获取当前cell对应的cellModel
    CellModel *childCellModel = [self getCellModelsRowWithSection:currentSection row:currentRow];
    
    //3、获取对应父cell的位置
    NSInteger parSection = currentSection;
    NSInteger parRow = currentRow - [childCellModel.expandedRows integerValue];
    
    //4、获取其父控件的模型
    CellModel* parentCellModel = [self getCellModelsRowWithSection:parSection row:parRow];
    
    //5、获取所有子cell的textfield的文本，并按顺序排列拼接
    //NSString* currentfullString = parentCellModel.primaryTitle;

    //6、从父cell当前显示的位置开始向下遍历获取子cell上的textfield.text
    NSString* newFullName = @"";
    NSInteger hasChildNum = [parentCellModel.additionalRows integerValue];
    for (NSInteger i = parRow+1; i <= parRow+hasChildNum; i++) {
        NSIndexPath* childCellIndex = [NSIndexPath indexPathForRow:i inSection:parSection];
        TextfieldCell* childCell = [self cellForRowAtIndexPath:childCellIndex];
        NSString* currentStr = childCell.textfield.text;
        newFullName = [newFullName stringByAppendingFormat:@"%@ ",currentStr];
    }
    
    //7、最后赋值回到
    parentCellModel.primaryTitle = newFullName;
    [self reloadData];
}
#pragma mark switch delegate
-(void)showValueWithSwitchState:(BOOL)isOn withSelfCell:(UITableViewCell *)selfCell{
    
    //1、获取当前cell的在模型数组中的位置
    NSIndexPath* currentIndexPath = [self indexPathForCell:selfCell];
    NSInteger currentSection = currentIndexPath.section;
    NSInteger currentRow = currentIndexPath.row;
    //2、获取当前cell对应的cellModel
    CellModel *childCellModel = [self getCellModelsRowWithSection:currentSection row:currentRow];
    //3、获取对应父cell的位置
    NSInteger parSection = currentSection;
    NSInteger parRow = currentRow - [childCellModel.expandedRows integerValue];
    
    //4、获取其父控件的模型
    CellModel* parentCellModel = [self getCellModelsRowWithSection:parSection row:parRow];
    
    //对应模型中的数据也要改改
    childCellModel.value = isOn? @"YES":@"NO";
    parentCellModel.primaryTitle = isOn? @"TRUE":@"NO";
    [self reloadData];
}

@end
