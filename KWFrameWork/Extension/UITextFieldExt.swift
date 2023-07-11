//
//  UITextFieldExt.swift
//  KW
//
//  Created by 渴望 on 2023/7/6.
//

import UIKit

public extension UITextField {
    
    /// 添加输入框左侧间距
    @objc func kw_addPaddingLeft(_ padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    /// 添加输入框右侧间距
    @objc func kw_addPaddingRight(_ padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    /// 添加带图片的输入框左侧间距
    @objc func kw_addPaddingLeftIcon(_ image: UIImage, padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.height))
        let imageView = UIImageView(image: image)
        imageView.contentMode = .center
        imageView.frame = paddingView.frame
        paddingView.addSubview(imageView)
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    /// 添加带图片的输入框右侧间距
    @objc func kw_addPaddingRightIcon(_ image: UIImage, padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.height))
        let imageView = UIImageView(image: image)
        imageView.contentMode = .center
        imageView.frame = paddingView.frame
        paddingView.addSubview(imageView)
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
}
