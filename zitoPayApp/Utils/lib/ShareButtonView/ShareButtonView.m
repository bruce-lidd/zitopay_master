//
//  ShareButtonView.m
//  zitoPayApp
//
//  Created by 李冬冬 on 16/11/7.
//  Copyright © 2016年 zitopay. All rights reserved.
//

#define SHAREVIEWHEIGHT 180
#import "ShareButtonView.h"

@implementation ShareButtonView
{
    UIView * _btnView;
    UIView * _blankView;
}
- (id)init
{
    self = [super init];
    if (self) {
        [self setFrame:CGRectMake(0.0f, 0.0f, SCREENSIZE.width, SCREENSIZE.height)];
        [self setBackgroundColor:[UIColor clearColor]];
        
        _blankView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENSIZE.width, SCREENSIZE.height-SHAREVIEWHEIGHT)];
        [_blankView setBackgroundColor:[UIColor clearColor]];
        
        UITapGestureRecognizer * tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenBtnView:)];
        [_blankView addGestureRecognizer:tapGes];
        
        [self addSubview:_blankView];
        
        _btnView =  [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_blankView.frame), SCREENSIZE.width,SHAREVIEWHEIGHT)];
        [_btnView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:_btnView];
        
        [self showBtn];
    }
    return self;
}
- (void)hiddenBtnView:(UITapGestureRecognizer *)ges
{
    if ([self superview]) {
        
        [UIView animateWithDuration:0.1f animations:^{
            _btnView.top = SCREENSIZE.height;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
        
    }
}
- (void)showView
{
    [UIView animateWithDuration:0.5f animations:^{
        _btnView.top = CGRectGetMaxY(_blankView.frame);
    } completion:^(BOOL finished) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:self];
    }];
    
}
- (void)showBtn
{
    NSString *path=[[NSBundle mainBundle] pathForResource:@"shareData" ofType:@"plist"];
    NSDictionary *root=[NSDictionary dictionaryWithContentsOfFile:path];
    NSArray *menus=[root objectForKey:@"sharemenus"];
    
    int rowcount=ceil(menus.count/4.0);
    float w=floor(SCREENSIZE.width/4.0);
    CGFloat paddingTop = 20;
    for (int i=0; i<rowcount; i++) {
        
        for (int j=0; j<4; j++) {
            int index=i*4+j;
            if (index>menus.count-1) {
                break;
            }
            NSDictionary *item=[menus objectAtIndex:index];
            float x=j*w;
            float y=i*80+paddingTop;
            UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(x,y, w, 80)];
            [btn setTag:index];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            UIImageView *imageview=[[UIImageView alloc] initWithFrame:CGRectMake((btn.frame.size.width-49)/2.0, (btn.frame.size.height-79)/2.0, 49, 49)];
            [imageview setImage:[UIImage imageNamed:[item objectForKey:@"image"]]];
            [btn addSubview:imageview];
            
            UILabel *lbl=[[UILabel alloc] initWithFrame:CGRectMake(0, imageview.frame.size.height+imageview.frame.origin.y+5, btn.frame.size.width, 20)];
            [lbl setBackgroundColor:[UIColor clearColor]];
            [lbl setFont:[UIFont systemFontOfSize:15]];
            [lbl setTextAlignment:NSTextAlignmentCenter];
            [lbl setTextColor:RGB(118, 118, 118)];
            [lbl setText:[item objectForKey:@"title"]];
            [btn addSubview:lbl];
            
            [_btnView addSubview:btn];
        }
    }
    
}
- (void)btnClick:(UIButton *)btn
{
    NSLog(@"%ld",(long)btn.tag);
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickItem:index:)]) {
        [self.delegate clickItem:self index:btn.tag];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
