//
//  BaseViewController.h
//  zitoPayApp
//
//  Created by 李冬冬 on 16/11/3.
//  Copyright © 2016年 zitopay. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppDelegate;
@protocol BaseViewControllerDelegate <NSObject>

@optional

- (void)refreshNewWorkData;

@end
@interface BaseViewController : UIViewController

@property (nonatomic,assign) id <BaseViewControllerDelegate> delegate;
- (AppDelegate *)appDelegate;

- (void)viewWithNewWorkFail;
- (void)removeRefreshNewWorkView;
@end
