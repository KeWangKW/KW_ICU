//
//  KOCollectionCell.m
//  KW
//
//  Created by 渴望 on 2023/6/30.
//

#import "KOCollectionCell.h"

@implementation KOCollectionCellItem
- (NSString *)cellIdentifier {
    NSString *className = NSStringFromClass([self class]);
    if ([className hasSuffix:@"Item"]) {
        _cellIdentifier = [className substringToIndex:className.length - 4];
    }
    return _cellIdentifier;
}

- (CGSize)cellSize{
    if(CGSizeEqualToSize(_cellSize, CGSizeZero)){
        _cellSize = CGSizeZero;
    }
    return _cellSize;
}

- (Class)cellClass {
    return NSClassFromString(self.cellIdentifier);
}

+ (instancetype)item {
    return [[[self class]alloc] init];
}
@end



@implementation KOCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self kw_setupViews];
        [self kw_setupLayouts];
    }
    return self;
}


- (void)awakeFromNib{
    [super awakeFromNib];
    [self kw_setupViews];
    [self kw_setupLayouts];
}

- (void)kw_setupViews {
    
    
}

- (void)kw_setupLayouts{
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}


#pragma mark - setter
- (void)setItem:(KOCollectionCellItem *)item
{
    _item = item;
    if ([item isMemberOfClass:[KOCollectionCellItem class]]) {
        
    }
    
}

@end
