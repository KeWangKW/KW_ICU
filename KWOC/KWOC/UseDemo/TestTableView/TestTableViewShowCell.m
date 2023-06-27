//
//  TestTableViewShowCell.m
//  KWOC
//
//  Created by 渴望 on 2023/6/27.
//

#import "TestTableViewShowCell.h"

@implementation TestTableViewShowCellItem
- (CGFloat)cellHeight{
    return 45;
}
@end

@implementation TestTableViewShowCell


- (void)setItem:(KOTableCellItem *)item{
    [super setItem:item];
    
    TestTableViewShowCellItem * i = (TestTableViewShowCellItem *)item;
    self.xibLab.text = i.str;
    
}

- (void)kw_setupViews{
    [super kw_setupViews];
    self.backgroundColor = UIColor.cyanColor;
}

- (void)kw_setupLayouts{
    [super kw_setupLayouts];
    
}

@end
