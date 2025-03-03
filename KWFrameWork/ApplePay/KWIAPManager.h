//
//  KWIAPManager.h
//  Runner
//
//  Created by 渴望 on 2024/1/30.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import <SAMKeychain/SAMKeychain.h>
#import "MBProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

///最终支付结果回调 0-未成功发起支付 1-成功 2-取消 3-失败 4-恢复购买 5-其他
typedef void (^PaymentCompletionHandler)(NSInteger payResult);

@interface KWIAPManager : NSObject

@property (nonatomic, copy) PaymentCompletionHandler completionHandler;
- (void)callCompletionHandlerWithResult:(NSInteger)payResult;

///初始化
+ (instancetype)sharedInstance;

///开始支付
- (void)StartToPayWithProductId:(NSString *)productId
                        orderID:(NSString *)orderID
            applicationUsername:(NSString *)applicationUsername
              completionHandler:(PaymentCompletionHandler)completionHandler;

///是否有未完成交易
- (void)checkUnFinishedOrders;

///删除所有未完成的交易缓存 慎用！ 特殊情况下调用清理
///目前在未发现有未完成交易时也会调用，用于清理交易取消关闭时存储的数据
- (void)removeAll;


@end

NS_ASSUME_NONNULL_END
