//
//  UIButtonExt.swift
//  KW
//
//  Created by 渴望 on 2023/7/6.
//

import UIKit

public extension UIButton {
    
    @objc enum Position:NSInteger {
        case top, left, bottom, right
    }
    
    //MARK: 文字图片布局
    /// 文字图片布局
    @objc func kw_set(image position: Position, spacing: CGFloat) {
        self.layoutIfNeeded()
        
        guard
            let imageWidth = self.imageView?.frame.width,
            let imageHeight = self.imageView?.frame.height,
            let labelWidth = self.titleLabel?.frame.width,
            let labelHeight = self.titleLabel?.frame.height
        else { return }
        
        let space = spacing
        var imageInsets = UIEdgeInsets.zero
        var labelInsets = UIEdgeInsets.zero
        
        switch position {

        case .top:
            imageInsets = UIEdgeInsets(top: -labelHeight - space/2.0, left: 0, bottom: 0, right: -labelWidth)
            labelInsets = UIEdgeInsets(top: 0, left: -imageWidth, bottom: -imageHeight - space/2.0, right: 0)
            break
        case .left:
            imageInsets = UIEdgeInsets(top: 0, left: -space/2.0, bottom: 0, right: space/2.0)
            labelInsets = UIEdgeInsets(top: 0, left: space/2.0, bottom: 0, right: -space/2.0)
            break
        case .bottom:
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight - space/2.0, right: -labelWidth)
            labelInsets = UIEdgeInsets(top: -imageHeight - space/2.0, left: -imageWidth, bottom: 0, right: 0)
            break
        case .right:
            imageInsets = UIEdgeInsets(top: 0, left: labelWidth + space/2.0, bottom: 0, right: -labelWidth - space/2.0)
            labelInsets = UIEdgeInsets(top: 0, left: -imageWidth - space/2.0, bottom: 0, right: imageWidth + space/2.0)
            break
        }
        
        self.imageEdgeInsets = imageInsets
        self.titleEdgeInsets = labelInsets
    }
    
}
