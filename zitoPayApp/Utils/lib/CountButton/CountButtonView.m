//
//  CountButtonView.m
//  zitoPayApp
//
//  Created by 李冬冬 on 16/11/15.
//  Copyright © 2016年 zitopay. All rights reserved.
//

#import "CountButtonView.h"

@implementation CountButtonView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.countBtn];
    }
    return self;
}

- (UIButton *)countBtn
{
    if (!_countBtn) {
        _countBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_countBtn setFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        [_countBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_countBtn setTitleColor:COLOR_WITH_HEX(0xe4e1e2) forState:UIControlStateNormal];
        [_countBtn.titleLabel setFont:[UIFont systemFontOfSize:20]];
        [_countBtn addTarget:self action:@selector(countDown:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _countBtn;
}
- (void)countDown:(UIButton *)btn
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(startCountDown:)]) {
        [self.delegate startCountDown:self];
    }
    
    __block NSInteger time = 5; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(finishCountDown:)]) {
                    [self.delegate finishCountDown:self];
                }
                
                //设置按钮的样式
                [self.countBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                [self.countBtn setTitleColor:COLOR_WITH_HEX(0xe4e5e5) forState:UIControlStateNormal];
                self.countBtn.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [self.countBtn setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
                [self.countBtn setTitleColor:COLOR_WITH_HEX(0xe4e1e2) forState:UIControlStateNormal];
                self.countBtn.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}
- (void)dealloc
{
    _countBtn = nil;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
