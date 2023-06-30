//
//  KWTableViewCell.swift
//  BaseSwift
//
//  Created by 渴望 on 2019/6/6.
//  Copyright © 2019 渴望. All rights reserved.
//

import UIKit

//MARK: Protocol、Delegate
protocol KSTabCellItemProtocol {
    associatedtype T
    
    var cellIdentifier: String { get }
    var cellClass: T.Type { get }
    var cellModel: KSModel? { get set }
    
    init(model: KSModel?)
    
    var title: String? { get set }
    var imageName: String? { get set }
}

@objc protocol KSTableViewCellDelegate {
    @objc optional func kw_responseViewInCell(_ cell: KSTableCell, object: Any?)
}

//@objc protocol KWCollectionViewCellDelegate {
//    @objc optional func kw_responseViewInCell(_ cell: KWCollectionViewCell, object: Any?)
//}


// MARK: - KWTableViewCellItem
typealias  BlockCellBtnClick = (Any) ->()
class KSTableCellItem: NSObject, KSTabCellItemProtocol {
    var BtnBlock : BlockCellBtnClick?
    func btnClick(jumpbtnClickBlock:@escaping BlockCellBtnClick) -> Void {
        BtnBlock = jumpbtnClickBlock;
    }
    
    typealias T = UITableViewCell
    final public var cellIdentifier: String {
        let item = "Item"
        let clsName = NSStringFromClass(type(of: self))
        guard clsName.hasSuffix(item) else { return clsName }
        return String(clsName.prefix(clsName.count - item.count))
    }
    
    final public var cellClass: T.Type {
        return NSClassFromString(self.cellIdentifier) as! T.Type
    }
    
    public var title: String?
    public var imageName: String?
    public var cellModel: KSModel?
    
    required public init(model: KSModel?) {
        self.cellModel = model
    }
    
    override init() {}
    
    public var cellHeight: CGFloat = 0
    
    
    
    
}


// MARK: - KWTableViewCell
class KSTableCell: UITableViewCell {
    
    weak var delegate: KSTableViewCellDelegate?
    
    var item: KSTableCellItem! {
        didSet {
            guard let item = item else { return }
            guard item.isMember(of: KSTableCellItem.self) else { return }
            
            self.textLabel?.text = item.title
            if let imageName = item.imageName {
                self.imageView?.image = UIImage(named: imageName)
            } else {
                self.imageView?.image = nil
            }
            
            
            
            
            
        }
    }
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        kw_setupViews()
        kw_setupLayouts()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        kw_setupViews()
        kw_setupLayouts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    public func kw_setupViews() -> Void {
        layoutMargins = .zero
        self.selectionStyle = .none
    }
    
    public func kw_setupLayouts() {
        
    }
    
    
}



extension Array where Element == [KSTableCellItem] {
    func item(for title: String) -> KSTableCellItem? {
        for items in self {
            if let item = items.item(for: title) {
                return item
            }
        }
        return nil
    }
}

extension Array where Element == KSTableCellItem {
    func item(for title: String) -> KSTableCellItem? {
        for item in self {
            if item.title == title {
                return item
            }
        }
        return nil
    }
}
