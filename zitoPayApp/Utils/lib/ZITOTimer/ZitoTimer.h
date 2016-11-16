//
//  ZitoTimer.h
//  zitoPayApp
//
//  Created by 李冬冬 on 16/11/16.
//  Copyright © 2016年 zitopay. All rights reserved.
//


#import <Foundation/Foundation.h>

extern dispatch_source_t myTimer ;
extern id myTarget ;

@interface ZitoTimer : NSObject
+ (void)timerWithTimeInterval:(NSTimeInterval)ti target:(nullable id)aTarget selector:(nullable SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo;
+ (void)startTimer;
+ (void)stopTimer;
@end
