//
//  KSCollectionCell.swift
//  KW
//
//  Created by 渴望 on 2023/6/28.
//

import UIKit

//MARK: Protocol、Delegate
protocol KSColCellItemProtocol {
    associatedtype T
    
    var cellIdentifier: String { get }
    var cellClass: T.Type { get }
    var cellModel: KSModel? { get set }
    
    init(model: KSModel?)
    
    var title: String? { get set }
    var imageName: String? { get set }
}

@objc protocol KWCollectionViewCellDelegate {
    @objc optional func kw_responseViewInCell(_ cell: KSCollectionCell, object: Any?)
}

class KSCollectionCellItem: NSObject, KSColCellItemProtocol {
    
    typealias T = UICollectionViewCell
    final public var cellIdentifier: String {
        let item = "Item"
        let clsName = NSStringFromClass(type(of: self))
        guard clsName.hasSuffix(item) else { return clsName }
        return String(clsName.prefix(clsName.count - item.count))
    }
    
    public var cellClass: T.Type {
        return NSClassFromString(self.cellIdentifier) as! T.Type
    }
    
    public var title: String?
    
    public var imageName: String?
    
    var selector: Selector?
    
    public var cellModel: KSModel?
    
    required public init(model: KSModel?) {
        self.cellModel = model
    }
    
    override init() {}
    
    public var cellSize: CGSize = .zero
    
}

class KSCollectionCell: UICollectionViewCell {
    weak var delegate: KWCollectionViewCellDelegate?
    
    var item: KSCollectionCellItem! {
        didSet {}
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        kw_setupViews()
        kw_setupLayouts()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        kw_setupViews()
        kw_setupLayouts()
    }
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    func kw_setupViews() {
        
    }
    
    func kw_setupLayouts() {
        
    }
}
