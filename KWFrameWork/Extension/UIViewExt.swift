//
//  UIViewExt.swift
//  KW
//
//  Created by 渴望 on 2023/7/4.
//

import UIKit

public extension UIView {
    
    //MARK: 当前所在控制器
    /// 获取当前所在控制器
    @objc var kw_currentController: UIViewController? {
        weak var next: UIResponder? = self
        while next != nil {
            next = next?.next ?? nil
            if let controller = next as? UIViewController {
                return controller
            }
        }
        return nil
    }
    
    
    
    
    //MARK: 设置圆角 边框 阴影 渐变色
    /// 设置圆角 边框 阴影 渐变色 (在 addSubView、设置好布局 后调用此方法)
    ///   - roundCorners: 圆角位置
    ///   - roundRadius: 圆角角度
    ///   - borderWidth: 边框宽度
    ///   - borderColor: 边框颜色
    ///   - shadowColor: 阴影颜色
    ///   - shadowOffset: 阴影偏移量 ：{ width: 2, height: 2 } 右下方偏移
    ///   - shadowOpacity: 阴影透明度
    ///   - shadowRadius: 阴影半径：决定模糊程度
    ///   - gradientColors: 渐变色数组
    ///   - gradientStart: 渐变色开始位置
    ///   - gradientEnd: 渐变色结束位置
    @objc func kw_setupLayer(roundCorners: UIRectCorner = [.allCorners],
                       roundRadius: CGFloat = 0,
                       borderWidth: CGFloat = 0,
                       borderColor: UIColor = UIColor.clear,
                       shadowColor: UIColor = UIColor.clear,
                       shadowOffset: CGSize = CGSize.zero,
                       shadowOpacity: Float = 0,
                       shadowRadius: CGFloat = 0,
                       gradientColors: [UIColor] = [],
                       gradientStart: CGPoint = CGPoint(x: 0, y: 0.5),
                       gradientEnd: CGPoint = CGPoint(x: 1, y: 0.5)  ) {
        
        let oldBackGroundColor = self.backgroundColor ?? .white
        
        //圆角
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: roundCorners, cornerRadii: CGSize(width: roundRadius, height: roundRadius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        
        //边框
        let borderLayer = CAShapeLayer()
        borderLayer.path = path.cgPath
        borderLayer.lineWidth = borderWidth
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.fillColor = self.backgroundColor?.cgColor ?? UIColor.white.cgColor
        self.layer.addSublayer(borderLayer)
        
        
        
        if let superView = self.superview {
            let backView = UIView(frame: self.frame)
            backView.layer.masksToBounds = false
            
            //阴影
            let shadowLayer = CAShapeLayer()
            shadowLayer.path = path.cgPath
            shadowLayer.fillColor = superView.backgroundColor?.cgColor ?? UIColor.white.cgColor
            shadowLayer.shadowColor = shadowColor.cgColor
            shadowLayer.shadowOffset = shadowOffset
            shadowLayer.shadowOpacity = shadowOpacity
            shadowLayer.shadowRadius = shadowRadius
            backView.layer.insertSublayer(shadowLayer, at: 0)
            
            //渐变色
            self.backgroundColor = UIColor.clear
            borderLayer.fillColor = UIColor.clear.cgColor
            
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = backView.bounds
            let maskLayer = CAShapeLayer()
            maskLayer.frame = gradientLayer.bounds
            maskLayer.path = path.cgPath
            gradientLayer.mask = maskLayer
            gradientLayer.colors = gradientColors.map{$0.cgColor}
            gradientLayer.startPoint = gradientStart
            gradientLayer.endPoint = gradientEnd
            backView.layer.addSublayer(gradientLayer)
            
            superView.insertSubview(backView, belowSubview: self)
            
        }
        
        //不设置渐变背景色时，恢复原背景色
        if gradientColors.count == 0 {
            self.backgroundColor = oldBackGroundColor
        }
    }
    
    /// 恢复layer
    @objc func kw_resetLayer() {
        
        let resetPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 0, height: 0))
        let resetMask = CAShapeLayer()
        resetMask.path = resetPath.cgPath
        self.layer.mask = resetMask
        if let subLayers = self.layer.sublayers {
            let removedLayers = subLayers.filter { $0 is CAShapeLayer }
            removedLayers.forEach { $0.removeFromSuperlayer() }
        }
        if let suberviews = self.superview?.subviews {
            for view in suberviews {
                if view.frame == self.frame && view != self {
                    view.removeFromSuperview()
                }
            }
        }
        self.backgroundColor = UIColor.white
    }
    
    
    
    
    //MARK: 添加单击手势
    /// 单击手势添加并回调
    @objc func kw_tapAtion(_ tap: @escaping gestureAction)  {
        self.tapRecognizer(tap)
    }
    typealias gestureAction = (UITapGestureRecognizer) -> ()
    struct AssociatedKeys {
        static var actionKey = "actionKey"
    }
    private var action: gestureAction? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.actionKey) as? gestureAction ?? nil }
        set {objc_setAssociatedObject(self, &AssociatedKeys.actionKey, newValue, .OBJC_ASSOCIATION_COPY) }
    }
    
    private func tapRecognizer(_ action: @escaping gestureAction)  {
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction(tap:)))
        tap.numberOfTouchesRequired = 1
        tap.numberOfTapsRequired = 1
        self.addGestureRecognizer(tap)
        self.action = action
    }
    
    @objc private func tapAction(tap: UITapGestureRecognizer) {
        action?(tap)
    }
    
    
    //MARK: Xib创建View
    /* 示例
     private var headView: XDSAuditDetailHeadView = {
         let headView = UIView.viewFromXIB("XDSAuditDetailHeadView", owner: nil, index: 0, frame: nil) as! XDSAuditDetailHeadView
         return headView
     }()
     */
    class func viewFromXIB(_ xibName: String, owner: Any? = nil, index: Int? = 0, frame: CGRect? = nil) -> UIView {
        let nib = UINib(nibName: xibName, bundle: nil)
        let xibView = nib.instantiate(withOwner: owner, options: nil)[index ?? 0] as! UIView
        xibView.autoresizingMask = UIView.AutoresizingMask(rawValue: 0)
        if frame != nil {
            xibView.frame = frame!
        }
        
        return xibView
    }
    
    
    
    
    
}
