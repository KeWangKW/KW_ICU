//
//  KWIAPManager.m
//  Runner
//
//  Created by 渴望 on 2024/1/30.
//

// 由于 StoreKit2 仅支持iOS15之后的版本
// 当前仍然使用 StoreKit1

//#define KCM_Key [NSString stringWithFormat:@"%@dxjdApplePay",[ZZPUtils readUserDefultsDataForKey:@"UserPhone"]]
#define KCM_Key @"jkjl_ApplePay"

#import "KWIAPManager.h"

@interface KWIAPManager () <SKPaymentTransactionObserver, SKProductsRequestDelegate>
@property (nonatomic, copy) NSString * productId;
@property (nonatomic, copy) NSString * orderID;
@property (nonatomic, copy) NSString * applicationUsername;
@property (nonatomic, copy) NSString * receipt;

@property (nonatomic, strong) MBProgressHUD * hud;
@property (nonatomic, assign) BOOL isRegain; //是否正在恢复未完成的交易
@property (nonatomic, assign) BOOL isRecept; //是否是验证未完成的交易
@end

@implementation KWIAPManager

- (void)callCompletionHandlerWithResult:(NSInteger)payResult {
    if (self.completionHandler) {
        self.completionHandler(payResult);
    }
}

#pragma mark - 1 单例模式初始化
static KWIAPManager *sharedInstance = nil;
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        // 初始化操作
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        //[[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
        self.productId = @"";
        self.orderID = @"";
        self.applicationUsername = @"";
        self.receipt = @"";
        
        NSLog(@"🐯🐯 内购初始化 开启监听");
    }
    return self;
}

#pragma mark - 2 发起购买请求
- (void)StartToPayWithProductId:(NSString *)productId
                        orderID:(NSString *)orderID
            applicationUsername:(NSString *)applicationUsername
              completionHandler:(PaymentCompletionHandler)completionHandler {
    
    self.completionHandler = completionHandler;
    
    self.productId = productId;
    self.orderID = orderID;
    //    self.applicationUsername = [NSString stringWithFormat:@"%@%@",applicationUsername,self.orderID];
    self.applicationUsername = applicationUsername;
    
    NSLog(@"🐯🐯 点击开始购买");
    
    if ([SKPaymentQueue canMakePayments]) {
        [self checkUnFinishedOrders];
    } else {
        NSLog(@"🐯🐯 未开启内购权限");
        [self callCompletionHandlerWithResult:0];
        [self showAlert];
    }
    
}

#pragma mark 3 处理未完成交易
- (void)checkUnFinishedOrders {
    NSArray * transactions = [SKPaymentQueue defaultQueue].transactions;
    
    if (transactions.count > 0) {
        NSLog(@"🐯🐯 有未完成的交易 %ld 条",transactions.count);
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"检测到有未完成的交易" message:@"请继续处理" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self showMBProgressHUD:@"交易处理中..."];
            self.isRegain = YES;
            [self changeMBProgressHUDMessage:@"检测到有未完成的交易" Detail:@"正在处理..."];
            [self dealPayResult:transactions];
            
            [self callCompletionHandlerWithResult:0];
            
        }];
        [alert addAction:action];
        UIViewController *rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
        [rootViewController presentViewController:alert animated:YES completion:nil];
        
        return;
    }
    
    
    //有未验证的交易凭证
    NSMutableArray * payArr = [[NSMutableArray alloc]init];
    NSString * jsonString = [SAMKeychain passwordForService:KCM_Key account:KCM_Key];
    if (jsonString.length > 0) {
        NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        payArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            payArr = [[NSMutableArray alloc]init];
        }
    }
    NSMutableArray * dealArr = [[NSMutableArray alloc]init];
    for (NSDictionary * dic in payArr) {
        NSString * receipt = dic[@"receipt"];
        if (receipt != nil || receipt != NULL || receipt.length > 0) {
            [dealArr addObject:dic];
        }
    }
    if (dealArr.count > 0) {
        NSLog(@"🐯🐯 有未验证的交易 %ld 条",transactions.count);
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"检测到有未验证的交易" message:@"请继续验证" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self showMBProgressHUD:@"交易处理中..."];
            self.isRecept = YES;
            [self changeMBProgressHUDMessage:@"检测到有未验证的交易" Detail:@"正在验证..."];
            
            NSDictionary * dic = dealArr.firstObject;
            self.applicationUsername = dic[@"applicationUsername"];
            self.orderID = dic[@"orderID"];
            self.productId = dic[@"productId"];
            self.receipt = dic[@"receipt"];
            [self verifyReceipt:[SKPaymentTransaction new] PayStatus:@"1"];
            
            [self callCompletionHandlerWithResult:0];
            
        }];
        [alert addAction:action];
        UIViewController *rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
        [rootViewController presentViewController:alert animated:YES completion:nil];
        
        return;
    }
    
    
    
    //会存在交易完成，关闭交易，但是未清理缓存的情况
    //无未关闭的交易信息时，清理缓存内的交易信息
    [self removeAll];
    NSLog(@"🐯🐯 无未完成的交易");
    [self startProductsRequest];
}

