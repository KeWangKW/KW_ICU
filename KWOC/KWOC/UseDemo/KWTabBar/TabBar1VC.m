//
//  TabBar1VC.m
//  KWOC
//
//  Created by 渴望 on 2023/6/17.
//

#import "TabBar1VC.h"
#import "TabBarDemoVC.h"
@interface TabBar1VC ()

@end

@implementation TabBar1VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 400, 100, 100)];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    btn.backgroundColor = UIColor.blackColor;
    [btn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)backClick{
    [UIApplication sharedApplication].windows.firstObject.rootViewController = [[TabBarDemoVC alloc]init];
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
