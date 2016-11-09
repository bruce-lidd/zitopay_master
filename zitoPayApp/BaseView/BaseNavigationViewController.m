//
//  BaseNavigationViewController.m
//  zitoPayApp
//
//  Created by 李冬冬 on 16/11/3.
//  Copyright © 2016年 zitopay. All rights reserved.
//

#import "BaseNavigationViewController.h"

@interface BaseNavigationViewController ()

@end

@implementation BaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置导航条的背景图片
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    
    UISwipeGestureRecognizer * swipGes = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipAction:)];
    [swipGes setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipGes];
    
    
}
- (void)swipAction:(UISwipeGestureRecognizer *)ges
{
    if ([self.viewControllers count]>1) {
        if (ges.direction  == UISwipeGestureRecognizerDirectionRight) {
            [self popViewControllerAnimated:YES];
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
