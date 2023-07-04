//
//  KOPageController.h
//  KW
//
//  Created by 渴望 on 2023/7/4.
//

#import "KOViewController.h"
#import "SizeO.h"
#import <KW-Swift.h>
NS_ASSUME_NONNULL_BEGIN

@interface KOPageController : KOViewController
@property (nonatomic, strong) NSMutableArray *titleArr;
@property (nonatomic, strong) NSMutableArray *vcArr;

@property (nonatomic, strong) KSTitleView * titleView;
@property (nonatomic, strong) UIScrollView *VCScrollView;
@end

NS_ASSUME_NONNULL_END
