//
//  UITextFieldExtShow.m
//  KWOC
//
//  Created by 渴望 on 2023/7/6.
//

#import "UITextFieldExtShow.h"

@interface UITextFieldExtShow ()

@end

@implementation UITextFieldExtShow

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.cyanColor;
    
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(10, 110, 200, 45)];
    [tf setBackgroundColor:[UIColor whiteColor]];
    [tf setPlaceholder:@"let tf = UITextField(frame: CGRect(x: 10, y: 110, width: 200, height: 45))"];
    [tf kw_addPaddingLeftIcon:[UIImage imageNamed:@"icon_xiaoxi02"] padding:25];
    [tf kw_addPaddingRightIcon:[UIImage imageNamed:@"icon_xiaoxi02"] padding:45];
    [self.view addSubview:tf];
    
    
    UIImage *image = [UIImage imageNamed:@"icon_gongzuotai02"];

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 170, 60, 60)];
    [imageView setImage:image];
    [self.view addSubview:imageView];

    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(100, 170, 60, 60)];
    [imageView1 setImage:[image kw_tintColor:[UIColor redColor]]];
    [self.view addSubview:imageView1];

    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(190, 170, 60, 60)];
    [imageView2 setImage:[image kw_compressedWithQuality:0.1]];
    [self.view addSubview:imageView2];
    
    
    UIImage *imageM = [UIImage imageNamed:@"233"];

    UIImageView *imageViewM1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 250, 207, 155)];
    [imageViewM1 setImage:imageM];
    [self.view addSubview:imageViewM1];

    UIImageView *imageViewM2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 415, 207, 155)];
    [imageViewM2 setImage:[imageM kw_croppedTo:CGRectMake(150, 20, 200, 200)]];
    [self.view addSubview:imageViewM2];
    
    
    
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
