//
//  KOPageShow.m
//  KWOC
//
//  Created by 渴望 on 2023/7/4.
//

#import "KOPageShow.h"
#import "KOPageController1.h"
#import "KOPageController2.h"
#import "KOPageController3.h"
#import "KOPageController4.h"
#import "KOPageController5.h"
@interface KOPageShow ()

@end

@implementation KOPageShow

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)kw_initData{
    [super kw_initData];
    
    self.titleArr = [NSMutableArray arrayWithArray:@[@"全部",@"待付款",@"待发货",@"待收货",@"售后服务和退款服务",@"售后服务和退款服务",@"售后服务和退款服务",@"售后服务和退款服务",@"售后服务和退款服务",@"售后服务和退款服务",@"售后服务和退款服务",@"售后服务和退款服务",@"售后服务和退款服务"]];
    
    self.vcArr = [NSMutableArray arrayWithArray:@[[[KOPageController1 alloc]init],
                                                  [[KOPageController2 alloc]init],
                                                  [[KOPageController3 alloc]init],
                                                  [[KOPageController4 alloc]init],
                                                  [[KOPageController5 alloc]init],
                                                  [[KOPageController5 alloc]init],
                                                  [[KOPageController5 alloc]init],
                                                  [[KOPageController5 alloc]init],
                                                  [[KOPageController5 alloc]init],
                                                  [[KOPageController5 alloc]init],
                                                  [[KOPageController5 alloc]init],
                                                  [[KOPageController5 alloc]init],
                                                  [[KOPageController5 alloc]init]] ];
    self.titleView.ArrangementType = 3;
    self.titleView.titleArr = self.titleArr;
    self.titleView.selectedIndex = 2;
    
}

- (void)kw_initUI{
    [super kw_initUI];
    
}

@end
