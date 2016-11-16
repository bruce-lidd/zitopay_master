//
//  LayerView.m
//  zitoPayApp
//
//  Created by 李冬冬 on 16/11/15.
//  Copyright © 2016年 zitopay. All rights reserved.
//

#import "LayerView.h"

@implementation LayerView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [self addSubview:self.titleLbl];
    [self circleBezierPath];
    //用定时器模拟数值输入的情况
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1f
                                              target:self
                                            selector:@selector(circleAnimationTypeOne)
                                            userInfo:nil
                                             repeats:YES];
    
}

-(void)circleBezierPath
{
    
    //创建背景
    _BGShapeLayer = [CAShapeLayer layer];   //创建出CAShapeLayer
    _BGShapeLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    _BGShapeLayer.fillColor = [[UIColor clearColor] CGColor];  //设置填充颜色
    _BGShapeLayer.strokeColor = [UIColor grayColor].CGColor;
    _BGShapeLayer.lineWidth = 15.0f;   //设置线条的宽度和颜色
    _BGShapeLayer.strokeStart = 0;    //起始位置
    _BGShapeLayer.strokeEnd = 1;     //终点
    
    
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;
    self.shapeLayer.lineWidth = 15.0f;
    self.shapeLayer.strokeColor = [UIColor redColor].CGColor;
    self.shapeLayer.strokeStart = 0.0f;
    self.shapeLayer.strokeEnd = 0.0f;
    
    
    //创建出圆形贝塞尔曲线
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    
    _BGShapeLayer.path = circlePath.CGPath;    //让贝塞尔曲线与CAShapeLayer产生联系
    self.shapeLayer.path = circlePath.CGPath;
    
    [self.layer addSublayer:_BGShapeLayer];  //添加并显示
    [self.layer addSublayer:self.shapeLayer];
    
}

- (void)circleAnimationTypeOne
{
    if (self.shapeLayer.strokeEnd < 1.0f) {
        self.shapeLayer.strokeEnd += 0.05;
        CGFloat title = self.shapeLayer.strokeEnd*100;
        _titleLbl.text = [NSString stringWithFormat:@"%.1f%%",title];
    }else{
        [_timer invalidate];
        _timer=nil;
    }
}

-(UILabel *)titleLbl
{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.frame)-100)/2.0, (CGRectGetHeight(self.frame)-60)/2.0, 100, 60)];  //位置根据View大小设定  View bounds为 100 100;
        _titleLbl.textAlignment = NSTextAlignmentCenter;
        _titleLbl.font = [UIFont systemFontOfSize:20];
        _titleLbl.textColor = [UIColor redColor];
        [_titleLbl setBackgroundColor:[UIColor clearColor]];
    }
   
    return _titleLbl;
    
}


@end
