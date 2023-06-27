//
//  TestTableVIewShow.swift
//  KW
//
//  Created by 渴望 on 2023/6/25.
//

import UIKit

class TestTableVIewShow: KSTableVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func kw_initData() {
        super.kw_initData()
        
        emptyDataSetImage = UIImage(named: "ic_sxy_searchBG")
        emptyDataSetTitle = "列表为空"
        emptyDataSetDescription = "暂无数据"
        
        isAddRefreshFooter = true
        isAddRefreshHeader = true
        
        DataArr.append(Section0Arr)
        
        style = .plain
        
        tableView.kw_registerXib(cellXib: TestTableVIewShowCell.self)
    }
    
    override func kw_initUI() {
        super.kw_initUI()
        tableView.backgroundColor = UIColor.red
        tableView.frame = CGRect(x: 0, y: KNavigationStatusHeight, width: KScreenWidth, height: KScreenHeight-KNavigationStatusHeight)
    }
    
    override func kw_requestData() {
        super.kw_requestData()
        
        //模拟数据请求
        let SSSS = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomStringArr:[String] = []
        for _ in 1..<20 {
            let ssss = String(SSSS.map { String($0) }.randomElement()!)
            randomStringArr.append(ssss)
        }

        pageCount = 3

        refreshCell(randomStringArr)
    }
    
    func refreshCell(_ arr:[String]) {
        
        for string in arr {
            let item = TestTableVIewShowCellItem()
            item.str = string
            DataArr[0].append(item)
        }
        
        kw_tableViewReloadData()
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = DataArr[indexPath.section][indexPath.row] as! TestTableVIewShowCellItem
        print(item.str)
    }
    
    
}
