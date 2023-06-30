//
//  TestCollectionVCShowCell.swift
//  KW
//
//  Created by 渴望 on 2023/6/28.
//

import UIKit

class TestCollectionVCShowCellItem: KSCollectionCellItem {
    override var cellSize: CGSize {
        get {
//            return CGSize(width: KScreenWidth/3, height: KScreenWidth)
            return CGSize(width: (KScreenWidth-40)/3, height: CGFloat((arc4random() % 3 + 1) * 30))
        } set{}
    }
    var str:String = ""
}

class TestCollectionVCShowCell: KSCollectionCell {

    @IBOutlet weak var xibLab: UILabel!
    
    override var item: KSCollectionCellItem!{
        didSet{
            let i = item as! TestCollectionVCShowCellItem
            //let mo = item.cellModel as! BPDDDModel
            xibLab.text = i.str
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
