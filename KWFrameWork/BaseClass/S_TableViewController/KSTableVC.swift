//
//  KSTableVC.swift
//  KW
//
//  Created by 渴望 on 2023/6/25.
//

import UIKit

private let defalutPage = 1

class KSTableVC: KSViewController {

    ///默认sectionHeader不悬停 可在【kw_initData】中修改
    public var style: UITableView.Style = .plain
    
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
            tableView.kw_header = nil
        } else {
            tableView.kw_refreshHeader { [weak self] in
                self?.kw_refreshData()
            }
        }
        if !isAddRefreshFooter {
            tableView.kw_footer = nil
        } else {
            tableView.kw_refreshFooter { [weak self] in
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
                self.tableView.kw_footer?.endRefreshingWithNoMoreData()
            } else {
                self.tableView.kw_footer?.resetNoMoreData()
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
        view.addSubview(tableView)
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
    public final func kw_tableViewReloadData() {
        tableView.kw_endRefresh() //停止刷新加载动画
        tableView.reloadData() //刷新UITableView
        if page >= pageCount ?? defalutPage {
            self.tableView.kw_footer?.endRefreshingWithNoMoreData()
        } else {
            self.tableView.kw_footer?.resetNoMoreData()
        }
    }
    
    
    lazy var tableView:UITableView =  {
        let table = UITableView.init(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: KScreenHeight), style: style)
        table.dataSource = self
        table.delegate = self
        table.emptyDataSetSource = self
        table.emptyDataSetDelegate = self
        table.backgroundColor = .KW_L(.background)
        table.separatorStyle = .none
        table.tableFooterView = UIView()
        table.tableHeaderView = UIView.init(frame: CGRect.init(origin: .zero, size: CGSize(width: 1, height: CGFloat.leastNormalMagnitude)))
        table.estimatedSectionHeaderHeight = 0
        table.estimatedSectionFooterHeight = 0
        if #available(iOS 11.0, *) {
            table.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        if #available(iOS 15.0, *) {
            table.sectionHeaderTopPadding = 0
        }
        table.kw_register(cell: KSTableCell.self, isXib: false)
        return table
    }()
    
    
    
    lazy var DataArr: [[KSTableCellItem]] = {
        let datas = [[KSTableCellItem]]()
        return datas
    }()
    lazy var Section0Arr: [KSTableCellItem] = {
        let section = [KSTableCellItem]()
        return section
    }()
    lazy var Section1Arr: [KSTableCellItem] = {
        let section = [KSTableCellItem]()
        return section
    }()
    lazy var Section2Arr: [KSTableCellItem] = {
        let section = [KSTableCellItem]()
        return section
    }()
    lazy var Section3Arr: [KSTableCellItem] = {
        let section = [KSTableCellItem]()
        return section
    }()
    lazy var Section4Arr: [KSTableCellItem] = {
        let section = [KSTableCellItem]()
        return section
    }()
    lazy var Section5Arr: [KSTableCellItem] = {
        let section = [KSTableCellItem]()
        return section
    }()
    lazy var Section6Arr: [KSTableCellItem] = {
        let section = [KSTableCellItem]()
        return section
    }()
    lazy var Section7Arr: [KSTableCellItem] = {
        let section = [KSTableCellItem]()
        return section
    }()
    lazy var Section8Arr: [KSTableCellItem] = {
        let section = [KSTableCellItem]()
        return section
    }()
    lazy var Section9Arr: [KSTableCellItem] = {
        let section = [KSTableCellItem]()
        return section
    }()
    
}


extension KSTableVC: UITableViewDelegate, UITableViewDataSource, KSTableViewCellDelegate {
// MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return DataArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataArr[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = DataArr[indexPath.section][indexPath.row]
        let cell = tableView.kw_dequeue(cell: item.cellClass, for: indexPath) as! KSTableCell
        //let cell = tableView.dequeueReusableCell(withIdentifier: item.cellIdentifier, for: indexPath) as! KWTableViewCell
        cell.item = item
        
        cell.delegate = self
        return cell
    }
    
// MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item: KSTableCellItem = DataArr[indexPath.section][indexPath.row]
        return item.cellHeight > 0 ? item.cellHeight : UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}




//MARK: Register
public extension UITableView {
    
    func kw_register(cell: AnyClass ,isXib:Bool) {
        if isXib {
            let cellXibStr = NSStringFromClass(cell)
            let nibNameArr = cellXibStr.components(separatedBy: ".")
            self.register(UINib.init(nibName: nibNameArr.last!, bundle: Bundle.main), forCellReuseIdentifier: NSStringFromClass(cell))
        }else{
            self.register(cell, forCellReuseIdentifier: NSStringFromClass(cell))
        }
    }
    
    
    func kw_register(view: AnyClass ,isXib:Bool) {
        if isXib {
            let cellXibStr = NSStringFromClass(view)
            let nibNameArr = cellXibStr.components(separatedBy: ".")
            self.register(UINib.init(nibName: nibNameArr.last!, bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: NSStringFromClass(view))
        }else{
            self.register(view, forHeaderFooterViewReuseIdentifier: NSStringFromClass(view))
        }
    }
    
    func kw_dequeue<T: UITableViewCell>(cell: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: NSStringFromClass(cell), for: indexPath) as! T
    }
    
    func kw_dequeue<T: UITableViewHeaderFooterView>(view: T.Type) -> T {
        return self.dequeueReusableHeaderFooterView(withIdentifier: NSStringFromClass(view)) as! T
    }
}

