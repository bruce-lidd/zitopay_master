//
//  MainViewController.m
//  zitoPayApp
//
//  Created by 李冬冬 on 16/11/3.
//  Copyright © 2016年 zitopay. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "CenterViewController.h"
#import "DisCoverViewController.h"
#import "ProfileViewController.h"
#import "BaseNavigationViewController.h"

#define TABBARHEIGHT 49
@interface MainViewController ()<UINavigationControllerDelegate>
@property (nonatomic,retain)NSMutableArray * btnArr;
@property (nonatomic,retain)NSMutableArray * lblArr;
@end

@implementation MainViewController
{
    UIView * _tabbarView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tabBar setHidden:YES];//隐藏系统tabbar
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self _initTabbarView];
    [self _initViewController];
}
//初始化子控制器 private
- (void)_initViewController{
    //
    HomeViewController * homeVC = [[HomeViewController alloc]init];
    MessageViewController * messageVC = [[MessageViewController alloc]init];
    CenterViewController * centerVC = [[CenterViewController alloc]init];
    DisCoverViewController * discoverVC = [[DisCoverViewController alloc]init];
    ProfileViewController * profileVC = [[ProfileViewController alloc]init];
    
    NSArray * views = @[homeVC,messageVC,centerVC,discoverVC,profileVC];
    NSMutableArray * viewControllers = [[NSMutableArray alloc]init];
    
    for (int i=0; i<[views count]; i++) {
        UIViewController * vc = [views objectAtIndex:i];
        BaseNavigationViewController * nav = [[BaseNavigationViewController alloc]initWithRootViewController:vc];
        [nav setDelegate:self];
        if (i==0 || i==4) {
            [nav.navigationBar setBackgroundColor:[UIColor greenColor]];
        }
        [viewControllers addObject:nav];
    }
    
    self.viewControllers = viewControllers;
}

- (void)_initTabbarView
{
    _tabbarView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREENSIZE.height-TABBARHEIGHT, SCREENSIZE.width, TABBARHEIGHT)];
    [_tabbarView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background"]]];
    [self.view addSubview:_tabbarView];
    
    NSArray * text = @[@"首页",@"流水",@"收款",@"店铺",@"更多"];
    NSArray * background = @[@"loker_tabbar_dt",@"loker_tabbar_forum",@"loker_tabbar_hd",@"loker_tabbar_loker",@"loker_tabbar_message"];
    NSArray * lightBackground = @[@"loker_tabbar_dt_selected",@"loker_tabbar_forum_selected",@"loker_tabbar_hd_selected",@"loker_tabbar_loker_selected",@"loker_tabbar_message_selected"];
    
    CGFloat btnWidth = SCREENSIZE.width*1.0 / [background count];
    for (int i=0; i<[background count]; i++) {
        NSString * img = [background objectAtIndex:i];
        NSString * lightImg = [lightBackground objectAtIndex:i];
        NSString * title = [text objectAtIndex:i];
        
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(i*btnWidth, 0, btnWidth, TABBARHEIGHT-15)];
        [btn setTag:i];
        [btn setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:lightImg] forState:UIControlStateHighlighted];
        [btn setImage:[UIImage imageNamed:lightImg] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(selectedTab:) forControlEvents:UIControlEventTouchUpInside];
        //默认显示首页
        if (i==0) {
            [btn setSelected:YES];
        }
        
        [_tabbarView addSubview:btn];
        [self.btnArr addObject:btn];
        
        UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(i*btnWidth, CGRectGetMaxY(btn.frame), btnWidth, 15)];
        [lbl setText:title];
        [lbl setFont:[UIFont systemFontOfSize:12]];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [lbl setTextColor:[UIColor whiteColor]];
        if (i==0) {
            [lbl setTextColor:[UIColor redColor]];
        }
        [_tabbarView addSubview:lbl];
        [self.lblArr addObject:lbl];
    }
    
}
- (NSMutableArray *)btnArr{
    if (!_btnArr) {
        _btnArr = [[NSMutableArray alloc]init];
    }
    return _btnArr;
}
- (NSMutableArray *)lblArr{
    if (!_lblArr) {
        _lblArr = [[NSMutableArray alloc]init];
    }
    return _lblArr;
}
- (void)selectedTab:(UIButton *)btn
{
    for (int i=0; i<[self.btnArr count]; i++) {
        UIButton * tempBtn = [self.btnArr objectAtIndex:i];
        UILabel * tempLbl = [self.lblArr objectAtIndex:i];
        if (btn.tag == i) {
            [tempBtn setSelected:YES];
            [tempLbl setTextColor:[UIColor redColor]];
        }else{
            [tempBtn setSelected:NO];
            [tempLbl setTextColor:[UIColor whiteColor]];
        }
    }
    [self setSelectedIndex:btn.tag];
}

- (void)showTabbar:(BOOL)show
{
    [UIView animateWithDuration:0.35 animations:^{
        if (show) {
            [_tabbarView setFrame:CGRectMake(0, SCREENSIZE.height-TABBARHEIGHT, SCREENSIZE.width, TABBARHEIGHT)];
        }else{
            [_tabbarView setFrame:CGRectMake(-SCREENSIZE.width, SCREENSIZE.height-TABBARHEIGHT, SCREENSIZE.width, TABBARHEIGHT)];
        }
    }];
    [self _resizeView:show];
}

- (void)_resizeView:(BOOL)show
{
    for (UIView * subView in self.view.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UITransitionView")]) {
            if (show) {
                subView.height = SCREENSIZE.height;
            }else{
                subView.height = SCREENSIZE.height+49;
            }
        }
    }
}
#pragma mark+++++++++++++UINavigationControllerDelegate++++++++++++++++
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([navigationController.viewControllers count]>1) {
        [self showTabbar:NO];
    }else{
        [self showTabbar:YES];
    }
}


@end
