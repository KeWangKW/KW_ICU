//
//  TestCollectionVCShow.swift
//  KW
//
//  Created by 渴望 on 2023/6/28.
//

import UIKit

class TestCollectionVCShow: KSCollectionVC {

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
        
        
        
        
        
        collectionView.kw_register(cell: TestCollectionVCShowCell.self, isXib: true)
    }
    
    override func kw_initUI() {
        super.kw_initUI()
        collectionView.backgroundColor = UIColor.red
        collectionView.frame = CGRect(x: 0, y: KNavigationStatusHeight, width: KScreenWidth, height: KScreenHeight-KNavigationStatusHeight)
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
            let item = TestCollectionVCShowCellItem()
            item.str = string
            DataArr[0].append(item)
        }
        
        kw_collectionViewReloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = DataArr[indexPath.section][indexPath.row] as! TestCollectionVCShowCellItem
        print(item.str)
    }
    

}
