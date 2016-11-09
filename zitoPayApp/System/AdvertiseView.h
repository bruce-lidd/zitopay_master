//
//  AdvertiseView.h
//  zitoPayApp
//
//  Created by 李冬冬 on 16/11/4.
//  Copyright © 2016年 zitopay. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const adImageName = @"adImageName";
static NSString * const adUrl = @"adUrl";

@interface AdvertiseView : UIView
/*
 *图片路径
 */
@property (nonatomic,retain) NSString * filePath;

/*
 *显示广告页面方法
 */
- (void)showAdView;


@end
