//
//  TestTableViewShowCell.h
//  KWOC
//
//  Created by 渴望 on 2023/6/27.
//

#import "KOTableCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface TestTableViewShowCellItem : KOTableCellItem
@property (nonatomic, copy) NSString *str;
@end

@interface TestTableViewShowCell : KOTableCell
@property (weak, nonatomic) IBOutlet UILabel *xibLab;

@end

NS_ASSUME_NONNULL_END
