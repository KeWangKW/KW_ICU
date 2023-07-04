//
//  KOTitleViewShow.m
//  KWOC
//
//  Created by 渴望 on 2023/7/4.
//

#import "KOTitleViewShow.h"

@interface KOTitleViewShow ()
@property (nonatomic, strong) KSTitleView *titleView1;
@property (nonatomic, strong) KSTitleView *titleView2;
@property (nonatomic, strong) KSTitleView *titleView3;
@end

@implementation KOTitleViewShow

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel * lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, kNavigationStatusHeight(), kScreenWidth()-20, 50)];
    lab1.text = @"宽度均分";
    [self.view addSubview:lab1];
    
    
    
    KSTitleView * titleView1 = [[KSTitleView alloc]initWithFrame:CGRectMake(10, kNavigationStatusHeight()+50, kScreenWidth()-20, 50)];
    titleView1.titleArr = @[@"全部",@"待付款",@"待发货",@"待收货",@"售后"];
    titleView1.ArrangementType = 1;
    titleView1.selectedIndex = 2;
    titleView1.underLineSize = CGSizeMake(20, 5);
    titleView1.underLineColor = UIColor.redColor;
    titleView1.underLineBottomSpace = 5;
    titleView1.underLineRadius = 2.5;
    [titleView1 reloadSubviews];
    titleView1.changeSelected = ^(NSInteger idx) {
        NSLog(@"%ld",(long)idx);
    };
    [self.view addSubview:titleView1];
    
    
    
    UILabel * lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, kNavigationStatusHeight()+100, kScreenWidth()-20, 50)];
    lab2.text = @"宽度固定100";
    [self.view addSubview:lab2];
    
    
    KSTitleView * titleView2 = [[KSTitleView alloc]initWithFrame:CGRectMake(10, kNavigationStatusHeight()+150, kScreenWidth()-20, 50)];
    titleView2.titleArr = @[@"全部",@"待付款",@"待发货",@"待收货",@"售后服务和退款服务",@"售后服务",@"售后服务",@"售后服务",@"售后服务",@"售后服务",@"售后服务",@"售后服务",@"售后服务"];
    titleView2.ArrangementType = 2;
    titleView2.fixdWidth = 100;
    titleView2.selectedIndex = 2;
    [titleView2 reloadSubviews];
    titleView2.changeSelected = ^(NSInteger idx) {
        NSLog(@"%ld",(long)idx);
    };
    [self.view addSubview:titleView2];
    
    
    UILabel * lab3 = [[UILabel alloc]initWithFrame:CGRectMake(10, kNavigationStatusHeight()+200, kScreenWidth()-20, 50)];
    lab3.text = @"宽度根据文字自适应 + 文字左右间距";
    [self.view addSubview:lab3];
    
    
    KSTitleView * titleView3 = [[KSTitleView alloc]initWithFrame:CGRectMake(10, kNavigationStatusHeight()+250, kScreenWidth()-20, 50)];
    titleView3.titleArr = @[@"全部",@"待付款",@"待发货",@"待收货",@"售后服务和退款服务",@"售后服务和退款服务",@"售后服务和退款服务",@"售后服务和退款服务",@"售后服务和退款服务",@"售后服务和退款服务",@"售后服务和退款服务",@"售后服务和退款服务",@"售后服务和退款服务"];
    titleView3.ArrangementType = 3;
    titleView3.selectedIndex = 2;
    [titleView3 reloadSubviews];
    titleView3.changeSelected = ^(NSInteger idx) {
        NSLog(@"%ld",(long)idx);
    };
    [self.view addSubview:titleView3];
    
    
    
    
    
    self.titleView1 = titleView1;
    self.titleView2 = titleView2;
    self.titleView3 = titleView3;
    self.titleView1.backgroundColor = UIColor.yellowColor;
    self.titleView2.backgroundColor = UIColor.yellowColor;
    self.titleView3.backgroundColor = UIColor.yellowColor;
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, kScreenHeight()-kNavigationStatusHeight(), 200, 100)];
    btn.backgroundColor = UIColor.blackColor;
    [btn setTitle:@"修改选中位置为1" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnClick{
    self.titleView1.selectedIndex = 1;
    self.titleView2.selectedIndex = 1;
    self.titleView3.selectedIndex = 1;
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
