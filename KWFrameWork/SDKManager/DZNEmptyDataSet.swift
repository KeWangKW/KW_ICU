//
//  EmptyDataSet.swift
//  BaseSwift
//
//  Created by 渴望 on 2020/5/21.
//  Copyright © 2020 渴望. All rights reserved.
//

#if canImport(DZNEmptyDataSet)
import DZNEmptyDataSet


private var EmptyDataSetTitleKey: Void?
private var EmptyDataSetDescriptionKey: Void?
private var EmptyDataSetImageKey: Void?

public extension UIViewController {
    
    @objc var emptyDataSetTitle: String {
        //get { return objc_getAssociatedObject(base, &EmptyDataSetTitleKey) as? String ?? "暂无数据" }
        get { return objc_getAssociatedObject(self, &EmptyDataSetTitleKey) as? String ?? " " }
        set { objc_setAssociatedObject(self, &EmptyDataSetTitleKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC) }
    }
    
    @objc var emptyDataSetDescription: String {
        get { return objc_getAssociatedObject(self, &EmptyDataSetDescriptionKey) as? String ?? "" }
        set { objc_setAssociatedObject(self, &EmptyDataSetDescriptionKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC) }
    }
    
    @objc var emptyDataSetImage: UIImage? {
        //get { return objc_getAssociatedObject(base, &EmptyDataSetImageKey) as? UIImage ?? UIImage(named: "ic_zeroshuj") }
        get { return objc_getAssociatedObject(self, &EmptyDataSetImageKey) as? UIImage ?? UIImage() }
        set { objc_setAssociatedObject(self, &EmptyDataSetImageKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
}

extension UIViewController: DZNEmptyDataSetDelegate, DZNEmptyDataSetSource {
    
    // MARK: - DataSource
    @objc public func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        
        var attributes = [NSAttributedString.Key: Any]()
        attributes[NSAttributedString.Key.foregroundColor] = UIColor.black
        attributes[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 16)
        return NSAttributedString(string: emptyDataSetTitle, attributes: attributes)
    }
    
    @objc public func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        var attributes = [NSAttributedString.Key: Any]()
        attributes[NSAttributedString.Key.foregroundColor] = UIColor.black
        attributes[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 12)
        return NSAttributedString(string: emptyDataSetDescription, attributes: attributes)
    }
    
    @objc public func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return emptyDataSetImage!
    }
    
    @objc public func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return .clear
    }
    
    @objc public func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -100
    }
    
    // MARK: - Delegate
    @objc public func emptyDataSetWillAppear(_ scrollView: UIScrollView!) {
        scrollView.contentOffset = .zero
    }
    
    @objc public func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
}



#endif
