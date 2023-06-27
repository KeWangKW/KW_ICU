//
//  KOTableVC.m
//  KW
//
//  Created by 渴望 on 2023/6/27.
//

#import "KOTableVC.h"

@interface KOTableVC ()

@end

@implementation KOTableVC

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
    self.style = UITableViewStylePlain;
    self.page = 1;
    self.pageCount = 1;
    self.isAddRefreshHeader = false;
    self.isAddRefreshFooter = false;
}

- (void)kw_initUI{
    [super kw_initUI];
    [self.view addSubview:self.tableView];
    
   
    
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

- (void)kw_tableViewReloadData{
    [self.tableView kw_endRefresh];
    [self.tableView reloadData];
    
    if (self.page >= self.pageCount) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }else{
        [self.tableView.mj_footer resetNoMoreData];
    }
}

- (void)setupMJRefreshUI {
    __weak typeof(self) weakSelf = self;
    if (self.isAddRefreshHeader) {
        self.tableView.mj_header = [RefreshHeader headerWithRefreshingBlock:^{
            [weakSelf kw_refreshData];
        }];
    }else{
        self.tableView.mj_header = nil;
    }
    
    if (self.isAddRefreshFooter) {
        self.tableView.mj_footer = [RefreshFooter2 footerWithRefreshingBlock:^{
            [weakSelf kw_loadMoreData];
        }];
    }else{
        self.tableView.mj_footer = nil;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.DataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.DataArr[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KOTableCellItem *item = self.DataArr[indexPath.section][indexPath.row];
    //KWOCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:item.cellIdentifier forIndexPath:indexPath];
    KOTableCell * cell = [tableView dequeueReusableCellWithIdentifier:item.cellIdentifier forIndexPath:indexPath];
    if(cell ==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:item.cellIdentifier];
    }

    cell.item = item;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return ({
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor whiteColor];
        view;
    });
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return ({
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor whiteColor];
        view;
    });
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    KOTableCellItem *item = self.DataArr[indexPath.section][indexPath.row];
    if (item.cellHeight > 0) {
        return item.cellHeight;
    }else {
        return UITableViewAutomaticDimension;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}



- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth(), kScreenHeight()) style:self.style];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.backgroundColor = [UIColor KW_L:CustomBackground];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0.1, 0.1)];
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0.1, 0.1)];
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = false;
        }
        if (@available(iOS 15.0, *)) {
            _tableView.sectionHeaderTopPadding = 0;
        }
        [_tableView kw_registerCell:[KOTableCell class]];
    }
    return _tableView;
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end


@implementation UITableView (Category)
- (void)kw_registerCell:(Class _Nullable )cellClass {
    [self registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
}
- (void)kw_registerXibCell:(Class _Nullable )cellClass {
    [self registerNib:[UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil] forCellReuseIdentifier:NSStringFromClass(cellClass)];
}
- (void)kw_registerView:(Class _Nullable )viewClass {
    [self registerClass:viewClass forHeaderFooterViewReuseIdentifier:NSStringFromClass(viewClass)];
}
- (UITableViewCell *)kw_dequeueCell:(Class)cellClass indexPath:(NSIndexPath *)indexPath {
    return [self dequeueReusableCellWithIdentifier:NSStringFromClass([cellClass class]) forIndexPath:indexPath];
}
- (UITableViewHeaderFooterView *)kw_dequeueView:(Class)viewClass {
    return [self dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(viewClass)];
}
@end
