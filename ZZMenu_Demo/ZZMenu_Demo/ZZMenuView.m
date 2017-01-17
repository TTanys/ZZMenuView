//
//  ZZMenuView.m
//  ZZMenu_Demo
//
//  Created by zhajianjun on 2017/1/17.
//  Copyright © 2017年 TTanys. All rights reserved.
//

#import "ZZMenuView.h"
#import "UIView+frame.h"

static NSString *ZZ_MENU_CELL_IDENT = @"ZZ_MENU_CELL_IDENT";

@interface ZZMenuView ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger _selectRow;
    NSInteger _selectItem;
    NSInteger _selectRank;
}

@end

@implementation ZZMenuView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
        [self configSubViews];
    }
    return self;
}

- (void)initialize{
    _selectRow = ZZNotFound;
    _selectItem = ZZNotFound;
    _selectRank = ZZNotFound;
}

- (void)configSubViews{
    [self addSubview:self.tableView_0];
    [self addSubview:self.tableView_1];
    [self addSubview:self.tableView_2];
}

- (UITableView *)tableView_0{
    if (!_tableView_0) {
        _tableView_0 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height) style:UITableViewStylePlain];
        [_tableView_0 registerClass:[UITableViewCell class] forCellReuseIdentifier:ZZ_MENU_CELL_IDENT];
        _tableView_0.delegate = self;
        _tableView_0.dataSource = self;
        _tableView_0.tableFooterView = [[UIView alloc] init];
    }
    return _tableView_0;
}

- (UITableView *)tableView_1{
    if (!_tableView_1) {
        _tableView_1 = [[UITableView alloc] initWithFrame:CGRectMake(self.width, 0, self.width, self.height) style:UITableViewStylePlain];
        _tableView_1.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
        [_tableView_1 registerClass:[UITableViewCell class] forCellReuseIdentifier:ZZ_MENU_CELL_IDENT];
        _tableView_1.delegate = self;
        _tableView_1.dataSource = self;
        _tableView_1.tableFooterView = [[UIView alloc] init];
    }
    return _tableView_1;
}

- (UITableView *)tableView_2{
    if (!_tableView_2) {
        _tableView_2 = [[UITableView alloc] initWithFrame:CGRectMake(self.width, 0, self.width, self.height) style:UITableViewStylePlain];
        _tableView_2.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0];
        [_tableView_2 registerClass:[UITableViewCell class] forCellReuseIdentifier:ZZ_MENU_CELL_IDENT];
        _tableView_2.delegate = self;
        _tableView_2.dataSource = self;
        _tableView_2.tableFooterView = [[UIView alloc] init];
    }
    return _tableView_2;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    ZZIndexPath *zzIndexPath = [self getIndexPathForNumberOfRowsWithTableView:tableView];
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(menuView:numberOfRowsWithIndexPath:)]) {
        return [self.dataSource menuView:self numberOfRowsWithIndexPath:zzIndexPath];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZZIndexPath *zzIndexPath = [self getIndexPathForCellWithTableView:tableView indexPath:indexPath];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ZZ_MENU_CELL_IDENT];
    cell.selectedBackgroundView = [[UIView alloc] init];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0];
    cell.textLabel.textColor = [UIColor colorWithWhite:0.004 alpha:1.000];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.highlightedTextColor = [UIColor blackColor];
    cell.separatorInset = UIEdgeInsetsZero;
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(menuView:titleOfRowWithIndexPath:)]) {
        cell.textLabel.text = [self.dataSource menuView:self titleOfRowWithIndexPath:zzIndexPath];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableView_0) {
        _selectRow = indexPath.row;
        _selectItem = ZZNotFound;
        _selectRank = ZZNotFound;
        [self.tableView_1 reloadData];
        [self.tableView_2 reloadData];
    }
    if (tableView == self.tableView_1) {
        _selectItem = indexPath.row;
        _selectRank = ZZNotFound;
        [self.tableView_2 reloadData];
    }
    
    ZZIndexPath *zzIndexPath = [self getIndexPathForCellWithTableView:tableView indexPath:indexPath];
    if (self.delegate && [self.delegate respondsToSelector:@selector(menuView:didSelectWithIndexPath:)]) {
        [self.delegate menuView:self didSelectWithIndexPath:zzIndexPath];
    }
}

- (ZZIndexPath *)getIndexPathForNumberOfRowsWithTableView:(UITableView *)tableView{
    if (tableView == self.tableView_0) {
        return [ZZIndexPath indexPathWithRow:ZZNotFound item:ZZNotFound rank:ZZNotFound];
    }
    if (tableView == self.tableView_1 && _selectRow != ZZNotFound) {
        return [ZZIndexPath indexPathWithRow:_selectRow item:ZZNotFound rank:ZZNotFound];
    }
    if (tableView == self.tableView_2 && _selectRow != ZZNotFound && _selectItem != ZZNotFound) {
        return [ZZIndexPath indexPathWithRow:_selectRow item:_selectItem rank:ZZNotFound];
    }
    return 0;
}

- (ZZIndexPath *)getIndexPathForCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableView_0) {
        return [ZZIndexPath indexPathWithRow:indexPath.row item:ZZNotFound rank:ZZNotFound];
    }
    if (tableView == self.tableView_1) {
        return [ZZIndexPath indexPathWithRow:_selectRow item:indexPath.row rank:ZZNotFound];
    }
    if (tableView == self.tableView_2) {
        return [ZZIndexPath indexPathWithRow:_selectRow item:_selectItem rank:indexPath.row];
    }
    return [ZZIndexPath indexPathWithRow:indexPath.row item:ZZNotFound rank:ZZNotFound];
}

@end


@implementation ZZIndexPath

+ (instancetype)indexPathWithRow:(NSInteger)row item:(NSInteger)item rank:(NSInteger)rank{
    return [[self alloc] initWithRow:row item:item rank:rank];
}

- (instancetype)initWithRow:(NSInteger)row item:(NSInteger)item rank:(NSInteger)rank{
    self = [super init];
    if (self) {
        self.row = row;
        self.item = item;
        self.rank = rank;
    }
    return self;
}

@end
