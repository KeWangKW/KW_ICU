//
//  UIViewExtShow.m
//  KWOC
//
//  Created by 渴望 on 2023/7/5.
//

#import "UIViewExtShow.h"

@interface UIViewExtShow ()
@property (nonatomic, strong) UILabel *lab;
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, copy) NSArray *arr;
@end

@implementation UIViewExtShow

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(170, 110, 180, 200)];
    lab.text = @"UILabel \n 默认全属性设置";
    lab.numberOfLines = 0;
    lab.textColor = UIColor.blackColor;
    lab.textAlignment = NSTextAlignmentCenter;
    self.lab = lab;
    [self.view addSubview:lab];
    [lab kw_setupLayerWithRoundCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft
                           roundRadius:35
                           borderWidth:5
                           borderColor:[UIColor blackColor]
                           shadowColor:[UIColor redColor]
                          shadowOffset:CGSizeMake(2, 2)
                         shadowOpacity:0.6
                          shadowRadius:5
                        gradientColors:@[[UIColor redColor],[UIColor blueColor]]
                         gradientStart:CGPointMake(0, 0.5)
                           gradientEnd:CGPointMake(1, 0.5)];
    
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(170, 330, 180, 200)];
    [btn setTitle:@"UIbutton \n 默认全属性设置" forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    btn.titleLabel.numberOfLines = 0;
    self.btn = btn;
    [self.view addSubview:btn];
    [btn kw_setupLayerWithRoundCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft
                           roundRadius:35
                           borderWidth:5
                           borderColor:[UIColor blackColor]
                           shadowColor:[UIColor redColor]
                          shadowOffset:CGSizeMake(2, 2)
                         shadowOpacity:0.6
                          shadowRadius:5
                        gradientColors:@[[UIColor redColor],[UIColor blueColor]]
                         gradientStart:CGPointMake(0, 0.5)
                           gradientEnd:CGPointMake(1, 0.5)];
    
    
    self.arr = @[@"恢复Layer",@"圆角",@"圆角+边框",@"圆角+阴影",@"圆角+渐变",@"圆角+边框+阴影",@"圆角+边框+渐变",@"圆角+阴影+渐变",@"圆角+边框+阴影+渐变",@"边框",@"边框+阴影",@"边框+渐变",@"边框+阴影+渐变",@"阴影",@"阴影+渐变",@"渐变"];
    
    for (int i=0; i<self.arr.count; i++) {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(5, 110+32*i, 150, 30)];
        [btn setTitle:self.arr[i] forState:UIControlStateNormal];
        btn.backgroundColor = UIColor.blackColor;
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        btn.tag = 500+i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    
    
    [lab kw_tapAtion:^(UITapGestureRecognizer * _Nonnull) {
        NSLog(@"23333");
    }];
    
    
    
}


