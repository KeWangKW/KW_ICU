//
//  UIButtonExtShow.m
//  KWOC
//
//  Created by 渴望 on 2023/7/6.
//

#import "UIButtonExtShow.h"

@interface UIButtonExtShow ()

@end

@implementation UIButtonExtShow

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 100, 300, 50)];
    [btn setBackgroundColor:[UIColor cyanColor]];
    [btn setTitle:@"默认样式" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"icon_wode02"] forState:UIControlStateNormal];
    [self.view addSubview:btn];

    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(20, 160, 300, 50)];
    [btn1 setBackgroundColor:[UIColor cyanColor]];
    [btn1 setTitle:@"图片在左侧 间距10" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:@"icon_wode02"] forState:UIControlStateNormal];
    [self.view addSubview:btn1];
    [btn1 kw_setWithImage:PositionLeft spacing:10];
    
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(20, 220, 300, 50)];
    [btn2 setBackgroundColor:[UIColor cyanColor]];
    [btn2 setTitle:@"图片在右侧 间距10" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"icon_wode02"] forState:UIControlStateNormal];
    [self.view addSubview:btn2];
    [btn2 kw_setWithImage:PositionRight spacing:10];

    UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(20, 280, 300, 100)];
    [btn3 setBackgroundColor:[UIColor cyanColor]];
    [btn3 setTitle:@"图片在上侧 间距10" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn3 setImage:[UIImage imageNamed:@"icon_wode02"] forState:UIControlStateNormal];
    [self.view addSubview:btn3];
    [btn3 kw_setWithImage:PositionTop spacing:10];

    UIButton *btn4 = [[UIButton alloc] initWithFrame:CGRectMake(20, 390, 300, 100)];
    [btn4 setBackgroundColor:[UIColor cyanColor]];
    [btn4 setTitle:@"图片在下侧 间距10" forState:UIControlStateNormal];
    [btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn4 setImage:[UIImage imageNamed:@"icon_wode02"] forState:UIControlStateNormal];
    [self.view addSubview:btn4];
    [btn4 kw_setWithImage:PositionBottom spacing:10];
    
    
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
