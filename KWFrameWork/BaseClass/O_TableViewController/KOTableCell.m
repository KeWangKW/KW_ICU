//
//  KOTableCell.m
//  KW
//
//  Created by 渴望 on 2023/6/27.
//

#import "KOTableCell.h"

@implementation KOTableCellItem

- (NSString *)cellIdentifier {
    NSString *className = NSStringFromClass([self class]);
    if ([className hasSuffix:@"Item"]) {
        _cellIdentifier = [className substringToIndex:className.length - 4];
    }
    return _cellIdentifier;
}

- (CGFloat)cellHeight {
    if (!_cellHeight) {
        _cellHeight = 0.f;
    }
    return _cellHeight;
}

- (Class)cellClass {
    return NSClassFromString(self.cellIdentifier);
}

+ (instancetype)item {
    return [[[self class]alloc] init];
}

@end


@implementation KOTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
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
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)kw_setupLayouts{
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}


#pragma mark - setter
- (void)setItem:(KOTableCellItem *)item
{
    _item = item;
    if ([item isMemberOfClass:[KOTableCellItem class]]) {

    }
    
}



@end
