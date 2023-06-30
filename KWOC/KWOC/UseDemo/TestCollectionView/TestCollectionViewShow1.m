//
//  TestCollectionViewShow1.m
//  KWOC
//
//  Created by 渴望 on 2023/6/30.
//

#import "TestCollectionViewShow1.h"
#import "TestCollectionViewShow1Cell2.h"
#import "TestCollectionViewShow1Cell1.h"
#import "TestCollectionHeadFoot.h"

@interface TestCollectionViewShow1 ()

@end

@implementation TestCollectionViewShow1

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
    [self.DataArr addObject:self.Section1Arr];
    [self.collectionView kw_registerCell:[TestCollectionViewShow1Cell1 class] Xib:YES];
    [self.collectionView kw_registerCell:[TestCollectionViewShow1Cell2 class] Xib:NO];
    [self.collectionView kw_registerHeader:[TestCollectionHeadFoot class] Xib:YES];
    [self.collectionView kw_registerFooter:[TestCollectionHeadFoot class] Xib:YES];
}

- (void)kw_initUI{
    [super kw_initUI];
    self.collectionView.backgroundColor = UIColor.redColor;
    self.collectionView.frame = CGRectMake(0, kNavigationStatusHeight(), kScreenWidth(), kScreenHeight()-kNavigationStatusHeight());
    
    KWFlowLayout * layout = [[KWFlowLayout alloc]init];
    layout.stickyHeaders = @[@0,@1];
    //layout.stickyAllHeader = YES;
    self.collectionView.collectionViewLayout = layout;
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
    
    if (self.page == 1) {
        for (NSString *str in arr) {
            TestCollectionViewShow1Cell1Item * item = [TestCollectionViewShow1Cell1Item item];
            item.str = str;
            [self.DataArr[0] addObject:item];
        }
    }
    
    for (NSString *str in arr) {
        TestCollectionViewShow1Cell2Item * item = [TestCollectionViewShow1Cell2Item item];
        [self.DataArr[1] addObject:item];
    }
    
    [self kw_collectionViewReloadData];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}



- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        TestCollectionHeadFoot * v = (TestCollectionHeadFoot *)[collectionView kw_dequeueHeader:[TestCollectionHeadFoot class] indexPath:indexPath];
        if (indexPath.section == 0) {
            v.lab.text = @"Section0 header view";
        }else{
            v.lab.text = @"Section1 header view";
        }
        v.backgroundColor = UIColor.purpleColor;
        return v;
    }else{
        TestCollectionHeadFoot * v = (TestCollectionHeadFoot *)[collectionView kw_dequeueFooter:[TestCollectionHeadFoot class] indexPath:indexPath];
        if (indexPath.section == 0) {
            v.lab.text = @"Section0 Footer view";
        }else{
            v.lab.text = @"Section1 Footer view";
        }
        v.backgroundColor = UIColor.blueColor;
        return v;
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0){
        return CGSizeMake(kScreenWidth(), 30);
    }else{
        return CGSizeMake(kScreenWidth(), 40);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section == 0){
        return CGSizeMake(kScreenWidth(), 20);
    }else{
        return CGSizeMake(kScreenWidth(), 20);
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}





@end
