//
//  TestTableVIewShowCell.swift
//  KW
//
//  Created by 渴望 on 2023/6/25.
//

import UIKit

class TestTableVIewShowCellItem: KSTableCellItem {
    var str:String = ""
    override var cellHeight: CGFloat {
        get{45} set{}
    }
}

class TestTableVIewShowCell: KSTableCell {

    @IBOutlet weak var xibLab: UILabel!
    
    override var item: KSTableCellItem!{
        didSet{
            let i = item as! TestTableVIewShowCellItem
            xibLab.text = i.str
            //let model = item.cellModel as! XXXModel
            //xibLab.text = model.str
        }
    }
    
    override func kw_setupViews() {
        super.kw_setupViews()
        self.backgroundColor = .cyan
    }
    
    override func kw_setupLayouts() {
        super.kw_setupLayouts()
        
    }
    
}
