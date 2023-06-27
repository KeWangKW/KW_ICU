//
//  KOTableCell.h
//  KW
//
//  Created by 渴望 on 2023/6/27.
//

#import <UIKit/UIKit.h>
#import <KW-Swift.h>

@class KSModel;
NS_ASSUME_NONNULL_BEGIN

@interface KOTableCellItem : NSObject
/** 标识 */
@property (nonatomic, strong) NSString *cellIdentifier;
/** 数据源 */
@property (nonatomic, strong) KSModel *cellModel;
/** 高度 */
@property (nonatomic, assign) CGFloat cellHeight;
/** 缓存标识 */
@property (nonatomic, copy) NSString *cacheKey;
/** 当前class */
@property (nonatomic, weak, readwrite) Class cellClass;
/** 初始化 */
+ (instancetype)item;

/** 标题 */
@property (nonatomic, strong) NSString *title;
/** 图片 */
@property (nonatomic, strong) NSString *imageName;
@end



@interface KOTableCell : UITableViewCell
/** 赋值item */
@property (nonatomic, strong) KOTableCellItem *item;

/** 初始化UI */
- (void)kw_setupViews;
- (void)kw_setupLayouts;

@end

NS_ASSUME_NONNULL_END
