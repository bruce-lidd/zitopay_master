//
//  RefreshTableHeaderView.h
//  zitoPayApp
//
//  Created by 李冬冬 on 16/11/4.
//  Copyright © 2016年 zitopay. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    PullRefreshPulling = 0,
    PullRefreshNormal,
    PullRefreshLoading,
} PullRefreshState;

@protocol RefreshTableHeaderDelegate;
@interface RefreshTableHeaderView : UIView {
    
    __unsafe_unretained id _delegate;
    PullRefreshState _state;
    
    UILabel *_lastUpdatedLabel;
    UILabel *_statusLabel;
    CALayer *_arrowImage;
    UIActivityIndicatorView *_activityView;
    
    
}

@property(nonatomic,assign) id <RefreshTableHeaderDelegate> delegate;

- (void)refreshLastUpdatedDate;
- (void)refreshScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)refreshScrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void)refreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;

@end
@protocol RefreshTableHeaderDelegate
- (void)refreshTableHeaderDidTriggerRefresh:(RefreshTableHeaderView*)view;
- (BOOL)refreshTableHeaderDataSourceIsLoading:(RefreshTableHeaderView*)view;
@optional
- (NSDate*)refreshTableHeaderDataSourceLastUpdated:(RefreshTableHeaderView*)view;
@end

