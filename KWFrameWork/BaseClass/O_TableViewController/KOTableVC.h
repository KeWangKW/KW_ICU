//
//  KOTableVC.h
//  KW
//
//  Created by 渴望 on 2023/6/27.
//

#import "KOViewController.h"
#import "SizeO.h"
#import <KW-Swift.h>
#import "KOTableCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface KOTableVC : KOViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) int page;
@property (nonatomic, assign) int pageCount;
@property (nonatomic, assign) BOOL isAddRefreshHeader;
@property (nonatomic, assign) BOOL isAddRefreshFooter;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) UITableViewStyle style;

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

- (void)kw_tableViewReloadData;
@end


@interface UITableView (Category)
- (void)kw_registerCell:(Class _Nullable )cellClass;
- (void)kw_registerXibCell:(Class _Nullable )cellClass;
- (void)kw_registerView:(Class _Nullable )viewClass;
- (UITableViewCell *)kw_dequeueCell:(Class)cellClass indexPath:(NSIndexPath *)indexPath;
- (UITableViewHeaderFooterView *)kw_dequeueView:(Class)viewClass;
@end

NS_ASSUME_NONNULL_END