- (void)btnClick:(UIButton *)btn{
    [self.lab kw_resetLayer];
    [self.btn kw_resetLayer];
    
    self.lab.text = [NSString stringWithFormat:@"UILabel \n %@",btn.titleLabel.text];
    [self.btn setTitle:[NSString stringWithFormat:@"UIBUtton \n %@",btn.titleLabel.text] forState:UIControlStateNormal];
    
    if (btn.tag == 500) {
        //恢复Layer
    }else if (btn.tag == 501) {
        //圆角
        [self.lab kw_setupLayerWithRoundCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft
                                    roundRadius:35
                                    borderWidth:5
                                    borderColor:[UIColor clearColor]
                                    shadowColor:[UIColor clearColor]
                                   shadowOffset:CGSizeZero
                                  shadowOpacity:0
                                   shadowRadius:0
                                 gradientColors:@[]
                                  gradientStart:CGPointZero
                                    gradientEnd:CGPointZero];
        [self.btn kw_setupLayerWithRoundCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft
                                    roundRadius:35
                                    borderWidth:5
                                    borderColor:[UIColor clearColor]
                                    shadowColor:[UIColor clearColor]
                                   shadowOffset:CGSizeZero
                                  shadowOpacity:0
                                   shadowRadius:0
                                 gradientColors:@[]
                                  gradientStart:CGPointZero
                                    gradientEnd:CGPointZero];
    }else if (btn.tag == 502) {
        //圆角+边框
        [self.lab kw_setupLayerWithRoundCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft
                                    roundRadius:35
                                    borderWidth:5
                                    borderColor:[UIColor blackColor]
                                    shadowColor:[UIColor redColor]
                                   shadowOffset:CGSizeZero
                                  shadowOpacity:0
                                   shadowRadius:0
                                 gradientColors:@[]
                                  gradientStart:CGPointZero
                                    gradientEnd:CGPointZero];
        [self.btn kw_setupLayerWithRoundCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft
                                    roundRadius:35
                                    borderWidth:5
                                    borderColor:[UIColor blackColor]
                                    shadowColor:[UIColor redColor]
                                   shadowOffset:CGSizeZero
                                  shadowOpacity:0
                                   shadowRadius:0
                                 gradientColors:@[]
                                  gradientStart:CGPointZero
                                    gradientEnd:CGPointZero];
    }else if (btn.tag == 503) {
        //圆角+阴影
        [self.lab kw_setupLayerWithRoundCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft
                                    roundRadius:35
                                    borderWidth:0
                                    borderColor:[UIColor clearColor]
                                    shadowColor:[UIColor redColor]
                                   shadowOffset:CGSizeMake(2, 2)
                                  shadowOpacity:0.6
                                   shadowRadius:5
                                 gradientColors:@[]
                                  gradientStart:CGPointZero
                                    gradientEnd:CGPointZero];
        [self.btn kw_setupLayerWithRoundCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft
                                    roundRadius:35
                                    borderWidth:0
                                    borderColor:[UIColor clearColor]
                                    shadowColor:[UIColor redColor]
                                   shadowOffset:CGSizeMake(2, 2)
                                  shadowOpacity:0.6
                                   shadowRadius:5
                                 gradientColors:@[]
                                  gradientStart:CGPointZero
                                    gradientEnd:CGPointZero];
    }else if (btn.tag == 504) {
        //圆角+渐变
        [self.lab kw_setupLayerWithRoundCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft
                                    roundRadius:35
                                    borderWidth:0
                                    borderColor:[UIColor clearColor]
                                    shadowColor:[UIColor clearColor]
                                   shadowOffset:CGSizeZero
                                  shadowOpacity:0
                                   shadowRadius:0
                                 gradientColors:@[[UIColor redColor],[UIColor blueColor]]
                                  gradientStart:CGPointMake(0, 0.5)
                                    gradientEnd:CGPointMake(1, 0.5)];
        [self.btn kw_setupLayerWithRoundCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft
                                    roundRadius:35
                                    borderWidth:0
                                    borderColor:[UIColor clearColor]
                                    shadowColor:[UIColor clearColor]
                                   shadowOffset:CGSizeZero
                                  shadowOpacity:0
                                   shadowRadius:0
                                 gradientColors:@[[UIColor redColor],[UIColor blueColor]]
                                  gradientStart:CGPointMake(0, 0.5)
                                    gradientEnd:CGPointMake(1, 0.5)];
    }else if (btn.tag == 505) {
        //圆角+边框+阴影
        [self.lab kw_setupLayerWithRoundCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft
                                    roundRadius:35
                                    borderWidth:5
                                    borderColor:[UIColor blackColor]
                                    shadowColor:[UIColor redColor]
                                   shadowOffset:CGSizeMake(2, 2)
                                  shadowOpacity:0.6
                                   shadowRadius:5
                                 gradientColors:@[]
                                  gradientStart:CGPointZero
                                    gradientEnd:CGPointZero];
        [self.btn kw_setupLayerWithRoundCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft
                                    roundRadius:35
                                    borderWidth:5
                                    borderColor:[UIColor blackColor]
                                    shadowColor:[UIColor redColor]
                                   shadowOffset:CGSizeMake(2, 2)
                                  shadowOpacity:0.6
                                   shadowRadius:5
                                 gradientColors:@[]
                                  gradientStart:CGPointZero
                                    gradientEnd:CGPointZero];
    }else if (btn.tag == 506) {
        //圆角+边框+渐变
        [self.lab kw_setupLayerWithRoundCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft
                                    roundRadius:35
                                    borderWidth:5
                                    borderColor:[UIColor blackColor]
                                    shadowColor:[UIColor clearColor]
                                   shadowOffset:CGSizeZero
                                  shadowOpacity:0
                                   shadowRadius:0
                                 gradientColors:@[[UIColor redColor],[UIColor blueColor]]
                                  gradientStart:CGPointMake(0, 0.5)
                                    gradientEnd:CGPointMake(1, 0.5)];
        [self.btn kw_setupLayerWithRoundCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft
                                    roundRadius:35
                                    borderWidth:5
                                    borderColor:[UIColor blackColor]
                                    shadowColor:[UIColor clearColor]
                                   shadowOffset:CGSizeZero
                                  shadowOpacity:0
                                   shadowRadius:0
                                 gradientColors:@[[UIColor redColor],[UIColor blueColor]]
                                  gradientStart:CGPointMake(0, 0.5)
                                    gradientEnd:CGPointMake(1, 0.5)];
    }else if (btn.tag == 507) {
        //圆角+阴影+渐变
        [self.lab kw_setupLayerWithRoundCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft
                                    roundRadius:35
                                    borderWidth:0
                                    borderColor:[UIColor clearColor]
                                    shadowColor:[UIColor redColor]
                                   shadowOffset:CGSizeMake(2, 2)
                                  shadowOpacity:0.6
                                   shadowRadius:5
                                 gradientColors:@[[UIColor redColor],[UIColor blueColor]]
                                  gradientStart:CGPointMake(0, 0.5)
                                    gradientEnd:CGPointMake(1, 0.5)];
        [self.btn kw_setupLayerWithRoundCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft
                                    roundRadius:35
                                    borderWidth:0
                                    borderColor:[UIColor clearColor]
                                    shadowColor:[UIColor redColor]
                                   shadowOffset:CGSizeMake(2, 2)
                                  shadowOpacity:0.6
                                   shadowRadius:5
                                 gradientColors:@[[UIColor redColor],[UIColor blueColor]]
                                  gradientStart:CGPointMake(0, 0.5)
                                    gradientEnd:CGPointMake(1, 0.5)];
    }else if (btn.tag == 508) {
        //圆角+边框+阴影+渐变
        [self.lab kw_setupLayerWithRoundCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft
                                    roundRadius:35
                                    borderWidth:5
                                    borderColor:[UIColor blackColor]
                                    shadowColor:[UIColor redColor]
                                   shadowOffset:CGSizeMake(2, 2)
                                  shadowOpacity:0.6
                                   shadowRadius:5
                                 gradientColors:@[[UIColor redColor],[UIColor blueColor]]
                                  gradientStart:CGPointMake(0, 0.5)
                                    gradientEnd:CGPointMake(1, 0.5)];
        [self.btn kw_setupLayerWithRoundCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft
                                    roundRadius:35
                                    borderWidth:5
                                    borderColor:[UIColor blackColor]
                                    shadowColor:[UIColor redColor]
                                   shadowOffset:CGSizeMake(2, 2)
                                  shadowOpacity:0.6
                                   shadowRadius:5
                                 gradientColors:@[[UIColor redColor],[UIColor blueColor]]
                                  gradientStart:CGPointMake(0, 0.5)
                                    gradientEnd:CGPointMake(1, 0.5)];
    }else if (btn.tag == 509) {
        //边框
        [self.lab kw_setupLayerWithRoundCorners:UIRectCornerAllCorners
                                    roundRadius:0
                                    borderWidth:5
                                    borderColor:[UIColor blackColor]
                                    shadowColor:[UIColor clearColor]
                                   shadowOffset:CGSizeZero
                                  shadowOpacity:0
                                   shadowRadius:0
                                 gradientColors:@[]
                                  gradientStart:CGPointZero
                                    gradientEnd:CGPointZero];
        [self.btn kw_setupLayerWithRoundCorners:UIRectCornerAllCorners
                                    roundRadius:0
                                    borderWidth:5
                                    borderColor:[UIColor blackColor]
                                    shadowColor:[UIColor clearColor]
                                   shadowOffset:CGSizeZero
                                  shadowOpacity:0
                                   shadowRadius:0
                                 gradientColors:@[]
                                  gradientStart:CGPointZero
                                    gradientEnd:CGPointZero];
    }else if (btn.tag == 510) {
        //边框+阴影
        [self.lab kw_setupLayerWithRoundCorners:UIRectCornerAllCorners
                                    roundRadius:0
                                    borderWidth:5
                                    borderColor:[UIColor blackColor]
                                    shadowColor:[UIColor redColor]
                                   shadowOffset:CGSizeMake(2, 2)
                                  shadowOpacity:0.6
                                   shadowRadius:5
                                 gradientColors:@[]
                                  gradientStart:CGPointZero
                                    gradientEnd:CGPointZero];
        [self.btn kw_setupLayerWithRoundCorners:UIRectCornerAllCorners
                                    roundRadius:0
                                    borderWidth:5
                                    borderColor:[UIColor blackColor]
                                    shadowColor:[UIColor redColor]
                                   shadowOffset:CGSizeMake(2, 2)
                                  shadowOpacity:0.6
                                   shadowRadius:5
                                 gradientColors:@[]
                                  gradientStart:CGPointZero
                                    gradientEnd:CGPointZero];
    }else if (btn.tag == 511) {
        //边框+渐变
        [self.lab kw_setupLayerWithRoundCorners:UIRectCornerAllCorners
                                    roundRadius:0
                                    borderWidth:5
                                    borderColor:[UIColor blackColor]
                                    shadowColor:[UIColor clearColor]
                                   shadowOffset:CGSizeZero
                                  shadowOpacity:0
                                   shadowRadius:0
                                 gradientColors:@[[UIColor redColor],[UIColor blueColor]]
                                  gradientStart:CGPointMake(0, 0.5)
                                    gradientEnd:CGPointMake(1, 0.5)];
        [self.btn kw_setupLayerWithRoundCorners:UIRectCornerAllCorners
                                    roundRadius:0
                                    borderWidth:5
                                    borderColor:[UIColor blackColor]
                                    shadowColor:[UIColor clearColor]
                                   shadowOffset:CGSizeZero
                                  shadowOpacity:0
                                   shadowRadius:0
                                 gradientColors:@[[UIColor redColor],[UIColor blueColor]]
                                  gradientStart:CGPointMake(0, 0.5)
                                    gradientEnd:CGPointMake(1, 0.5)];
    }else if (btn.tag == 512) {
        //边框+阴影+渐变
        [self.lab kw_setupLayerWithRoundCorners:UIRectCornerAllCorners
                                    roundRadius:0
                                    borderWidth:5
                                    borderColor:[UIColor blackColor]
                                    shadowColor:[UIColor redColor]
                                   shadowOffset:CGSizeMake(2, 2)
                                  shadowOpacity:0.6
                                   shadowRadius:5
                                 gradientColors:@[[UIColor redColor],[UIColor blueColor]]
                                  gradientStart:CGPointMake(0, 0.5)
                                    gradientEnd:CGPointMake(1, 0.5)];
        [self.btn kw_setupLayerWithRoundCorners:UIRectCornerAllCorners
                                    roundRadius:0
                                    borderWidth:5
                                    borderColor:[UIColor blackColor]
                                    shadowColor:[UIColor redColor]
                                   shadowOffset:CGSizeMake(2, 2)
                                  shadowOpacity:0.6
                                   shadowRadius:5
                                 gradientColors:@[[UIColor redColor],[UIColor blueColor]]
                                  gradientStart:CGPointMake(0, 0.5)
                                    gradientEnd:CGPointMake(1, 0.5)];
    }else if (btn.tag == 513) {
        //阴影
        [self.lab kw_setupLayerWithRoundCorners:UIRectCornerAllCorners
                                    roundRadius:0
                                    borderWidth:0
                                    borderColor:[UIColor clearColor]
                                    shadowColor:[UIColor redColor]
                                   shadowOffset:CGSizeMake(2, 2)
                                  shadowOpacity:0.6
                                   shadowRadius:5
                                 gradientColors:@[]
                                  gradientStart:CGPointZero
                                    gradientEnd:CGPointZero];
        [self.btn kw_setupLayerWithRoundCorners:UIRectCornerAllCorners
                                    roundRadius:0
                                    borderWidth:0
                                    borderColor:[UIColor clearColor]
                                    shadowColor:[UIColor redColor]
                                   shadowOffset:CGSizeMake(2, 2)
                                  shadowOpacity:0.6
                                   shadowRadius:5
                                 gradientColors:@[]
                                  gradientStart:CGPointZero
                                    gradientEnd:CGPointZero];
    }else if (btn.tag == 514) {
        //阴影+渐变
        [self.lab kw_setupLayerWithRoundCorners:UIRectCornerAllCorners
                                    roundRadius:0
                                    borderWidth:0
                                    borderColor:[UIColor clearColor]
                                    shadowColor:[UIColor redColor]
                                   shadowOffset:CGSizeMake(2, 2)
                                  shadowOpacity:0.6
                                   shadowRadius:5
                                 gradientColors:@[[UIColor redColor],[UIColor blueColor]]
                                  gradientStart:CGPointMake(0, 0.5)
                                    gradientEnd:CGPointMake(1, 0.5)];
        [self.btn kw_setupLayerWithRoundCorners:UIRectCornerAllCorners
                                    roundRadius:0
                                    borderWidth:0
                                    borderColor:[UIColor clearColor]
                                    shadowColor:[UIColor redColor]
                                   shadowOffset:CGSizeMake(2, 2)
                                  shadowOpacity:0.6
                                   shadowRadius:5
                                 gradientColors:@[[UIColor redColor],[UIColor blueColor]]
                                  gradientStart:CGPointMake(0, 0.5)
                                    gradientEnd:CGPointMake(1, 0.5)];
    }else if (btn.tag == 515) {
        //渐变
        [self.lab kw_setupLayerWithRoundCorners:UIRectCornerAllCorners
                                    roundRadius:0
                                    borderWidth:0
                                    borderColor:[UIColor clearColor]
                                    shadowColor:[UIColor clearColor]
                                   shadowOffset:CGSizeZero
                                  shadowOpacity:0
                                   shadowRadius:0
                                 gradientColors:@[[UIColor redColor],[UIColor blueColor]]
                                  gradientStart:CGPointMake(0, 0.5)
                                    gradientEnd:CGPointMake(1, 0.5)];
        [self.btn kw_setupLayerWithRoundCorners:UIRectCornerAllCorners
                                    roundRadius:0
                                    borderWidth:0
                                    borderColor:[UIColor clearColor]
                                    shadowColor:[UIColor clearColor]
                                   shadowOffset:CGSizeZero
                                  shadowOpacity:0
                                   shadowRadius:0
                                 gradientColors:@[[UIColor redColor],[UIColor blueColor]]
                                  gradientStart:CGPointMake(0, 0.5)
                                    gradientEnd:CGPointMake(1, 0.5)];
    }
}





@end
