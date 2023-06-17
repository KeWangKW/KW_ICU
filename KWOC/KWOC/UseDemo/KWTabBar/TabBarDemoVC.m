//
//  TabBarDemoVC.m
//  KWOC
//
//  Created by 渴望 on 2023/6/17.
//

#import "TabBarDemoVC.h"
#import "TabBar5VC.h"
#import "TabBar4VC.h"
#import "TabBar3VC.h"
#import "TabBar2VC.h"
#import "TabBar1VC.h"


@interface TabBarDemoVC ()

@end

@implementation TabBarDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor cyanColor];
    
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 100, 200, 30)];
    [btn setTitle:@"普通样式" forState:UIControlStateNormal];
    btn.backgroundColor = UIColor.blackColor;
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton * btn1 = [[UIButton alloc]initWithFrame:CGRectMake(10, 140, 200, 30)];
    [btn1 setTitle:@"选中凸起样式" forState:UIControlStateNormal];
    btn1.backgroundColor = UIColor.blackColor;
    [btn1 addTarget:self action:@selector(btn1Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton * btn2 = [[UIButton alloc]initWithFrame:CGRectMake(10, 180, 400, 30)];
    [btn2 setTitle:@"选中凸起样式（部分Tabbar）" forState:UIControlStateNormal];
    btn2.backgroundColor = UIColor.blackColor;
    [btn2 addTarget:self action:@selector(btn2Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton * btn3 = [[UIButton alloc]initWithFrame:CGRectMake(10, 220, 400, 30)];
    [btn3 setTitle:@"选中凸起样式（中间单个Tabbar）" forState:UIControlStateNormal];
    btn3.backgroundColor = UIColor.blackColor;
    [btn3 addTarget:self action:@selector(btn3Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    UIButton * btn4 = [[UIButton alloc]initWithFrame:CGRectMake(10, 260, 400, 30)];
    [btn4 setTitle:@"固定凸起样式（部分Tabbar）" forState:UIControlStateNormal];
    btn4.backgroundColor = UIColor.blackColor;
    [btn4 addTarget:self action:@selector(btn4Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
    
    UIButton * btn5 = [[UIButton alloc]initWithFrame:CGRectMake(10, 300, 400, 30)];
    [btn5 setTitle:@"固定凸起样式（单个Tabbar）" forState:UIControlStateNormal];
    btn5.backgroundColor = UIColor.blackColor;
    [btn5 addTarget:self action:@selector(btn5Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn5];
    
}

- (void)btnClick{
    
    NSArray * vcArr = @[[TabBar1VC new],[TabBar2VC new],[TabBar3VC new],[TabBar4VC new],[TabBar5VC new]];
    NSArray * titleArr = @[@"tab1", @"tab2", @"tab3", @"tab4", @"tab5"];
    NSArray * normalImageArr = @[@"icon_guanli01", @"icon_gongzuotai01", @"icon_xiaoxi01", @"icon_wode01", @"icon_wode01"];
    NSArray * selectedImageArr = @[@"icon_guanli02", @"icon_gongzuotai02", @"icon_xiaoxi02", @"icon_wode02", @"icon_wode02"];
    
    KWTabBarController * vc = [[KWTabBarController alloc]init:vcArr :titleArr :normalImageArr :selectedImageArr humpType:0 humpAddress:@[] backGroundColor:[UIColor whiteColor]];
    vc.selectedIndex = 0;
    
    [UIApplication sharedApplication].windows.firstObject.rootViewController = vc;
    [[UIApplication sharedApplication].windows.firstObject makeKeyAndVisible];
}

- (void)btn1Click{
    
    NSArray * vcArr = @[[TabBar1VC new],[TabBar2VC new],[TabBar3VC new],[TabBar4VC new],[TabBar5VC new]];
    NSArray * titleArr = @[@"tab1", @"tab2", @"tab3", @"tab4", @"tab5"];
    NSArray * normalImageArr = @[@"icon_guanli01", @"icon_gongzuotai01", @"icon_xiaoxi01", @"icon_wode01", @"icon_wode01"];
    NSArray * selectedImageArr = @[@"icon_fabu", @"icon_fabu", @"icon_fabu", @"icon_fabu", @"icon_fabu"];
    
    KWTabBarController * vc = [[KWTabBarController alloc]init:vcArr :titleArr :normalImageArr :selectedImageArr humpType:1 humpAddress:@[] backGroundColor:[UIColor whiteColor]];
    vc.selectedIndex = 0;
    
    [UIApplication sharedApplication].windows.firstObject.rootViewController = vc;
    [[UIApplication sharedApplication].windows.firstObject makeKeyAndVisible];
}

- (void)btn2Click{
    
    NSArray * vcArr = @[[TabBar1VC new],[TabBar2VC new],[TabBar3VC new],[TabBar4VC new],[TabBar5VC new]];
    NSArray * titleArr = @[@"tab1", @"tab2", @"tab3", @"tab4", @"tab5"];
    NSArray * normalImageArr = @[@"icon_guanli01", @"icon_gongzuotai01", @"icon_xiaoxi01", @"icon_wode01", @"icon_wode01"];
    NSArray * selectedImageArr = @[@"icon_fabu", @"icon_gongzuotai02", @"icon_fabu", @"icon_wode02", @"icon_fabu"];
    
    KWTabBarController * vc = [[KWTabBarController alloc]init:vcArr :titleArr :normalImageArr :selectedImageArr humpType:2 humpAddress:@[@0,@2,@4] backGroundColor:[UIColor yellowColor]];
    vc.selectedIndex = 2;
    
    [UIApplication sharedApplication].windows.firstObject.rootViewController = vc;
    [[UIApplication sharedApplication].windows.firstObject makeKeyAndVisible];
}

- (void)btn3Click{
    
    NSArray * vcArr = @[[TabBar1VC new],[TabBar2VC new],[TabBar3VC new],[TabBar4VC new],[TabBar5VC new]];
    NSArray * titleArr = @[@"tab1", @"tab2", @"tab3", @"tab4", @"tab5"];
    NSArray * normalImageArr = @[@"icon_guanli01", @"icon_gongzuotai01", @"icon_xiaoxi01", @"icon_wode01", @"icon_wode01"];
    NSArray * selectedImageArr = @[@"icon_guanli02", @"icon_gongzuotai02", @"icon_fabu", @"icon_wode02", @"icon_wode02"];
    
    KWTabBarController * vc = [[KWTabBarController alloc]init:vcArr :titleArr :normalImageArr :selectedImageArr humpType:2 humpAddress:@[@2] backGroundColor:[UIColor whiteColor]];
    vc.selectedIndex = 2;
    
    [UIApplication sharedApplication].windows.firstObject.rootViewController = vc;
    [[UIApplication sharedApplication].windows.firstObject makeKeyAndVisible];
}

- (void)btn4Click{
    
    NSArray * vcArr = @[[TabBar1VC new],[TabBar2VC new],[TabBar3VC new],[TabBar4VC new],[TabBar5VC new]];
    NSArray * titleArr = @[@"tab1", @"tab2", @"tab3", @"tab4", @"tab5"];
    NSArray * normalImageArr = @[@"icon_fabu", @"icon_gongzuotai01", @"icon_fabu", @"icon_wode01", @"icon_fabu"];
    NSArray * selectedImageArr = @[@"icon_fabu", @"icon_gongzuotai02", @"icon_fabu", @"icon_wode02", @"icon_fabu"];
    
    KWTabBarController * vc = [[KWTabBarController alloc]init:vcArr :titleArr :normalImageArr :selectedImageArr humpType:3 humpAddress:@[@0,@2,@4] backGroundColor:[UIColor whiteColor]];
    vc.selectedIndex = 2;
    
    [UIApplication sharedApplication].windows.firstObject.rootViewController = vc;
    [[UIApplication sharedApplication].windows.firstObject makeKeyAndVisible];
}


- (void)btn5Click{
    
    NSArray * vcArr = @[[TabBar1VC new],[TabBar2VC new],[TabBar3VC new],[TabBar4VC new],[TabBar5VC new]];
    NSArray * titleArr = @[@"tab1", @"tab2", @"tab3", @"tab4", @"tab5"];
    NSArray * normalImageArr = @[@"icon_guanli01", @"icon_gongzuotai01", @"icon_fabu", @"icon_wode01", @"icon_wode01"];
    NSArray * selectedImageArr = @[@"icon_guanli02", @"icon_gongzuotai02", @"icon_fabu", @"icon_wode02", @"icon_wode02"];
    
    KWTabBarController * vc = [[KWTabBarController alloc]init:vcArr :titleArr :normalImageArr :selectedImageArr humpType:3 humpAddress:@[@2] backGroundColor:[UIColor whiteColor]];
    vc.selectedIndex = 2;
    
    [UIApplication sharedApplication].windows.firstObject.rootViewController = vc;
    [[UIApplication sharedApplication].windows.firstObject makeKeyAndVisible];
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