- (void)startProductsRequest {
    self.isRegain = NO;
    //直接检测未完成交易时不会调用
    if (self.productId.length > 0) {
        [self showMBProgressHUD:@"支付中..."];
        NSLog(@"🐯🐯 开始查询商品信息");
        NSSet *set = [NSSet setWithArray:@[self.productId]];
        SKProductsRequest *productRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:set];
        productRequest.delegate = self;
        [productRequest start];
    }
}

#pragma mark - 4 查询商品信息回调
- (void)productsRequest:(nonnull SKProductsRequest *)request didReceiveResponse:(nonnull SKProductsResponse *)response {
    NSArray *product = response.products;
    if (product.count == 0) {
        NSLog(@"🐯🐯 无法获取商品信息，请重试");
        [self hideMBProgressHUD:@"支付失败" Detail:@"无法获取商品信息，请重试"];
        [self callCompletionHandlerWithResult:0];
    } else {
        NSLog(@"🐯🐯 发起购买请求");
        SKMutablePayment *payment = [SKMutablePayment paymentWithProduct:product[0]];
        payment.applicationUsername = self.applicationUsername;
        payment.productIdentifier = self.productId;
        
        //存储交易信息
        NSDictionary * dic = @{@"applicationUsername":self.applicationUsername,
                               @"orderID": self.orderID,
                               @"productId": self.productId,
                               @"receipt": @""
        };
        [self save:dic];
        
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }
}
//#pragma mark - 查询失败
//- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
//
//}
//#pragma mark - 查询完成
//- (void)requestDidFinish:(SKRequest *)request{
//
//}

#pragma mark 5 购买结果回调
- (void)paymentQueue:(nonnull SKPaymentQueue *)queue updatedTransactions:(nonnull NSArray<SKPaymentTransaction *> *)transactions {
    [self dealPayResult:transactions];
}

- (void)dealPayResult:(NSArray<SKPaymentTransaction *>*)transactions{
    for (SKPaymentTransaction * tran in transactions){
        
        switch (tran.transactionState) {
            case SKPaymentTransactionStatePurchasing:
            {
                NSLog(@"🐯🐯 正在支付");
            }
                break;
            case SKPaymentTransactionStatePurchased:
            {
                NSLog(@"🐯🐯 支付完成");
                [self getReceipt:tran];
            }
                break;
            case SKPaymentTransactionStateRestored:
            {
                NSLog(@"🐯🐯 已经购买过商品，恢复购买");
//                [self verifyReceipt:tran PayStatus:@"1"];
                [self finish:tran];
            }
                break;
            case SKPaymentTransactionStateFailed:
            {
                NSLog(@"🐯🐯 支付失败%@",tran.error);
                [self finish:tran];
            }
                break;
            default:
            {
                NSLog(@"🐯🐯 --");
                [self finish:tran];
            }
                break;
        }
    }
}

#pragma mark 6 获取交易凭证
- (void)getReceipt:(SKPaymentTransaction *)tran {
    
    NSLog(@"🐯🐯 开始获取交易凭证");
    NSURL *receiptUrl = [[NSBundle mainBundle] appStoreReceiptURL];
    if ([[NSFileManager defaultManager] fileExistsAtPath:[receiptUrl path]]) {
        NSData *receiptData = [NSData dataWithContentsOfURL:receiptUrl];
        self.receipt = [receiptData base64EncodedStringWithOptions:0];
        NSLog(@"🐯🐯 交易凭证：%@",self.receipt);
        
        //存储交易信息
        NSDictionary * dic = @{@"applicationUsername":self.applicationUsername,
                               @"orderID": self.orderID,
                               @"productId": self.productId,
                               @"receipt": self.receipt
        };
        [self save:dic];
        
        //验证票据
        [self verifyReceipt:tran PayStatus:@"1"];
        
    } else {
        NSLog(@"Receipt request done but there is no receipt");
    }
}

