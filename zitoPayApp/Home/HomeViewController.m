//
//  HomeViewController.m
//  zitoPayApp
//
//  Created by 李冬冬 on 16/11/3.
//  Copyright © 2016年 zitopay. All rights reserved.
//首页控制器

#import "HomeViewController.h"
#import "SecondViewController.h"
#import "AppDelegate.h"
#import "AdvertiseViewController.h"
@interface HomeViewController ()<BaseTableViewDelegate,BaseViewControllerDelegate>
@property (nonatomic,retain) NSMutableArray * dataArr;
@end

@implementation HomeViewController
- (void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //开启左划菜单
    [self.appDelegate.reSideMenu setEnableGesture:YES];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //开启左划菜单
    [self.appDelegate.reSideMenu setEnableGesture:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"首页"];
    [self setDelegate:self];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToAd) name:@"pushtoad" object:nil];
    
    [self _initTableView];
    
    [self requestData];
    
}
- (void)_initTableView
{
    _baseTableView = [[BaseTableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, SCREENSIZE.width, SCREENSIZE.height-49-20-44) style:UITableViewStylePlain];
    [_baseTableView setBackgroundColor:[UIColor clearColor]];
    [_baseTableView setBaseTableViewDelegate:self];
    [self.view addSubview:_baseTableView];
}
- (void)requestData
{
    self.dataArr = [NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"",@"",@"",@"", nil];
    [self.baseTableView setIsMore:YES];
    [self.baseTableView setUpData:self.dataArr index:0];
//    [self viewWithNewWorkFail];
}
//- (void)refreshNewWorkData
//{
//    [self removeRefreshNewWorkView];
//}
- (void)pushToAd {
    
    AdvertiseViewController *adVc = [[AdvertiseViewController alloc] init];
    [self.navigationController pushViewController:adVc animated:YES];
    
}
#pragma mark  BaseTableViewDelegate
- (void)pullUp:(BaseTableView *)tableView
{
    NSLog(@"上拉加载更多");
    [self.dataArr addObject:@""];
    [self.dataArr addObject:@""];
    [self.dataArr addObject:@""];
    [self.dataArr addObject:@""];
    [self.dataArr addObject:@""];
    [self.dataArr addObject:@""];
    [self.dataArr addObject:@""];
    [self.dataArr addObject:@""];
    [self.dataArr addObject:@""];
    [self.dataArr addObject:@""];
    [self.baseTableView setUpData:self.dataArr index:0];
}
- (void)pullDown:(BaseTableView *)tableView
{
    //    [self.baseTableView.dataArr addObject:@""];
    NSLog(@"下拉刷新");
    //刷新完毕调用这个方法停止刷新 doneLoadingTableViewData
    //请求网络数据
    [tableView performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3];
}
- (void)baseTableView:(BaseTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SecondViewController * secondView = [[SecondViewController alloc]init];
    [self.navigationController pushViewController:secondView animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
