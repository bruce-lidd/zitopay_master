//
//  ZitoTimer.m
//  zitoPayApp
//
//  Created by 李冬冬 on 16/11/16.
//  Copyright © 2016年 zitopay. All rights reserved.
//

#import "ZitoTimer.h"

 dispatch_source_t myTimer ;
 id myTarget ;

@implementation ZitoTimer

+ (void)timerWithTimeInterval:(NSTimeInterval)ti target:(nullable id)aTarget selector:(nullable SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo
{
    myTarget = aTarget;
    //获得队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    //创建一个定时器
    myTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //设置定时器的各种属性（几时开始任务，每隔多长时间执行一次）、GCD的时间参数，一般是纳秒（1秒＝＝10的9次方纳秒）、何时开始执行第一个任务
    dispatch_time_t  start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0*NSEC_PER_SEC));
    
    uint64_t interval = (uint64_t)(ti*NSEC_PER_SEC);
    
    dispatch_source_set_timer(myTimer, start, interval, 0);
    
    dispatch_source_set_event_handler(myTimer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!yesOrNo) {
                static dispatch_once_t onceToken;
                dispatch_once(&onceToken, ^{
                    [aTarget performSelector:aSelector withObject:userInfo afterDelay:0.0];
                });
            }else{
                [aTarget performSelector:aSelector withObject:userInfo afterDelay:0.0];
            }
            
        });
        
    });
    
    dispatch_resume(myTimer);
}
+ (void)startTimer
{
    dispatch_resume(myTimer);
}
+ (void)stopTimer
{
    dispatch_cancel(myTimer);
}
- (void)dealloc
{
    [NSObject cancelPreviousPerformRequestsWithTarget:myTarget];
}
@end
