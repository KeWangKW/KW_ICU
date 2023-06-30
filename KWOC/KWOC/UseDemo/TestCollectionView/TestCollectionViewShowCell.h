//
//  TestCollectionViewShowCell.h
//  KWOC
//
//  Created by 渴望 on 2023/6/30.
//

#import "KOCollectionCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface TestCollectionViewShowCellItem : KOCollectionCellItem
@property (nonatomic, copy) NSString *str;
@end

@interface TestCollectionViewShowCell : KOCollectionCell
@property (weak, nonatomic) IBOutlet UILabel *xibLab;
@end

NS_ASSUME_NONNULL_END
