//
//  TestCollectionViewShow.m
//  KWOC
//
//  Created by 渴望 on 2023/6/30.
//

#import "TestCollectionViewShow.h"
#import "TestCollectionViewShowCell.h"
@interface TestCollectionViewShow ()

@end

@implementation TestCollectionViewShow

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)kw_initData{
    [super kw_initData];
    
    self.emptyDataSetImage = [UIImage imageNamed:@"ic_sxy_searchBG"];
    self.emptyDataSetTitle = @"列表为空";
    self.emptyDataSetDescription = @"暂无数据";
    
    self.isAddRefreshHeader = true;
    self.isAddRefreshFooter = true;
    
    [self.DataArr addObject:self.Section0Arr];
    [self.collectionView kw_registerCell:[TestCollectionViewShowCell class] Xib:YES];
}

- (void)kw_initUI{
    [super kw_initUI];
    self.collectionView.backgroundColor = UIColor.redColor;
    self.collectionView.frame = CGRectMake(0, kNavigationStatusHeight(), kScreenWidth(), kScreenHeight()-kNavigationStatusHeight());
//    self.collectionView.collectionViewLayout = [[KWFlowLayout alloc]init];
}

- (void)kw_requestData{
    [super kw_requestData];
    
    NSString *SSSS = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    // 随机生成字符串
    NSMutableArray *randomStringArr = [NSMutableArray array];
    for (NSInteger i = 0; i < 20; i++) {
        NSMutableString *randomString = [NSMutableString string];
        for (NSInteger j = 0; j < 10; j++) {
            NSInteger index = arc4random_uniform((uint32_t)[SSSS length]); // 随机字符位置
            NSString *randomChar = [SSSS substringWithRange:NSMakeRange(index, 1)]; // 随机字符
            [randomString appendString:randomChar];
        }
        [randomStringArr addObject:randomString];
    }

    
    
    self.pageCount = 3;
    [self refreshCell:randomStringArr];
}


- (void)refreshCell:(NSMutableArray *)arr {
    for (NSString *str in arr) {
        TestCollectionViewShowCellItem * item = [TestCollectionViewShowCellItem item];
        item.str = str;
        [self.DataArr[0] addObject:item];
    }
    
    [self kw_collectionViewReloadData];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TestCollectionViewShowCellItem * item = self.DataArr[indexPath.section][indexPath.row];
    NSLog(@"%@",item.str);
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
