//
//  CountButtonView.h
//  zitoPayApp
//
//  Created by 李冬冬 on 16/11/15.
//  Copyright © 2016年 zitopay. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CountButtonView;
@protocol CountButtonViewDelegate <NSObject>

@required
- (void)startCountDown:(CountButtonView *)countBtnView;
- (void)finishCountDown:(CountButtonView *)countBtnView;
@end

@interface CountButtonView : UIView

@property (nonatomic,retain) UIButton * countBtn;
@property (nonatomic,assign) id <CountButtonViewDelegate> delegate;

@end
