//
//  MasnorySnapKitShow.m
//  KWOC
//
//  Created by 渴望 on 2023/7/11.
//

#import "MasnorySnapKitShow.h"

@interface MasnorySnapKitShow ()

@end

@implementation MasnorySnapKitShow

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *arr = @[@"单个按钮无响应事件", @"单个按钮带响应事件", @"双按钮单响应事件", @"双按钮多响应事件", @"alert多按钮", @"actionSheet多按钮"];
    for (NSInteger idx = 0; idx < arr.count; idx++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(idx%2 * 181, 400+idx/2*41, 180, 40)];
        btn.backgroundColor = [UIColor blackColor];
        [btn setTitle:arr[idx] forState:UIControlStateNormal];
        btn.tag = 500+idx;
        [btn addTarget:self action:@selector(showType:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
}


- (void)showType:(UIButton *)btn {
    if (btn.tag == 500) {
        [Alert showText:@"233" :@"33333333"];
    } else if (btn.tag == 501) {
        [Alert showOnly:@"233" :@"3333333" :@"ok" enterHandle:^{
            NSLog(@"点击ok");
        }];
    } else if (btn.tag == 502) {
        [Alert showSingle:@"3333333" :@"3333333" :@"ok" :@"cancel" :^{
            NSLog(@"ok");
        }];
    } else if (btn.tag == 503) {
        [Alert showDouble:@"233" :@"3333333" :@"ok" :@"cancel" :^{
            NSLog(@"ok");
        } :^{
            NSLog(@"cancel");
        }];
    } else if (btn.tag == 504) {
        NSArray *arr = @[@"哈哈", @"哦哦", @"呵呵"];
        [Alert AlertControllerWithTitle:@"233" message:@"33333" cancel:@"cancel" buttonTitles:arr completion:^(NSInteger selectedIdx) {
            NSLog(@"%@", arr[selectedIdx]);
        } cancelAction:^{
            NSLog(@"cancel");
        }];
    } else if (btn.tag == 505) {
        NSArray *arr = @[@"哈哈", @"哦哦", @"呵呵"];
        [Alert AlertControllerSheetWithTitle:@"233" message:@"333333" cancel:@"cancel" buttonTitles:arr completion:^(NSInteger selectedIdx) {
            NSLog(@"%@", arr[selectedIdx]);
        } cancelAction:^{
            NSLog(@"cancel");
        }];
    } else if (btn.tag == 506) {
        // You can add your desired code here
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

@end
