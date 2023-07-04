//
//  KOPageController.m
//  KW
//
//  Created by 渴望 on 2023/7/4.
//

#import "KOPageController.h"

@interface KOPageController () <UIScrollViewDelegate>

@end

@implementation KOPageController

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    
    //不是首页时，释放vc 处理
    if ([self.navigationController.viewControllers firstObject] != self) {
        for (UIView *subview in self.VCScrollView.subviews) {
            [subview removeFromSuperview];
        }
        [self.vcArr removeAllObjects];
        self.vcArr = nil;
    }
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)kw_initData{
    [super kw_initData];
    
}

- (void)kw_initUI{
    [super kw_initUI];
    
    if (self.titleArr.count != self.vcArr.count) {
        NSLog(@"titleArr 和 vcArr 数量不匹配");
        return;
    }
    
    [self.titleView reloadSubviews];
    __weak __typeof(self) weakSelf = self;
    self.titleView.changeSelected = ^(NSInteger idx) {
        
        UIViewController * vc = weakSelf.vcArr[idx];
        [vc viewWillAppear:true];

        [UIView animateWithDuration:0.2 animations:^{
            weakSelf.VCScrollView.contentOffset = CGPointMake(weakSelf.VCScrollView.frame.size.width*idx, 0);
        }];

    };

    [self.view addSubview:self.titleView];
    [self.view addSubview:self.VCScrollView];

    [self addVC];

    UIGestureRecognizer *popGesture = self.navigationController.interactivePopGestureRecognizer;
    if (popGesture != nil) {
        [self.VCScrollView.panGestureRecognizer requireGestureRecognizerToFail:popGesture];
    }
}

- (void)addVC{
    self.VCScrollView.contentSize = CGSizeMake(self.VCScrollView.frame.size.width*self.titleArr.count, 0);
    self.VCScrollView.contentOffset = CGPointMake(self.VCScrollView.frame.size.width*self.titleView.selectedIndex, 0);
    
    for (int idx=0; idx<self.titleArr.count; idx++) {
        UIViewController * vc = self.vcArr[idx];
        vc.view.frame = CGRectMake(self.VCScrollView.frame.size.width*idx, 0, self.VCScrollView.frame.size.width, self.VCScrollView.frame.size.height);
        [self.VCScrollView addSubview:vc.view];
        
        [vc viewWillAppear:true];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger page = self.VCScrollView.contentOffset.x / self.VCScrollView.frame.size.width;
    self.titleView.selectedIndex = page;
}


- (NSMutableArray *)titleArr{
    if(!_titleArr){
        _titleArr = [[NSMutableArray alloc]init];
    }
    return _titleArr;
}

- (NSMutableArray *)vcArr{
    if(!_vcArr){
        _vcArr = [[NSMutableArray alloc]init];
    }
    return _vcArr;
}

- (KSTitleView *)titleView{
    if(!_titleView){
        _titleView = [[KSTitleView alloc]initWithFrame:CGRectMake(0, kNavigationStatusHeight(), kScreenWidth(), 50)];
    }
    return _titleView;
}

- (UIScrollView *)VCScrollView{
    if(!_VCScrollView){
        _VCScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kNavigationStatusHeight()+self.titleView.frame.size.height, kScreenWidth(), kScreenHeight()-kNavigationStatusHeight()-self.titleView.frame.size.height)];
        _VCScrollView.pagingEnabled = true;
        //_VCScrollView.bounces = false;
        _VCScrollView.showsVerticalScrollIndicator = false;
        _VCScrollView.showsHorizontalScrollIndicator = false;
        _VCScrollView.delegate = self;
    }
    return _VCScrollView;
}


@end
