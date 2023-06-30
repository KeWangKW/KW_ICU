//
//  TestCollectionViewShow1Cell2.m
//  KWOC
//
//  Created by 渴望 on 2023/6/30.
//

#import "TestCollectionViewShow1Cell2.h"

@implementation TestCollectionViewShow1Cell2Item
- (CGSize)cellSize{
    return CGSizeMake((kScreenWidth()-30)/2, (CGFloat)((arc4random() % 3 + 1) * 30) );
}
@end

@implementation TestCollectionViewShow1Cell2
- (void)setItem:(KOCollectionCellItem *)item{
    [super setItem:item];
    
}

- (void)kw_setupViews{
    [super kw_setupViews];
    self.backgroundColor = UIColor.random;
}

- (void)kw_setupLayouts{
    [super kw_setupLayouts];
    
}
@end
