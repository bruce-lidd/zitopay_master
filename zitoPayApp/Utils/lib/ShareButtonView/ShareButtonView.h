//
//  ShareButtonView.h
//  zitoPayApp
//
//  Created by 李冬冬 on 16/11/7.
//  Copyright © 2016年 zitopay. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    MESSAGECHANNEL = 0,
    SINACHANNEL,
    WXCHANNEL,
    QZCHANNEL,
    QQCHANNEL,
    
}ShareButtonViewChannel;

@class ShareButtonView;

@protocol ShareButtonViewDelegate <NSObject>
@required
- (void)clickItem:(ShareButtonView *)shareBtnView index:(NSInteger)index;
@end

@interface ShareButtonView : UIView

@property (nonatomic,assign) id <ShareButtonViewDelegate> delegate;
- (void)showView;

@end
