//
//  TestBaseVC.m
//  KWOC
//
//  Created by 渴望 on 2023/6/25.
//

#import "TestBaseVC.h"
#import "TestBaseVC11.h"
#import "ViewController.h"
@interface TestBaseVC ()

@end

@implementation TestBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)kw_initData{
    [super kw_initData];
    
}

- (void)kw_initUI{
    [super kw_initUI];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 200, 30)];
    [btn setTitle:@"状态栏字体白色" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor blackColor];
    [btn addTarget:self action:@selector(type0Show) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, kScreenHeight() - kNavigationStatusHeight() - 100, 100, 30)];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor blackColor];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
}

- (void)kw_requestData{
    [super kw_requestData];
    
}

- (void)kw_reloadData{
    [super kw_reloadData];
    
}


- (void)backBtnClick {
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    [self changeRootViewControllerWithVC:nav];
}

- (void)changeRootViewControllerWithVC:(UIViewController *)vc {
    [UIApplication sharedApplication].windows.firstObject.rootViewController = vc;
    [[UIApplication sharedApplication].windows.firstObject makeKeyAndVisible];
}

- (void)type0Show {
    TestBaseVC11 * vc = [[TestBaseVC11 alloc]init];
    [self.navigationController pushViewController:vc animated:true];
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
