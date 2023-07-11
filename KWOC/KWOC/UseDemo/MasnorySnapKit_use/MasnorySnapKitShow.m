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
    
    UIView * v = [[UIView alloc]init];
    [self.view addSubview:v];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.left.equalTo(self.view).offset(10);
    }];
    
    [v mas_remakeConstraints:^(MASConstraintMaker *make) {
            
    }];
    
    [v mas_updateConstraints:^(MASConstraintMaker *make) {
            
    }];
    
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
