//
//  BaseTableView.h
//  zitoPayApp
//
//  Created by 李冬冬 on 16/11/4.
//  Copyright © 2016年 zitopay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshTableHeaderView.h"
@class BaseTableView;
@protocol BaseTableViewDelegate <NSObject>

@optional
//下拉
- (void)pullDown:(nonnull BaseTableView *)tableView;
//上拉
- (void)pullUp:(nonnull BaseTableView *)tableView;

//cell点击事件
- (void)baseTableView:(nonnull BaseTableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath;

@end

@interface BaseTableView : UITableView<RefreshTableHeaderDelegate,UITableViewDelegate,UITableViewDataSource>
{
    RefreshTableHeaderView * _refreshHeaderView;
    BOOL _reloading;
}
@property (nonatomic,assign)BOOL refreshHeader;//是否需要下拉

@property (nonatomic,assign)BOOL isMore;//是否还有下一页
@property (nonnull,nonatomic,assign) id <BaseTableViewDelegate> baseTableViewDelegate;

- (void)doneLoadingTableViewData;//刷新数据结束
/*
 *param data NSArray
 *param index NSInteger
 */
- (void)setUpData:(nonnull NSArray *)data index:(NSInteger)index;
@end
