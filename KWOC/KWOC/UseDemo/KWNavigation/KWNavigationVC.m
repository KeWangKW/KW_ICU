//
//  KWNavigationVC.m
//  KWOC
//
//  Created by 渴望 on 2023/6/19.
//

#import "KWNavigationVC.h"
#import "KWNavigationVC1.h"
#import "ViewController.h"

@interface KWNavigationVC ()

@end

@implementation KWNavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.cyanColor;
    self.title = @"导航栏";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tabbar1"] style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"right" style:UIBarButtonItemStylePlain target:self action:nil];
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 200, 30)];
    [btn setTitle:@"状态栏字体白色" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor blackColor];
    [btn addTarget:self action:@selector(type0Show) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(10, 140, 200, 30)];
    [btn1 setTitle:@"状态栏字体黑色" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor blackColor];
    [btn1 addTarget:self action:@selector(type1Show) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];

    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(10, 180, 400, 30)];
    [btn2 setTitle:@"BarButtonItem颜色" forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor blackColor];
    [btn2 addTarget:self action:@selector(type2Show) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];

    UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(10, 220, 400, 30)];
    [btn3 setTitle:@"Title颜色" forState:UIControlStateNormal];
    btn3.backgroundColor = [UIColor blackColor];
    [btn3 addTarget:self action:@selector(type3Show) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    UIButton *btn4 = [[UIButton alloc] initWithFrame:CGRectMake(10, 260, 400, 30)];
    [btn4 setTitle:@"背景色" forState:UIControlStateNormal];
    btn4.backgroundColor = [UIColor blackColor];
    [btn4 addTarget:self action:@selector(type4Show) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];

    UIButton *btn5 = [[UIButton alloc] initWithFrame:CGRectMake(10, 300, 400, 30)];
    [btn5 setTitle:@"背景图" forState:UIControlStateNormal];
    btn5.backgroundColor = [UIColor blackColor];
    [btn5 addTarget:self action:@selector(type5Show) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn5];

    UIButton *btn6 = [[UIButton alloc] initWithFrame:CGRectMake(10, 370, 400, 30)];
    [btn6 setTitle:@"背景色渐变" forState:UIControlStateNormal];
    btn6.backgroundColor = [UIColor blackColor];
    [btn6 addTarget:self action:@selector(type6Show) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn6];


    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, kScreenHeight() - kNavigationStatusHeight() - 100, 100, 30)];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor blackColor];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
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
    self.kw_statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)type1Show {
    if (@available(iOS 13.0, *)) {
        self.kw_statusBarStyle = UIStatusBarStyleDarkContent;
    } else {
        self.kw_statusBarStyle = UIStatusBarStyleDefault;
    }
}

- (void)type2Show {
    self.kw_tintColor = [UIColor random];
}

- (void)type3Show {
    self.kw_titleColor = [UIColor random];
    self.kw_titleFont = [UIFont systemFontOfSize:29 weight:UIFontWeightBold];
}

- (void)type4Show {
    self.kw_backgroundColor = [UIColor random];
    self.kw_shadowColor = [UIColor random]; // 分割线颜色
}

- (void)type5Show {
    self.kw_backgroundImage = [UIImage imageNamed:@"ic_video_dhTBG"];
}

- (void)type6Show {
    KWNavigationVC1 *vc = [[KWNavigationVC1 alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
