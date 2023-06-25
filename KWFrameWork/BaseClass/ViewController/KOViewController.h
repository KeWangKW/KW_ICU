//
//  KWOCViewController.h
//  ShanghaiCard
//
//  Created by 渴望 on 2018/10/31.
//  Copyright © 2018 渴望. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface KOViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *dataArr;

/** 初始化数据 */
- (void)kw_initData;

/** 初始化控件 */
- (void)kw_initUI;

/** 数据请求 */
- (void)kw_requestData;

/** viewwillappear调用 */
- (void)kw_reloadData;


@end

NS_ASSUME_NONNULL_END
