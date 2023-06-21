//
//  KWNavigationVC1.m
//  KWOC
//
//  Created by 渴望 on 2023/6/19.
//

#import "KWNavigationVC1.h"

@interface KWNavigationVC1 ()<UIScrollViewDelegate>

@end

@implementation KWNavigationVC1

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self nav_color_gradient:[UIColor whiteColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.cyanColor;
    self.title = @"23333";
    
    CGRect scrollFrame = CGRectMake(0, 0, kScreenWidth(), kScreenHeight());
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:scrollFrame];
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(0, kScreenHeight() * 2);
    [self.view addSubview:scrollView];

    CGRect imgFrame = CGRectMake(0, -kNavigationStatusHeight(), kScreenWidth(), 800);
    UIImageView *img = [[UIImageView alloc] initWithFrame:imgFrame];
    img.contentMode = UIViewContentModeScaleToFill;
    img.image = [UIImage imageNamed:@"ic_video_dhTBG"];
    [scrollView addSubview:img];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    CGFloat progress = MIN(1, MAX(0, contentOffsetY / 60));
    if (progress < 0.1) {
        self.kw_statusBarStyle = UIStatusBarStyleLightContent;
        self.kw_tintColor = UIColor.whiteColor;
        self.kw_titleColor = UIColor.whiteColor;
    } else {
        if (@available(iOS 13.0, *)) {
            self.kw_statusBarStyle = UIStatusBarStyleDarkContent;
        } else {
            self.kw_statusBarStyle = UIStatusBarStyleDefault;
        }
        self.kw_tintColor = [UIColor colorWithWhite:0 alpha:progress];
        self.kw_titleColor = [UIColor colorWithWhite:0 alpha:progress];
    }
    self.kw_barAlpha = progress;
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
