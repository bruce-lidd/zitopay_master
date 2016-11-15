//
//  SecondViewController.m
//  zitoPayApp
//
//  Created by 李冬冬 on 16/11/3.
//  Copyright © 2016年 zitopay. All rights reserved.
//

#import "SecondViewController.h"
#import "ShareButtonView.h"
#import "CountButtonView.h"
@interface SecondViewController () <ShareButtonViewDelegate,CountButtonViewDelegate>

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor darkGrayColor]];
    
//    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 200, 200, 50)];
//    [btn setTitle:@"点击" forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [btn setBackgroundColor:[UIColor greenColor]];
//    [self.view addSubview:btn];
    CountButtonView * countBtn = [[CountButtonView alloc] initWithFrame:CGRectMake(0, 200, 200, 50)];
    [countBtn setBackgroundColor:[UIColor grayColor]];
    [countBtn setDelegate:self];
    [self.view addSubview:countBtn];
}
- (void)btnClick:(UIButton *)btn
{
    ShareButtonView * shareBtn = [[ShareButtonView alloc]init];
    [shareBtn setDelegate:self];
    [shareBtn showView];
}

#pragma mark      ShareButtonViewDelegate
- (void)clickItem:(ShareButtonView *)shareBtnView index:(NSInteger)index
{
    switch (index) {
        case MESSAGECHANNEL:
        {
            
        }
            break;
        case SINACHANNEL:
        {
            
        }
            break;
        case WXCHANNEL:
        {
            
        }
            break;
        case QZCHANNEL:
        {
            
        }
            break;
        case QQCHANNEL:
        {
            
        }
            break;
            
        default:
            break;
    }
}
#pragma mark  CountButtonViewDelegate
- (void)startCountDown:(CountButtonView *)countBtnView
{
    NSLog(@"start countdown");
    
}

- (void)finishCountDown:(CountButtonView *)countBtnView
{
    NSLog(@"finish count");
    
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
