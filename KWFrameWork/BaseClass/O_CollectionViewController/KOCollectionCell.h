//
//  KOCollectionCell.h
//  KW
//
//  Created by 渴望 on 2023/6/30.
//

#import <UIKit/UIKit.h>
#import <KW-Swift.h>
NS_ASSUME_NONNULL_BEGIN

@interface KOCollectionCellItem : NSObject
/** 标识 */
@property (nonatomic, strong) NSString *cellIdentifier;
/** 数据源 */
@property (nonatomic, strong) KSModel *cellModel;
/** 高度 */
@property (nonatomic, assign) CGSize cellSize;
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


@interface KOCollectionCell : UICollectionViewCell
/** 赋值item */
@property (nonatomic, strong) KOCollectionCellItem *item;

/** 初始化UI */
- (void)kw_setupViews;
- (void)kw_setupLayouts;
@end

NS_ASSUME_NONNULL_END
