//
//
//  https://github.com/RoganZheng/WaterfallMultiSectionFlowLayout
//  基于此链接修改
//  去掉原代理，原代理方法的数据由系统方法控制
//  每个section 列数 根据系统方法设置的 cell宽度 和 列表宽度 计算
//  增加sectionHeader悬浮效果

/* 使用：
 
 let layout = KWFlowLayout()
 layout.stickyHeaders = [0,1]
 //layout.stickyAllHeader = true
 collectionView.collectionViewLayout = layout
 
 KWFlowLayout * layout = [[KWFlowLayout alloc]init];
 layout.stickyHeaders = @[@0,@1];
 //layout.stickyAllHeader = YES;
 self.collectionView.collectionViewLayout = layout;
 */

import UIKit

class KWFlowLayout: UICollectionViewFlowLayout {
    
    //控制所有header悬停
    @objc var stickyAllHeader:Bool = false
    //控制某个header可以悬停
    @objc var stickyHeaders: [Int] = []
    
    private var sectionInsets: UIEdgeInsets = .zero
    private var columnCount: Int = 1
    private var lineSpacing: CGFloat = 0
    private var interitemSpacing: CGFloat = 0
    private var headerSize: CGSize = .zero
    private var footerSize: CGSize = .zero
    
    //存放attribute的数组
    private var attrsArray: [UICollectionViewLayoutAttributes] = []
    //存放每个section中各个列的最后一个高度
    private var columnHeights: [CGFloat] = []
    //collectionView的Content的高度
    private var contentHeight: CGFloat = 0
    //记录上个section高度最高一列的高度
    private var lastContentHeight: CGFloat = 0
    
    //存放分组的总高度
    private var sectionAllHeight:[String:CGFloat] = [:]
    //存放header临时滑动高度
    private var headerOffestY:[String:CGFloat] = [:]
    
