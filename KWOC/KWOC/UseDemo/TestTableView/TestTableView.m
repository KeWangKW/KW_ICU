//
//  TestTableView.m
//  KWOC
//
//  Created by 渴望 on 2023/6/27.
//

#import "TestTableView.h"
#import "ViewController.h"
#import "TestTableViewShow.h"

@interface TestTableView ()

@end

@implementation TestTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *btn6 = [[UIButton alloc] initWithFrame:CGRectMake(10, 370, 400, 30)];
    [btn6 setTitle:@"push查看TableView" forState:UIControlStateNormal];
    btn6.backgroundColor = [UIColor blackColor];
    [btn6 addTarget:self action:@selector(type6Show) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn6];


    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, kScreenHeight() - kNavigationStatusHeight() - 100, 100, 30)];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor blackColor];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)backBtnClick {
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    [self changeRootViewControllerWithVC:nav];
}

- (void)changeRootViewControllerWithVC:(UIViewController *)vc {
    [UIApplication sharedApplication].windows.firstObject.rootViewController = vc;
    [[UIApplication sharedApplication].windows.firstObject makeKeyAndVisible];
}

- (void)type6Show {
    TestTableViewShow * vc = [[TestTableViewShow alloc]init];
    [self.navigationController pushViewController:vc animated:true];
}



@end
