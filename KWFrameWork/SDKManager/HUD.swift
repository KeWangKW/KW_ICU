//
//  HUD.swift
//  KW
//
//  Created by 渴望 on 2023/7/7.
//

import UIKit
import MBProgressHUD
import SnapKit

fileprivate var HUD_bezelViewColor:UIColor = UIColor.init(white: 0, alpha: 0.3)
fileprivate var HUD_contentColor:UIColor = UIColor.white
public var HUD_afterDelayTime: TimeInterval = 1.5
//MARK: 定义常用样式
extension HUD {
    
    /* 注意：需要在主线程处理HUD的UI相关操作
     DispatchQueue.main.async {
         HUD.show()
         HUD.show(self.vvvv)
     }
     */
    
    /// 默认展示 可展示文字
    static func show(_ view: UIView? = nil,
                     text:String? = nil) {
        showMBProgressHUD(view: view,
                          bezelViewColor:HUD_bezelViewColor ,
                          contentColor:HUD_contentColor,
                          text: text)
    }
    
    /// 展示文字 默认1.5秒后消失
    static func showText(_ view: UIView? = nil,
                         text:String,
                         afterDelay:TimeInterval = HUD_afterDelayTime) {
        
        let hud = showMBProgressHUD(view: view,
                          mode:.text,
                          bezelViewColor:HUD_bezelViewColor ,
                          contentColor:HUD_contentColor,
                          text: text)
        hud.hide(animated: true, afterDelay: afterDelay)
    }
    
    /// 展示成功图片 可展示文字 默认1.5秒后消失
    static func showSuccess(_ view: UIView? = nil,
                                text:String? = nil,
                                afterDelay:TimeInterval = HUD_afterDelayTime) {
        
        let hud = showMBProgressHUD(view: view,
                          mode:.customView,
                          bezelViewColor:HUD_bezelViewColor,
                          contentColor:HUD_contentColor,
                          text: text,
                          imageV: UIImageView(image: UIImage(named: "HUD_success")))
        hud.hide(animated: true, afterDelay: afterDelay)
    }
    
    /// 展示失败图片 可展示文字 默认1.5秒后消失
    static func showError(_ view: UIView? = nil,
                                text:String? = nil,
                                afterDelay:TimeInterval = HUD_afterDelayTime) {
        
        let hud = showMBProgressHUD(view: view,
                          mode:.customView,
                          bezelViewColor:HUD_bezelViewColor,
                          contentColor:HUD_contentColor,
                          text: text,
                          imageV: UIImageView(image: UIImage(named: "HUD_error")))
        hud.hide(animated: true, afterDelay: afterDelay)
    }
    
    /// 展示提示图片 可展示文字 默认1.5秒后消失
    static func showInfo(_ view: UIView? = nil,
                                text:String? = nil,
                                afterDelay:TimeInterval = HUD_afterDelayTime) {
        
        let hud = showMBProgressHUD(view: view,
                          mode:.customView,
                          bezelViewColor:HUD_bezelViewColor,
                          contentColor:HUD_contentColor,
                          text: text,
                          imageV: UIImageView(image: UIImage(named: "HUD_info")))
        hud.hide(animated: true, afterDelay: afterDelay)
    }
    
    ///展示进度条
    static func showProgress(_ view: UIView? = nil,
                             text:String? = nil) -> MBProgressHUD {
        
        let hud = showMBProgressHUD(view: view,
                          mode:.annularDeterminate,
                          bezelViewColor:HUD_bezelViewColor,
                          contentColor:HUD_contentColor,
                          text: text)
        
        return hud
    }
    
}

//MARK: 方法封装
//public struct HUD { //结构体不支持OC调用 需要声明成类
@objcMembers public class HUD: NSObject {
    var bezelViewColor = UIColor.init(white: 0, alpha: 0.3)
    var contentColor = UIColor.white
    
    /// view：展示所在View
    /// mode：类型：
    ///     MBProgressHUDModeIndeterminate：普通加载动图
    ///     MBProgressHUDModeDeterminate：饼状进度条
    ///     MBProgressHUDModeDeterminateHorizontalBar：水平进度条
    ///     MBProgressHUDModeAnnularDeterminate：圆环进度条
    ///     MBProgressHUDModeCustomView：显示自定义视图
    ///     MBProgressHUDModeText：只显示标签
    /// bezelViewColor：边框的背景色
    /// contentColor：普通加载动图、文字颜色
    /// text：展示文字
    /// detailText：展示详情文字
    /// margin：内容到边框 最小边距 默认20
    /// imageV：自定义图片
    @discardableResult //可忽略返回值 会导致OC无法调用此方法
    static func showMBProgressHUD(view: UIView? = nil,
                                         mode: MBProgressHUDMode = .indeterminate,
                                         bezelViewColor: UIColor? = nil,
                                         contentColor: UIColor? = nil,
                                         text: String? = nil,
                                         detailText: String? = nil,
                                         margin: CGFloat? = nil,
                                         imageV: UIImageView? = nil) -> MBProgressHUD {
        var superView: UIView!
        if view == nil {
            superView = UIViewController.kw_currentController()?.view
        }else{
            superView = view
        }
        
        let hud = MBProgressHUD.showAdded(to: superView, animated: true)
        
        if bezelViewColor != nil {
            hud.bezelView.style = .solidColor //设置此属性，可随心随遇的设置背景色
            hud.bezelView.color = bezelViewColor
        }
        
        if contentColor != nil {
            hud.contentColor = contentColor
        }
        
        if text != nil {
            hud.label.text = text
        }
        
        if detailText != nil {
            hud.detailsLabel.text = detailText
        }
        
        
        hud.mode = mode
        if mode == .customView, imageV != nil {
            hud.customView = imageV
        }
        
        if margin != nil {
            hud.margin = margin!
        }
        

        hud.animationType = .fade
        hud.removeFromSuperViewOnHide = true
        //hud.isUserInteractionEnabled = false
        return hud
    }
    
    
    
    
    public static func hide(_ view: UIView? = nil) {
        var superView: UIView!
        if view == nil {
            superView = UIViewController.kw_currentController()?.view
        } else {
            superView = view!
        }
        MBProgressHUD.hide(for: superView, animated: true)
    }
    
    
    /*
    /// 隐藏HUD 针对网络请求的操作处理
    /// 判断如果view上的hud是家在状态则隐藏，否则不作处理
    /// - Parameter view: 显示的view
    public static func hideIndeterminate(_ view: UIView?) {
        guard
            let view = view,
            let hud = MBProgressHUD.forView(view),
            hud.mode == .indeterminate
        else { return }
        hide(view)
    }
    */
}
