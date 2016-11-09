//
//  BaseTableView.m
//  zitoPayApp
//
//  Created by 李冬冬 on 16/11/4.
//  Copyright © 2016年 zitopay. All rights reserved.
//

#import "BaseTableView.h"
#import "ZITOPayTableViewCell.h"
@implementation BaseTableView
{
    NSInteger _styleIndex;
    NSArray * _dataSource;
    UIButton * _moreButton;//加载更多按钮
    UIActivityIndicatorView * _activityView;
}
- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self _initView];
    }
    return self;
}

- (void)_initView{
    _refreshHeaderView = [[RefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.bounds.size.height, self.frame.size.width, self.bounds.size.height)];
    [_refreshHeaderView setDelegate:self];
    [_refreshHeaderView setBackgroundColor:[UIColor clearColor]];
    [_refreshHeaderView refreshLastUpdatedDate];
    self.dataSource = self;
    self.delegate = self;
    
    self.refreshHeader = YES;//默认开启下拉刷新页面
    
    _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_moreButton setBackgroundColor:[UIColor clearColor]];
    [_moreButton setFrame:CGRectMake(0.0f, 0.0f,SCREENSIZE.width, 40)];
    [_moreButton.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [_moreButton setTitle:@"上拉加载更多..." forState:UIControlStateNormal];
    [_moreButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_moreButton addTarget:self action:@selector(loadMoreAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [_activityView setFrame:CGRectMake(100, 10, 20, 20)];
    [_activityView stopAnimating];
    [_moreButton addSubview:_activityView];
    self.tableFooterView = _moreButton;
}

- (void)setRefreshHeader:(BOOL)refreshHeader
{
    _refreshHeader = refreshHeader;
    if (_refreshHeader) {
        [self addSubview:_refreshHeaderView];
    }else{
        if ([_refreshHeaderView superview]) {
            [_refreshHeaderView removeFromSuperview];
        }
    }
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}
#pragma mark 下拉刷新

- (void)reloadTableViewDataSource{
    
    _reloading = YES;
    
}

- (void)doneLoadingTableViewData{
    
    _reloading = NO;
    [_refreshHeaderView refreshScrollViewDataSourceDidFinishedLoading:self];
    
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods
//当滑动时调用此方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [_refreshHeaderView refreshScrollViewDidScroll:scrollView];
    
}
//手指停止拖拽的时候调用此方法
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [_refreshHeaderView refreshScrollViewDidEndDragging:scrollView];
    
    if (!self.isMore) {
        return;
    }
    //上拉加载更多
    float offset =  scrollView.contentOffset.y;
    float contentHegiht = scrollView.contentSize.height;
    NSLog(@"偏移量 y:%f content内容高度：%f",offset,contentHegiht);
    //当偏移量滑倒底部时，差值是scrolleview的高度
    float sub = contentHegiht - offset;
    float offsetY = scrollView.height - sub;
    if (offsetY > 30) {
        if ([self.baseTableViewDelegate respondsToSelector:@selector(pullUp:)]) {
            [self _startLoadMore];
            [self.baseTableViewDelegate pullUp:self];
            
        }
    }
}


#pragma mark -
#pragma mark RefreshTableHeaderDelegate Methods
//下拉到一定距离开始刷新
- (void)refreshTableHeaderDidTriggerRefresh:(RefreshTableHeaderView *)view{
    
    [self reloadTableViewDataSource];
    //停止加载
    if ([self.baseTableViewDelegate respondsToSelector:@selector(pullDown:)]) {
        [self.baseTableViewDelegate pullDown:self];

    }
    
}

- (BOOL)refreshTableHeaderDataSourceIsLoading:(RefreshTableHeaderView *)view{
    
    return _reloading;
    
}

- (NSDate*)refreshTableHeaderDataSourceLastUpdated:(RefreshTableHeaderView*)view{
    
    return [NSDate date];
    
}

- (void)setUpData:(nonnull NSArray *)data index:(NSInteger)index{
    //根据每一个页面的index区分是哪一个数据源
    _dataSource = data;
//    switch (index) {
//        case 0:
//        {
//            
//        }
//            break;
//            
//        default:
//            break;
//    }
    [self reloadData];
}

- (void)_startLoadMore
{
    [_activityView startAnimating];
    [_moreButton setTitle:@"正在加载..." forState:UIControlStateNormal];
    [_moreButton setEnabled:NO];
}

- (void)_stopLoadMore
{
    if (_dataSource > 0) {
        [_moreButton setHidden:NO];
        [_activityView stopAnimating];
        [_moreButton setTitle:@"上拉加载更多..." forState:UIControlStateNormal];
        [_moreButton setEnabled:YES];
        if (!self.isMore) {
            [_moreButton setTitle:@"加载完成" forState:UIControlStateNormal];
            [_moreButton setEnabled:NO];
        }
    }else{
        [_moreButton setHidden:YES];
    }
    
}
- (void)reloadData
{
    [super reloadData];
    //刷新完毕之后恢复
    [self _stopLoadMore];
}
#pragma mark -actions
- (void)loadMoreAction:(UIButton *)btn
{
    if ([self.baseTableViewDelegate respondsToSelector:@selector(pullUp:)]) {
        [self _startLoadMore];
        [self.baseTableViewDelegate pullUp:self];
        
    }
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataSource count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identify = @"cellIdentify";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        switch (_styleIndex) {
            case 0:
            {
                cell = [[HomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
            }
                break;
            case 1:
            {
                cell = [[MessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
            }
                break;
                
            default:
                break;
        }
        
    }
    
    return cell;
}



#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.baseTableViewDelegate respondsToSelector:@selector(baseTableView:didSelectRowAtIndexPath:)]) {
        [self.baseTableViewDelegate baseTableView:self didSelectRowAtIndexPath:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (_styleIndex) {
        case 0:
        {
            return [HomeTableViewCell cellHeight:[_dataSource objectAtIndex:indexPath.row]];
        }
            break;
            
        default:
            break;
    }
    return 0;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
