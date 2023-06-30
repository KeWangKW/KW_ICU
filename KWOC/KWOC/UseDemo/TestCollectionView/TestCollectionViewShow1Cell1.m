//
//  TestCollectionViewShow1Cell1.m
//  KWOC
//
//  Created by 渴望 on 2023/6/30.
//

#import "TestCollectionViewShow1Cell1.h"

@implementation TestCollectionViewShow1Cell1Item
- (CGSize)cellSize{
    return CGSizeMake((kScreenWidth()-40)/3, (CGFloat)((arc4random() % 3 + 1) * 30) );
}
@end

@implementation TestCollectionViewShow1Cell1

- (void)setItem:(KOCollectionCellItem *)item{
    [super setItem:item];
    
    TestCollectionViewShow1Cell1Item * i = (TestCollectionViewShow1Cell1Item *)item;
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
