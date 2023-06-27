//
//  KWOCViewController.m
//  ShanghaiCard
//
//  Created by 渴望 on 2018/10/31.
//  Copyright © 2018 渴望. All rights reserved.
//

#import "KOViewController.h"
#import <KW-Swift.h>

@interface KOViewController ()

@end

@implementation KOViewController

- (void)dealloc {
    NSLog(@"dealloc: %@", NSStringFromClass(self.class));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //修改返回按钮图片
    self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"fanhui"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"fanhui"];
    //导航栏返回按钮长按处理
    UIBarButtonItem * backBarButton = [[UIBarButtonItem alloc]initWithTitle:@"" style:(UIBarButtonItemStylePlain) target:nil action:nil];
    if (@available(iOS 14.0, *)) {
        self.navigationItem.backButtonDisplayMode = UINavigationItemBackButtonDisplayModeMinimal;
    } else {
        self.navigationItem.backBarButtonItem = backBarButton;
    }
    
    self.kw_statusBarStyle = UIStatusBarStyleDefault;
    self.kw_shadowHidden = true;
    self.edgesForExtendedLayout = UIRectEdgeTop;
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self kw_initData];
    [self kw_initUI];
    [self kw_requestData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self kw_reloadData];
    
}

- (void)kw_initData {
    
}

- (void)kw_initUI {
    
}

- (void)kw_requestData {
    
}

- (void)kw_reloadData {
    
}





@end
