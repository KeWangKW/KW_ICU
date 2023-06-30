//
//  KOCollectionVC.m
//  KW
//
//  Created by 渴望 on 2023/6/30.
//

#import "KOCollectionVC.h"


@interface KOCollectionVC ()

@end

@implementation KOCollectionVC

- (void)setIsAddRefreshHeader:(BOOL)isAddRefreshHeader{
    _isAddRefreshHeader = isAddRefreshHeader;
    [self setupMJRefreshUI];
}
- (void)setIsAddRefreshFooter:(BOOL)isAddRefreshFooter{
    _isAddRefreshFooter = isAddRefreshFooter;
    [self setupMJRefreshUI];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)kw_initData{
    [super kw_initData];
    
    self.page = 1;
    self.pageCount = 1;
    self.isAddRefreshHeader = false;
    self.isAddRefreshFooter = false;
}

- (void)kw_initUI{
    [super kw_initUI];
    [self.view addSubview:self.collectionView];
    
   
    
}

- (void)kw_refreshData{
    for (int i=0; i<self.DataArr.count; i++) {
        [self.DataArr[i] removeAllObjects];
    }
    self.page = 1;
    [self kw_requestData];
}

- (void)kw_loadMoreData{
    self.page += 1;
    [self kw_requestData];
}

- (void)kw_collectionViewReloadData{
    [self.collectionView kw_endRefresh];
    [self.collectionView reloadData];
    
    if (self.page >= self.pageCount) {
        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
    }else{
        [self.collectionView.mj_footer resetNoMoreData];
    }
}

- (void)setupMJRefreshUI {
    __weak typeof(self) weakSelf = self;
    if (self.isAddRefreshHeader) {
        self.collectionView.mj_header = [RefreshHeader headerWithRefreshingBlock:^{
            [weakSelf kw_refreshData];
        }];
    }else{
        self.collectionView.mj_header = nil;
    }
    
    if (self.isAddRefreshFooter) {
        self.collectionView.mj_footer = [RefreshFooter2 footerWithRefreshingBlock:^{
            [weakSelf kw_loadMoreData];
        }];
    }else{
        self.collectionView.mj_footer = nil;
    }
}



- (UICollectionView *)collectionView{
    if(!_collectionView){
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeZero;
//        layout.sectionHeadersPinToVisibleBounds = YES;
//        layout.sectionFootersPinToVisibleBounds = YES;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth(), kScreenHeight()) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.emptyDataSetSource = self;
        _collectionView.emptyDataSetDelegate = self;
        _collectionView.backgroundColor = UIColor.whiteColor;
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        if (@available(iOS 13.0, *)) {
            _collectionView.automaticallyAdjustsScrollIndicatorInsets = NO;
        }
        
        [_collectionView kw_registerCell:[KOCollectionCell class] Xib:NO];
        [_collectionView kw_registerHeader:[UICollectionReusableView class] Xib:NO];
        [_collectionView kw_registerFooter:[UICollectionReusableView class] Xib:NO];
    }
    return _collectionView;
}

- (NSMutableArray *)DataArr{
    if(!_DataArr){
        _DataArr = [[NSMutableArray alloc]init];
    }
    return _DataArr;
}

- (NSMutableArray *)Section0Arr{
    if(!_Section0Arr){
        _Section0Arr = [[NSMutableArray alloc]init];
    }
    return _Section0Arr;
}

- (NSMutableArray *)Section1Arr{
    if(!_Section1Arr){
        _Section1Arr = [[NSMutableArray alloc]init];
    }
    return _Section1Arr;
}

- (NSMutableArray *)Section2Arr{
    if(!_Section2Arr){
        _Section2Arr = [[NSMutableArray alloc]init];
    }
    return _Section2Arr;
}

- (NSMutableArray *)Section3Arr{
    if(!_Section3Arr){
        _Section3Arr = [[NSMutableArray alloc]init];
    }
    return _Section3Arr;
}

- (NSMutableArray *)Section4Arr{
    if(!_Section4Arr){
        _Section4Arr = [[NSMutableArray alloc]init];
    }
    return _Section4Arr;
}

- (NSMutableArray *)Section5Arr{
    if(!_Section5Arr){
        _Section5Arr = [[NSMutableArray alloc]init];
    }
    return _Section5Arr;
}

- (NSMutableArray *)Section6Arr{
    if(!_Section6Arr){
        _Section6Arr = [[NSMutableArray alloc]init];
    }
    return _Section6Arr;
}

- (NSMutableArray *)Section7Arr{
    if(!_Section7Arr){
        _Section7Arr = [[NSMutableArray alloc]init];
    }
    return _Section7Arr;
}

- (NSMutableArray *)Section8Arr{
    if(!_Section8Arr){
        _Section8Arr = [[NSMutableArray alloc]init];
    }
    return _Section8Arr;
}

- (NSMutableArray *)Section9Arr{
    if(!_Section9Arr){
        _Section9Arr = [[NSMutableArray alloc]init];
    }
    return _Section9Arr;
}

//MARK: UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.DataArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.DataArr[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    KOCollectionCellItem * item = self.DataArr[indexPath.section][indexPath.row];
    KOCollectionCell * cell = (KOCollectionCell *)[collectionView kw_dequeueCell:item.cellClass indexPath:indexPath];

    cell.item = item;
    
    return cell;
}

//MARK: UICollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    //cell大小
    KOCollectionCellItem * item = self.DataArr[indexPath.section][indexPath.row];
    return item.cellSize;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    //header 、footer
    
    /*
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        BOtherHeadView * view =
    }
     */
    UICollectionReusableView * view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([UICollectionReusableView class]) forIndexPath:indexPath];
    view.backgroundColor = UIColor.whiteColor;
    return view;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeZero;
}

//MARK: UICollectionViewDelegateFlowLayout
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    //section 边距
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    //cell 列间距
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    //cell 行间距
    return 0;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end



@implementation UICollectionView (Category)
- (void)kw_registerCell:(Class _Nullable )cellClass Xib:(BOOL)isXib  {
    if (isXib) {
        [self registerNib:[UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(cellClass)];
    }else{
        [self registerClass:cellClass forCellWithReuseIdentifier:NSStringFromClass(cellClass)];
    }
}
- (void)kw_registerHeader:(Class _Nullable )headerClass Xib:(BOOL)isXib {
    if (isXib) {
        [self registerNib:[UINib nibWithNibName:NSStringFromClass(headerClass) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(headerClass)];
    }else{
        [self registerClass:headerClass forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(headerClass)];
    }
}
- (void)kw_registerFooter:(Class _Nullable )footerClass Xib:(BOOL)isXib {
    if (isXib) {
        [self registerNib:[UINib nibWithNibName:NSStringFromClass(footerClass) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass(footerClass)];
    }else{
        [self registerClass:footerClass forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass(footerClass)];
    }
}

- (UICollectionViewCell *)kw_dequeueCell:(Class)cellClass indexPath:(NSIndexPath *)indexPath {
    return [self dequeueReusableCellWithReuseIdentifier:NSStringFromClass([cellClass class]) forIndexPath:indexPath];
}
- (UICollectionReusableView *)kw_dequeueHeader:(Class)viewClass indexPath:(NSIndexPath *)indexPath {
    return [self dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([viewClass class]) forIndexPath:indexPath];
}
- (UICollectionReusableView *)kw_dequeueFooter:(Class)viewClass indexPath:(NSIndexPath *)indexPath {
    return [self dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([viewClass class]) forIndexPath:indexPath];
}
@end
