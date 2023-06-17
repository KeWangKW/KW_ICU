//
//  KWColorDemo.m
//  KWOC
//
//  Created by 渴望 on 2023/6/17.
//

#import "KWColorDemo.h"

@interface KWColorDemo ()

@end

@implementation KWColorDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = UIColor.cyanColor;
    
    UILabel * lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, kNavigationStatusHeight(), kScreenWidth()-20, 40)];
    lab1.text = @"仅使用Light色值";
    lab1.textColor = [UIColor KW_L:CustomTitle];
    lab1.backgroundColor = [UIColor KW_L:CustomBackground];
    [self.view addSubview:lab1];
    
    UILabel * lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, kNavigationStatusHeight()+50, kScreenWidth()-20, 40)];
    lab2.text = @"使用适配暗黑色值";
    lab2.textColor = [UIColor KW_LD:CustomTitle];
    lab2.backgroundColor = [UIColor KW_LD:CustomBackground];
    [self.view addSubview:lab2];
    
    UILabel * lab3 = [[UILabel alloc]initWithFrame:CGRectMake(10, kNavigationStatusHeight()+100, kScreenWidth()-20, 40)];
    lab3.text = @"使用适配暗黑色值,但没有在扩展类定义";
    lab3.textColor = [[UIColor alloc]initWithLight:UIColor.whiteColor dark:UIColor.blackColor];
    lab3.backgroundColor = [[UIColor alloc]initWithLight:[UIColor HexColorWithStr:@"0x000000" alpha:1] dark:[UIColor HexColorWithStr:@"0xFFFFFF" alpha:1]];
    [self.view addSubview:lab3];
    
    
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
