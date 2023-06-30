//
//  KOCollectionVC.h
//  KW
//
//  Created by 渴望 on 2023/6/30.
//

#import "KOViewController.h"
#import "SizeO.h"
#import <KW-Swift.h>
#import "KOCollectionCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface KOCollectionVC : KOViewController <UICollectionViewDelegate,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout>
@property (nonatomic, assign) int page;
@property (nonatomic, assign) int pageCount;
@property (nonatomic, assign) BOOL isAddRefreshHeader;
@property (nonatomic, assign) BOOL isAddRefreshFooter;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *DataArr;
@property (nonatomic, strong) NSMutableArray *Section0Arr;
@property (nonatomic, strong) NSMutableArray *Section1Arr;
@property (nonatomic, strong) NSMutableArray *Section2Arr;
@property (nonatomic, strong) NSMutableArray *Section3Arr;
@property (nonatomic, strong) NSMutableArray *Section4Arr;
@property (nonatomic, strong) NSMutableArray *Section5Arr;
@property (nonatomic, strong) NSMutableArray *Section6Arr;
@property (nonatomic, strong) NSMutableArray *Section7Arr;
@property (nonatomic, strong) NSMutableArray *Section8Arr;
@property (nonatomic, strong) NSMutableArray *Section9Arr;

- (void)kw_collectionViewReloadData;
@end



@interface UICollectionView (Category)
- (void)kw_registerCell:(Class _Nullable )cellClass Xib:(BOOL)isXib;
- (void)kw_registerHeader:(Class _Nullable )headerClass Xib:(BOOL)isXib;
- (void)kw_registerFooter:(Class _Nullable )footerClass Xib:(BOOL)isXib;

- (UICollectionView *)kw_dequeueCell:(Class)cellClass indexPath:(NSIndexPath *)indexPath;
- (UICollectionReusableView *)kw_dequeueHeader:(Class)viewClass indexPath:(NSIndexPath *)indexPath;
- (UICollectionReusableView *)kw_dequeueFooter:(Class)viewClass indexPath:(NSIndexPath *)indexPath;
@end



NS_ASSUME_NONNULL_END
