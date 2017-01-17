//
//  ZZMenuView.h
//  ZZMenu_Demo
//
//  Created by zhajianjun on 2017/1/17.
//  Copyright © 2017年 TTanys. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ZZNotFound (-1)

@class ZZMenuView,ZZIndexPath;

@protocol ZZMenuViewDelegate <NSObject>

- (void)menuView:(ZZMenuView *)menuView didSelectWithIndexPath:(ZZIndexPath *)indexPath;

@end

@protocol ZZMenuViewDataSource <NSObject>

- (NSInteger)menuView:(ZZMenuView *)menuView numberOfRowsWithIndexPath:(ZZIndexPath *)indexPath;

- (NSString *)menuView:(ZZMenuView *)menuView titleOfRowWithIndexPath:(ZZIndexPath *)indexPath;

@end

@interface ZZMenuView : UIView

@property (nonatomic, strong) UITableView *tableView_0;
@property (nonatomic, strong) UITableView *tableView_1;
@property (nonatomic, strong) UITableView *tableView_2;

@property (nonatomic, weak) id<ZZMenuViewDelegate> delegate;
@property (nonatomic, weak) id<ZZMenuViewDataSource> dataSource;

@end


@interface ZZIndexPath : NSObject

@property (nonatomic, assign) NSInteger row;  //第一级的行
@property (nonatomic, assign) NSInteger item; //第二级的行
@property (nonatomic, assign) NSInteger rank; //第三级的行

+ (instancetype)indexPathWithRow:(NSInteger)row
                            item:(NSInteger)item
                            rank:(NSInteger)rank;

@end