#pragma mark - 7 验证票据
- (void)verifyReceipt:(SKPaymentTransaction *)tran PayStatus:(NSString *)payStatus{
    
    if (self.isRegain) {
        NSLog(@"🐯🐯 处理未完成的交易时 恢复订单号等信息");
        NSMutableArray * payArr = [[NSMutableArray alloc]init];
        NSString * jsonString = [SAMKeychain passwordForService:KCM_Key account:KCM_Key];
        if (jsonString.length > 0) {
            NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
            NSError *error;
            payArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            if (error) {
                payArr = [[NSMutableArray alloc]init];
            }
        }
        if (payArr.count > 0) {
            for (NSDictionary * paydic in payArr) {
                if ([paydic[@"applicationUsername"] isEqualToString:tran.payment.applicationUsername]) {
                    self.productId = paydic[@"productId"];
                    self.orderID = paydic[@"orderID"];
                    self.applicationUsername = paydic[@"applicationUsername"];
                    
                    break;
                }
            }
        }
    }
    
    NSLog(@"🐯🐯 开始验证票据");
    [self changeMBProgressHUDMessage:@"支付成功" Detail:@"正在验证交易内容..."];
    
    
    /*
    NSDictionary * dic = @{@"ordercode":self.orderID,
                           @"type":@"2",
                           @"paystatus":payStatus,
                           @"errorcode":@"",
                           @"receipt":self.receipt};
    [self.platformChannel invokeMethod:@"verifyReceipt_ios" arguments:dic result:^(id  _Nullable result) {
        if ([result isKindOfClass:[NSNumber class]] && [result boolValue] == YES) {
            NSLog(@"🐯🐯 验证成功");
            [self hideMBProgressHUD:@"验证成功" Detail:@""];
            [self callCompletionHandlerWithResult:1];
            
            //关闭交易
            [self finish:tran];
        }else{
            NSLog(@"🐯🐯 验证失败 %@",KCM_Key);
            [self hideMBProgressHUD:@"验证失败" Detail:@""];
            [self callCompletionHandlerWithResult:5];
            
            //关闭交易
            [self finish:tran];
            
            
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"验证失败" message:@"请重启app查看是否发放会员资格，支付后未开通会员的，\n请及时联系客服!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:action];
            UIViewController *rootViewController = [self xhq_currentController];
            [rootViewController presentViewController:alert animated:YES completion:nil];
            
        }
    }];
     */
    
//    [self.appconfig verifyReceipt:self.receipt orderId:self.orderID resultHandler:^(BOOL result) {
//        if (result) {
//            
//            NSLog(@"🐯🐯 验证成功");
//            [self hideMBProgressHUD:@"验证成功" Detail:@""];
//            [self callCompletionHandlerWithResult:1];
//            
//            //关闭交易
//            [self finish:tran];
//        }else{
//            
//            NSLog(@"🐯🐯 验证失败 %@",KCM_Key);
//            [self hideMBProgressHUD:@"验证失败" Detail:@""];
//            [self callCompletionHandlerWithResult:5];
//            
//        }
//    }];
    
}

#pragma mark - 8 关闭当前交易
- (void)finish:(SKPaymentTransaction *)tran {
    NSLog(@"🐯🐯 关闭交易");
    
    /*
    if (self.isRecept || self.isRegain) {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"为确保您的购买内容准确发放，\n请重启应用!" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:action];
        
        UIViewController *rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
        [rootViewController presentViewController:alert animated:YES completion:nil];
    }
     */
    
    //删除缓存
    [self remove:self.applicationUsername];
    
    //重置数据
    self.productId = @"";
    self.orderID = @"";
    self.applicationUsername = @"";
    self.receipt = @"";
    self.isRegain = NO;
    self.isRecept = NO;
    
    NSLog(@"%ld",[SKPaymentQueue defaultQueue].transactions.count);
    [[SKPaymentQueue defaultQueue] finishTransaction:tran];
    
    if (tran.transactionState == SKPaymentTransactionStatePurchased) {
        //支付完成状态
    } else if (tran.transactionState == SKPaymentTransactionStateRestored) {
        [self hideMBProgressHUD:@"已恢复购买" Detail:@""];
        [self callCompletionHandlerWithResult:4];
    } else if (tran.transactionState == SKPaymentTransactionStateFailed) {
        if (tran.error.code == SKErrorPaymentCancelled) {
            [self hideMBProgressHUD:@"已取消支付" Detail:@""];
            [self callCompletionHandlerWithResult:2];
        } else {
            [self hideMBProgressHUD:@"支付失败" Detail:tran.error.localizedDescription];
            [self callCompletionHandlerWithResult:3];
        }
    } else {
        [self hideMBProgressHUD:@"" Detail:@""];
        [self callCompletionHandlerWithResult:5];
    }
}


