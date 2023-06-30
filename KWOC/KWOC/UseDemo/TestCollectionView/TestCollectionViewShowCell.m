//
//  TestCollectionViewShowCell.m
//  KWOC
//
//  Created by 渴望 on 2023/6/30.
//

#import "TestCollectionViewShowCell.h"

@implementation TestCollectionViewShowCellItem

- (CGSize)cellSize{
//    return CGSizeMake((kScreenWidth()-40)/3, (CGFloat)((arc4random() % 3 + 1) * 30) );
    return CGSizeMake((kScreenWidth()-40)/3, 100);
}

@end

@implementation TestCollectionViewShowCell

- (void)setItem:(KOCollectionCellItem *)item{
    [super setItem:item];
    
    TestCollectionViewShowCellItem * i = (TestCollectionViewShowCellItem *)item;
    self.xibLab.text = i.str;
}

- (void)kw_setupViews{
    [super kw_setupViews];
    self.backgroundColor = UIColor.random;
}

- (void)kw_setupLayouts{
    [super kw_setupLayouts];
    
}

@end
