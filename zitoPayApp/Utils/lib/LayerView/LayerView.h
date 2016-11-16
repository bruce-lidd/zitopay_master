//
//  LayerView.h
//  zitoPayApp
//
//  Created by 李冬冬 on 16/11/15.
//  Copyright © 2016年 zitopay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LayerView : UIView

@property (nonatomic,retain) CAShapeLayer * shapeLayer;
@property (nonatomic,retain) CAShapeLayer * BGShapeLayer;
@property (nonatomic,retain) NSTimer * timer;
@property (nonatomic,retain) UILabel * titleLbl;

@end