#pragma mark - 存储交易信息
- (void)save:(NSDictionary *)dic{
    
    NSMutableArray * payArr = [[NSMutableArray alloc]init];
    NSString * jsonString = [SAMKeychain passwordForService:KCM_Key account:KCM_Key];
    if (jsonString.length > 0) {
        NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        payArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            payArr = [[NSMutableArray alloc]init];
        }
    }
    
    NSLog(@"🐯🐯 存储交易信息 原：%ld条",payArr.count);

    NSMutableArray *itemsToRemove = [NSMutableArray array];
    for (NSDictionary * paydic in payArr) {
        if ([paydic[@"applicationUsername"] isEqualToString:dic[@"applicationUsername"]]) {
            [itemsToRemove addObject:paydic];
        }
    }
    [payArr removeObjectsInArray:itemsToRemove];
    [payArr addObject:dic];
    NSLog(@"🐯🐯 存储交易信息 现：%ld条",payArr.count);
    
    NSError *error1;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:payArr options:NSJSONWritingPrettyPrinted error:&error1];
    NSString *jsonString1 = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [SAMKeychain setPassword:jsonString1 forService:KCM_Key account:KCM_Key];
    
}

#pragma mark - 删除交易信息
- (void)remove:(NSString *)applicationUsername {
    
    NSMutableArray * payArr = [[NSMutableArray alloc]init];
    NSString * jsonString = [SAMKeychain passwordForService:KCM_Key account:KCM_Key];
    if (jsonString.length > 0) {
        NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        payArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            payArr = [[NSMutableArray alloc]init];
        }
    }
    NSLog(@"🐯🐯 删除交易信息 原：%ld条",payArr.count);
    for (NSDictionary * paydic in payArr) {
        if ([paydic[@"applicationUsername"] isEqualToString:applicationUsername]) {
            [payArr removeObject:paydic];
        }
    }
    NSLog(@"🐯🐯 删除交易信息 现：%ld条",payArr.count);
    NSError *error1;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:payArr options:NSJSONWritingPrettyPrinted error:&error1];
    NSString *jsonString1 = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [SAMKeychain setPassword:jsonString1 forService:KCM_Key account:KCM_Key];
}

#pragma mark - 删除所有交易信息
- (void)removeAll {
    [SAMKeychain setPassword:@"" forService:KCM_Key account:KCM_Key];
}


#pragma mark - 加载框
- (void)showMBProgressHUD:(NSString *)text {
    dispatch_async(dispatch_get_main_queue(), ^{
        // 在主线程上访问 MBProgressHUD
        self.hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        self.hud.mode = MBProgressHUDModeIndeterminate;
        self.hud.label.text = text; //
        self.hud.detailsLabel.text = @"";
        self.hud.label.font = [UIFont systemFontOfSize:15 weight:UIFontWeightBold];
        self.hud.detailsLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        [self.hud showAnimated:YES];
    });
}

- (void)changeMBProgressHUDMessage:(NSString *)message Detail:(NSString *)detail {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.hud.label.text = message;
        self.hud.detailsLabel.text = detail;
    });
}

- (void)hideMBProgressHUD:(NSString *)message Detail:(NSString *)detail {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (message.length == 0 && detail.length == 0) {
            [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
            //[self.hud hide:YES];
        }else{
            [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
            //[self.hud hide:YES];
            self.hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
            self.hud.mode = MBProgressHUDModeText;
            self.hud.label.text = message;
            self.hud.detailsLabel.text = detail;
            [self.hud hideAnimated:YES afterDelay:2];
        }
    });
}

#pragma mark - 权限Alert
- (void)showAlert {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您未开启内购权限\n开启方法：在【手机设置】中搜索【内容与隐私限制】，点击【iTunes Store与App Store购买项目】，将【App内购买项目】设置为【允许】" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    
    //UIViewController *rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    UIViewController *rootViewController = [self xhq_currentController];
    [rootViewController presentViewController:alert animated:YES completion:nil];
}


#pragma mark - 获取当前活动控制器
- (UIViewController *)xhq_currentController
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self xhq_currentControllerFrom:rootViewController];
    return currentVC;
}

- (UIViewController *)xhq_currentControllerFrom:(UIViewController *)rootController
{
    UIViewController *currentVC;
    
    if ([rootController presentedViewController])
    {
        rootController = [rootController presentedViewController];
    }
    
    if ([rootController isKindOfClass:[UITabBarController class]])
    {
        currentVC = [self xhq_currentControllerFrom:[(UITabBarController *)rootController selectedViewController]];
    }
    else if ([rootController isKindOfClass:[UINavigationController class]])
    {
        currentVC = [self xhq_currentControllerFrom:[(UINavigationController *)rootController visibleViewController]];
    }
    else
    {
        currentVC = rootController;
    }
    return currentVC;
}


@end


/*
 凭证验证失败时，当前流程正常
 
 需要在获取凭证后再存储，支付前判断有凭证的交易去验证
 
 异常情况下交易完成的，移除系统的交易记录 和 缓存 的交易记录
 
 异常情况下交易完成的，需要去手动刷新用户信息
 */