    override func prepare() {
        super.prepare()
        
        self.contentHeight = 0
        self.lastContentHeight = 0
        self.lineSpacing = 0
        self.sectionInsets = .zero
        self.headerSize = .zero
        self.footerSize = .zero
        self.columnHeights.removeAll()
        self.attrsArray.removeAll()
        
        let sectionCount = self.collectionView!.numberOfSections
        // 遍历section
        for idx in 0..<sectionCount {
            let indexPath = IndexPath(item: 0, section: idx)
            
            if let collectionView = collectionView, let delegateFlowLayout = collectionView.delegate as? UICollectionViewDelegateFlowLayout {
                let size = delegateFlowLayout.collectionView?(collectionView, layout: self, sizeForItemAt: indexPath) ?? CGSize.zero
                if size.width == 0 {
                    self.columnCount = 1
                }else{
                    self.columnCount = Int(self.collectionView!.frame.size.width/size.width)
                }
            }
            
            if let collectionView = collectionView, let delegateFlowLayout = collectionView.delegate as? UICollectionViewDelegateFlowLayout {
                self.sectionInsets = delegateFlowLayout.collectionView?(collectionView, layout: self, insetForSectionAt: 0) ?? UIEdgeInsets.zero
            }
            
            // 生成header
            let itemCount = self.collectionView!.numberOfItems(inSection: idx)
            let headerAttri = self.layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: indexPath)
            if let header = headerAttri {
                self.attrsArray.append(header)
                self.columnHeights.removeAll()
            }
            self.lastContentHeight = self.contentHeight
            // 初始化区 y值
            for _ in 0..<self.columnCount {
                self.columnHeights.append(self.contentHeight)
            }
            // 多少个item
            for item in 0..<itemCount {
                let indexPat = IndexPath(item: item, section: idx)
                let attri = self.layoutAttributesForItem(at: indexPat)
                if let attri = attri {
                    self.attrsArray.append(attri)
                }
            }
            
            // 初始化footer
            let footerAttri = self.layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, at: indexPath)
            if let footer = footerAttri {
                self.attrsArray.append(footer)
            }
        }
        
    }
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        return self.attrsArray
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        if let collectionView = collectionView, let delegateFlowLayout = collectionView.delegate as? UICollectionViewDelegateFlowLayout {
            let size = delegateFlowLayout.collectionView?(collectionView, layout: self, sizeForItemAt: indexPath) ?? CGSize.zero
            if size.width == 0 {
                self.columnCount = 1
            }else{
                self.columnCount = Int(self.collectionView!.frame.size.width/size.width)
            }
        }
        
        if let collectionView = collectionView,
           let delegateFlowLayout = collectionView.delegate as? UICollectionViewDelegateFlowLayout {
            self.lineSpacing = delegateFlowLayout.collectionView?(collectionView, layout: self, minimumLineSpacingForSectionAt: indexPath.section) ?? 0
            self.interitemSpacing = delegateFlowLayout.collectionView?(collectionView, layout: self, minimumInteritemSpacingForSectionAt: indexPath.section) ?? 0
        }
        
        let attri = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        
        let attributes = super.layoutAttributesForItem(at: indexPath)
        let cellWeight: CGFloat = attributes?.frame.size.width ?? 100
        let cellHeight: CGFloat = attributes?.frame.size.height ?? 100
        
        var tmpMinColumn = 0
        var minColumnHeight = self.columnHeights[0]
        for i in 0..<self.columnCount {
            let columnH = self.columnHeights[i]
            if minColumnHeight > columnH {
                minColumnHeight = columnH
                tmpMinColumn = i
            }
        }
        let cellX = self.sectionInsets.left + CGFloat(tmpMinColumn) * (cellWeight + self.interitemSpacing)
        var cellY: CGFloat = 0
        cellY = minColumnHeight
        if cellY != self.lastContentHeight {
            cellY += self.lineSpacing
        }
        
        if self.contentHeight < minColumnHeight {
            self.contentHeight = minColumnHeight
        }
        
        attri.frame = CGRect(x: cellX, y: cellY, width: cellWeight, height: cellHeight)
        self.columnHeights[tmpMinColumn] = attri.frame.maxY
        //取最大的
        for i in 0..<self.columnHeights.count {
            if self.contentHeight < self.columnHeights[i] {
                self.contentHeight = self.columnHeights[i]
            }
        }
        
        attri.zIndex = 0
        
        return attri
    }
    
    
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attri = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: elementKind, with: indexPath)
        if elementKind == UICollectionView.elementKindSectionHeader {
            
            if let collectionView = collectionView,
               let delegateFlowLayout = collectionView.delegate as? UICollectionViewDelegateFlowLayout {
                self.headerSize = delegateFlowLayout.collectionView?(collectionView, layout: self, referenceSizeForHeaderInSection: indexPath.section) ?? CGSize.zero
            }
            
            
            if self.stickyHeaders.contains(indexPath.section) ||
                self.stickyAllHeader == true {
                
                //滚动高度
                let offectY = self.collectionView?.contentOffset.y ?? 0
                //当前 headerView 原始 frame.size.y
                let oldFrameY = self.contentHeight
                //当前整个section高度
                let sectionAllHeight = self.sectionAllHeight[String(format: "%d", indexPath.section)] ?? 0
                
                if offectY > sectionAllHeight && sectionAllHeight != 0 {
                    let old_offectY = self.headerOffestY[String(format: "%d", indexPath.section)] ?? 0
                    attri.frame = CGRect(x: 0, y: old_offectY, width: self.headerSize.width, height: self.headerSize.height)
                    attri.zIndex = 10086
                } else if offectY > oldFrameY {
                    attri.frame = CGRect(x: 0, y: offectY, width: self.headerSize.width, height: self.headerSize.height)
                    attri.zIndex = 10086
                    self.headerOffestY[String(format: "%d", indexPath.section)] = offectY
                }else{
                    attri.frame = CGRect(x: 0, y: self.contentHeight, width: self.headerSize.width, height: self.headerSize.height)
                }
            }else{
                attri.frame = CGRect(x: 0, y: self.contentHeight, width: self.headerSize.width, height: self.headerSize.height)
            }
            
            self.contentHeight += self.headerSize.height
            self.contentHeight += self.sectionInsets.top
            
        } else if elementKind == UICollectionView.elementKindSectionFooter {
            
            if let collectionView = collectionView,
               let delegateFlowLayout = collectionView.delegate as? UICollectionViewDelegateFlowLayout {
                self.footerSize = delegateFlowLayout.collectionView?(collectionView, layout: self, referenceSizeForFooterInSection: indexPath.section) ?? CGSize.zero
            }
            
            //字典存储此时的 self.contentHeight - self.footerSize.height ，这个值就时当前分组的总高度
            self.sectionAllHeight[String(format: "%d", indexPath.section)] = self.contentHeight - self.footerSize.height
            
            self.contentHeight += self.sectionInsets.bottom
            attri.frame = CGRect(x: 0, y: self.contentHeight, width: self.footerSize.width, height: self.footerSize.height)
            self.contentHeight += self.footerSize.height
        }
        return attri
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: self.collectionView!.frame.size.width, height: self.contentHeight)
    }
    
    
    
    func boundaries(forSection section: Int) -> (minimum: CGFloat, maximum: CGFloat)? {
        //保存返回结果
        var result = (minimum: CGFloat(0.0), maximum: CGFloat(0.0))
        
        //如果collectionView属性为nil，则直接fanhui
        guard let collectionView = collectionView else { return result }
        
        //获取该分区中的项目数
        let numberOfItems = collectionView.numberOfItems(inSection: section)
        
        //如果项目数位0，则直接返回
        guard numberOfItems > 0 else { return result }
        
        //从流布局属性中获取第一个、以及最后一个项的布局属性
        let first = IndexPath(item: 0, section: section)
        let last = IndexPath(item: (numberOfItems - 1), section: section)
        if let firstItem = layoutAttributesForItem(at: first),
           let lastItem = layoutAttributesForItem(at: last) {
            //分别获区边界的最小值和最大值
            result.minimum = firstItem.frame.minY
            result.maximum = lastItem.frame.maxY
            
            //将分区都的高度考虑进去，并调整
            result.minimum -= headerReferenceSize.height
            result.maximum -= headerReferenceSize.height
            
            //将分区的内边距考虑进去，并调整
            result.minimum -= sectionInset.top
            result.maximum += (sectionInset.top + sectionInset.bottom)
        }
        
        //返回最终的边界值
        return result
    }
    
    
    //边界发生变化时是否重新布局（视图滚动的时候也会调用）
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
