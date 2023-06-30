//
//  TestCollectionVCShowCell1Item.swift
//  KW
//
//  Created by 渴望 on 2023/6/29.
//

import UIKit

class TestCollectionVCShowCell1Item: KSCollectionCellItem {
    override var cellSize: CGSize {
        get {
            return CGSize(width: (KScreenWidth-30)/2, height: CGFloat((arc4random() % 3 + 1) * 30))
        } set{}
    }
    var str:String = ""
}

class TestCollectionVCShowCell1: KSCollectionCell {
    override var item: KSCollectionCellItem!{
        didSet{
            let i = item as! TestCollectionVCShowCell1Item
            //let mo = item.cellModel as! BPDDDModel
            //xibLab.text = i.str
        }
    }
    
    override func kw_setupViews() {
        super.kw_setupViews()
        self.backgroundColor = .random
        
    }
    
    override func kw_setupLayouts() {
        super.kw_setupLayouts()
        
    }
}
