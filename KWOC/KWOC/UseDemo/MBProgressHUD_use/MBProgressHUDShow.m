//
//  MBProgressHUDShow.m
//  KWOC
//
//  Created by 渴望 on 2023/7/11.
//

#import "MBProgressHUDShow.h"
#import "MBProgressHUD.h"

@interface MBProgressHUDShow ()
@property (nonatomic, strong) UIView *vvvv;
@end

@implementation MBProgressHUDShow

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"隐藏" style:UIBarButtonItemStylePlain target:self action:@selector(hideClick)];
    
    
    
    
    UIView *vvvv = [[UIView alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth(), 150)];
    self.vvvv = vvvv;
    vvvv.backgroundColor = [UIColor yellowColor];
    self.vvvv = vvvv;
    [self.view addSubview:vvvv];
    
    
    NSArray *arr = @[@"转圈", @"转圈带字", @"仅展示文字", @"", @"成功", @"成功带字", @"失败", @"失败带字", @"提示", @"提示带字", @"进度", @"进度带字"];
    for (NSUInteger idx = 0; idx < arr.count; idx++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(idx % 2 * 101, 400 + (NSInteger)(idx / 2) * 41, 100, 40);
        btn.backgroundColor = [UIColor blackColor];
        [btn setTitle:arr[idx] forState:UIControlStateNormal];
        btn.tag = 500 + idx;
        [btn addTarget:self action:@selector(showType:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)showType:(UIButton *)btn{
    if (btn.tag == 500) {
        [HUD show:nil text:nil];
        [HUD show:self.vvvv text:nil];
    }else if (btn.tag == 501) {
        [HUD show:self.view text:@"233"];
        [HUD show:self.vvvv text:@"2333"];
    }else if (btn.tag == 502) {
        [HUD showText:nil text:@"233" afterDelay:2];
        [HUD showText:self.vvvv text:@"233" afterDelay:1.5];
    }else if (btn.tag == 503) {
//        UIImageView * imageView = [[UIImageView alloc]init];
//        NSURL * url = [[NSBundle mainBundle] URLForResource:@"加载缓存" withExtension:@"gif"];
    }else if (btn.tag == 504) {
        [HUD showSuccess:nil text:nil afterDelay:2];
        [HUD showSuccess:self.vvvv text:nil afterDelay:2];
    }else if (btn.tag == 505) {
        [HUD showSuccess:nil text:@"233" afterDelay:2];
        [HUD showSuccess:self.vvvv text:@"233" afterDelay:2];
    }else if (btn.tag == 506) {
        [HUD showError:nil text:nil afterDelay:2];
        [HUD showError:self.vvvv text:nil afterDelay:2];
    }else if (btn.tag == 507) {
        [HUD showError:nil text:@"233" afterDelay:2];
        [HUD showError:self.vvvv text:@"233" afterDelay:2];
    }else if (btn.tag == 508) {
        [HUD showInfo:nil text:nil afterDelay:2];
        [HUD showInfo:self.vvvv text:nil afterDelay:2];
    }else if (btn.tag == 509) {
        [HUD showInfo:nil text:@"233" afterDelay:2];
        [HUD showInfo:self.vvvv text:@"233" afterDelay:2];
    }else if (btn.tag == 510) {
        MBProgressHUD * hud = [HUD showProgress:nil text:nil];
        hud.progress = 0.4;
        MBProgressHUD * hud1 = [HUD showProgress:self.vvvv text:nil];
        hud1.progress = 0.7;
    }else if (btn.tag == 511) {
        MBProgressHUD * hud = [HUD showProgress:nil text:@"233"];
        hud.progress = 0.4;
        MBProgressHUD * hud1 = [HUD showProgress:self.vvvv text:@"2333"];
        hud1.progress = 0.7;
    }
}


- (void)hideClick{
    [HUD hide:self.view];
    [HUD hide:self.vvvv];
}

@end
