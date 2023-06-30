//
//  KSCollectionVC.swift
//  KW
//
//  Created by 渴望 on 2023/6/28.
//

import UIKit

private let defalutPage = 1

class KSCollectionVC: KSViewController {
    
    ///是否添加下拉刷新功能 可在【kw_initData】中修改
    public var isAddRefreshHeader: Bool = false {
        didSet {
            self.setupMJRefreshUI()
        }
    }
    ///是否添加上拉加载功能 可在【kw_initData】中修改
    public var isAddRefreshFooter: Bool = false {
        didSet {
            self.setupMJRefreshUI()
        }
    }
    
    func setupMJRefreshUI() {
        if !isAddRefreshHeader {
            collectionView.kw_header = nil
        } else {
            collectionView.kw_refreshHeader { [weak self] in
                self?.kw_refreshData()
            }
        }
        if !isAddRefreshFooter {
            collectionView.kw_footer = nil
        } else {
            collectionView.kw_refreshFooter { [weak self] in
                self?.kw_loadMoreData()
            }
        }
    }
    
    ///当前页码数
    public var page:Int = defalutPage
    ///总页码数
    public var pageCount: Int? = defalutPage {
        didSet {
            if page >= pageCount ?? defalutPage {
                self.collectionView.kw_footer?.endRefreshingWithNoMoreData()
            } else {
                self.collectionView.kw_footer?.resetNoMoreData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func kw_initData() {
        super.kw_initData()
        
    }
    
    override func kw_initUI() {
        super.kw_initUI()
        view.addSubview(collectionView)
    }
    
    /// 刷新数据 子类中直接调用kw_requestData()即可
    public func kw_refreshData() {
        
        for idx in 0..<DataArr.count { //清空内部数据
            DataArr[idx].removeAll()
        }
        
        page = defalutPage
        kw_requestData()
    }
    
    /// 加载数据 子类中直接调用kw_requestData()即可
    public func kw_loadMoreData() {
        page = page + 1
        kw_requestData()
    }
    
    /// 更新列表UI
    public final func kw_collectionViewReloadData() {
        collectionView.kw_endRefresh() //停止刷新加载动画
        collectionView.reloadData() //刷新UICollectionView
        if page >= pageCount ?? defalutPage {
            self.collectionView.kw_footer?.endRefreshingWithNoMoreData()
        } else {
            self.collectionView.kw_footer?.resetNoMoreData()
        }
    }
    
    lazy var collectionView: UICollectionView = {
        var layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = .zero
//        layout.sectionHeadersPinToVisibleBounds = true
//        layout.sectionFootersPinToVisibleBounds = true
        
        let collect = UICollectionView(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: KScreenHeight), collectionViewLayout: layout)
        collect.delegate = self
        collect.dataSource = self
        collect.emptyDataSetSource = self
        collect.emptyDataSetDelegate = self
        collect.backgroundColor = .white
        if #available(iOS 11.0, *) {
            collect.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        collect.kw_register(cell: KSCollectionCell.self, isXib: false)
        collect.kw_register(header: UICollectionReusableView.self, isXib: false)
        collect.kw_register(footer: UICollectionReusableView.self, isXib: false)
        return collect
    }()
    

    lazy var DataArr: [[KSCollectionCellItem]] = {
        let datas = [[KSCollectionCellItem]]()
        return datas
    }()
    lazy var Section0Arr: [KSCollectionCellItem] = {
        let section = [KSCollectionCellItem]()
        return section
    }()
    lazy var Section1Arr: [KSCollectionCellItem] = {
        let section = [KSCollectionCellItem]()
        return section
    }()
    lazy var Section2Arr: [KSCollectionCellItem] = {
        let section = [KSCollectionCellItem]()
        return section
    }()
    lazy var Section3Arr: [KSCollectionCellItem] = {
        let section = [KSCollectionCellItem]()
        return section
    }()
    lazy var Section4Arr: [KSCollectionCellItem] = {
        let section = [KSCollectionCellItem]()
        return section
    }()
    lazy var Section5Arr: [KSCollectionCellItem] = {
        let section = [KSCollectionCellItem]()
        return section
    }()
    lazy var Section6Arr: [KSCollectionCellItem] = {
        let section = [KSCollectionCellItem]()
        return section
    }()
    lazy var Section7Arr: [KSCollectionCellItem] = {
        let section = [KSCollectionCellItem]()
        return section
    }()
    lazy var Section8Arr: [KSCollectionCellItem] = {
        let section = [KSCollectionCellItem]()
        return section
    }()
    lazy var Section9Arr: [KSCollectionCellItem] = {
        let section = [KSCollectionCellItem]()
        return section
    }()
}

//MARK: UICollectionViewDataSource
extension KSCollectionVC: UICollectionViewDataSource,KWCollectionViewCellDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return DataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataArr[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = DataArr[indexPath.section][indexPath.row]
        let cell = collectionView.kw_dequeue(cell: item.cellClass, for: indexPath) as! KSCollectionCell
        cell.item = item
        cell.delegate = self
        
        return cell
    }
    
    
}
//MARK: UICollectionViewDelegate
extension KSCollectionVC: UICollectionViewDelegate {
    //cell大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if let layout = collectionViewLayout as? UICollectionViewFlowLayout, layout.itemSize != .zero {
//            return layout.itemSize
//        }
//
//        if indexPath.section == DataArr.count {
//            return .zero
//        }
        
