//
//  BaseViewController.m
//  zitoPayApp
//
//  Created by 李冬冬 on 16/11/3.
//  Copyright © 2016年 zitopay. All rights reserved.
//

#import "BaseViewController.h"
#define BTNWIDTH 200
#define BTNHEIGHT 50
@interface BaseViewController ()

@end

@implementation BaseViewController
{
    UIButton * _btn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if( ([ZITOUtility getSystemVersion]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    
}


- (AppDelegate *)appDelegate
{
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return appDelegate;
}

- (void)viewWithNewWorkFail
{
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btn setFrame:CGRectMake((SCREENSIZE.width-BTNWIDTH)/2.0, (SCREENSIZE.height-BTNHEIGHT-44-49-20)/2.0, BTNWIDTH, BTNHEIGHT)];
    [_btn.layer setBorderColor:[UIColor grayColor].CGColor];
    [_btn.layer setBorderWidth:1.0];
    [_btn addTarget:self action:@selector(refreshNewWorkData:) forControlEvents:UIControlEventTouchUpInside];
    [_btn setTitle:@"重新加载" forState:UIControlStateNormal];
    [_btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:_btn];
}
- (void)removeRefreshNewWorkView
{
    if (_btn && [_btn superview]) {
        [_btn removeFromSuperview];
        _btn = nil;
    }
}
- (void)refreshNewWorkData:(UIButton *)btn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(refreshNewWorkData)]) {
        [self.delegate refreshNewWorkData];
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