        let item = DataArr[indexPath.section][indexPath.row]
        return item.cellSize
    }
    
//header 、footer
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        /* 覆写使用示例
        if kind == UICollectionView.elementKindSectionHeader {
            let view = collectionView.kw_dequeue(footer: UICollectionReusableView.self, for: indexPath) as! BOtherHeadView
        }
         */
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: UICollectionReusableView.self), for: indexPath)
        view.backgroundColor = .white
        return view
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return .zero
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .zero
    }
}

//MARK: UICollectionViewDelegateFlowLayout
extension KSCollectionVC: UICollectionViewDelegateFlowLayout {
//section 边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
//cell 列间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
//cell 行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
}

//MARK: Register
public extension UICollectionView {
    
    func kw_register(cell: AnyClass ,isXib:Bool) {
        if isXib {
            let str = NSStringFromClass(cell)
            let ssArr = str.components(separatedBy: ".")
            let newStr = ssArr.last!
            self.register(UINib.init(nibName: newStr, bundle: nil), forCellWithReuseIdentifier: NSStringFromClass(cell))
        }else{
            self.register(cell, forCellWithReuseIdentifier: NSStringFromClass(cell))
        }
    }
    
    func kw_register(header view: AnyClass ,isXib:Bool) {
        if isXib {
            let str = NSStringFromClass(view)
            let ssArr = str.components(separatedBy: ".")
            let newStr = ssArr.last!
            self.register(UINib.init(nibName: newStr, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NSStringFromClass(view))
        }else{
            self.register(view, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                          withReuseIdentifier: NSStringFromClass(view))
        }
    }
    
    func kw_register(footer view: AnyClass ,isXib:Bool) {
        if isXib {
            let str = NSStringFromClass(view)
            let ssArr = str.components(separatedBy: ".")
            let newStr = ssArr.last!
            self.register(UINib.init(nibName: newStr, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: NSStringFromClass(view))
        }else{
            self.register(view, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                          withReuseIdentifier: NSStringFromClass(view))
        }
    }
    
    func kw_dequeue<T: UICollectionViewCell>(cell: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(cell), for: indexPath) as! T
    }
    
    func kw_dequeue<T: UICollectionReusableView>(header view: T.Type, for indexPath: IndexPath) -> T {
        self.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                              withReuseIdentifier: NSStringFromClass(view), for: indexPath) as! T
    }
    
    func kw_dequeue<T: UICollectionReusableView>(footer view: T.Type, for indexPath: IndexPath) -> T {
        self.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                              withReuseIdentifier: NSStringFromClass(view), for: indexPath) as! T
    }
}


