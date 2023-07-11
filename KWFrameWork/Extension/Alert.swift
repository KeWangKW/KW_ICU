//
//  Alert.swift
//  Whatever
//
//  Created by 渴望 on 2020/6/19.
//  Copyright © 2020 渴望. All rights reserved.
//

import UIKit
import Foundation

private let AlertCancelTitleColor = UIColor.red
private let AlertEnterTitleColor = UIColor.blue

@objcMembers public class Alert: NSObject {
    
    /// 文本提醒框， 单个按钮无响应事件
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 内容
    @objc static func showText(_ title: String?, _ message: String? = nil) {
        //AlertOnly(title, message, "确定", enterHandle: .none)
        AlertController(title: title, message: message, cancel: nil, buttonTitles: ["确定"])
    }

    /// 文本提醒框，单个按钮带响应事件
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 内容
    ///   - enter: 响应文字
    ///   - enterHandle: 响应事件回调
    @objc static func showOnly(_ title: String?, _ message: String?, _ enter: String, enterHandle: (() -> Void)?) {
        //AlertSingle(title, message, enter, nil, enterHandle)
        AlertController(title: title, message: message, cancel: nil, buttonTitles: [enter], completion: { (_) in
            enterHandle?()
        })
    }

    /// 文本提醒框，双按钮，单个响应事件
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 内容
    ///   - enter: 响应事件文字
    ///   - cancel: 非响应事件文字
    ///   - enterHandle: 响应事件回调
    @objc static func showSingle(_ title: String?, _ message: String?, _ enter: String, _ cancel: String?, _ enterHandle: (() -> Void)?) {
        //AlertDouble(title, message, enter, cancel, enterHandle, .none)
        AlertController(title: title, message: message, cancel: cancel, buttonTitles: [enter], completion: { (_) in
            enterHandle?()
        })
    }

    /// 文本提醒框，双按钮响应事件
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 内容
    ///   - enter: 响应事件文字1
    ///   - cancel: 响应事件文字2
    ///   - enterHandle: 响应事件回调1
    ///   - cancelHandle: 响应事件回调2
    @objc static func showDouble(_ title: String?, _ message: String?, _ enter: String, _ cancel: String?, _ enterHandle: (() -> Void)?, _ cancelHandle: (() -> Void)?) {
        AlertController(title: title, message: message, cancel: cancel, buttonTitles: [enter], completion: { (_) in
            enterHandle?()
        }, cancelAction: cancelHandle)
    }




    /// 自定义初始化UIAlertController <多按钮>
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 内容
    ///   - cancel: 取消按钮文字
    ///   - buttonTitles: 其他按钮文字组
    ///   - completion: 按钮事件回调
    ///   - cancelAction: 取消回调
    @objc static func AlertController(title: String?, message: String?, cancel: String?, buttonTitles: [String]?, completion: ((Int) -> Void)? = nil, cancelAction: (() -> Void)? = nil)  {
        guard let buttons = buttonTitles, buttons.count > 0 else { return }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for idx in 0..<buttons.count {
            let action = UIAlertAction(title: buttons[idx], style: .default) { (_) in
                completion?(idx)
            }
            action.setValue(AlertEnterTitleColor, forKey: "_titleTextColor")
            alert.addAction(action)
        }
        if let cancelTitle = cancel {
            let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel) { (_) in
                cancelAction?()
            }
            cancelAction.setValue(AlertCancelTitleColor, forKey: "_titleTextColor")
            alert.addAction(cancelAction)
        }
        
        let controller = UIViewController.kw_currentController()
        controller?.present(alert, animated: true, completion: .none)
    }


    /// 自定义初始化UIAlertController <多按钮>
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 内容
    ///   - cancel: 取消按钮文字
    ///   - buttonTitles: 其他按钮文字组
    ///   - completion: 按钮事件回调
    ///   - cancelAction: 取消回调
    @objc static func AlertControllerSheet(title: String?, message: String?, cancel: String?, buttonTitles: [String]?, completion: ((Int) -> Void)? = nil, cancelAction: (() -> Void)? = nil)  {
        guard let buttons = buttonTitles, buttons.count > 0 else { return }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        for idx in 0..<buttons.count {
            let action = UIAlertAction(title: buttons[idx], style: .default) { (_) in
                completion?(idx)
            }
            action.setValue(AlertEnterTitleColor, forKey: "_titleTextColor")
            alert.addAction(action)
        }
        if let cancelTitle = cancel {
            let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel) { (_) in
                cancelAction?()
            }
            cancelAction.setValue(AlertCancelTitleColor, forKey: "_titleTextColor")
            alert.addAction(cancelAction)
        }
        
        let controller = UIViewController.kw_currentController()
        controller?.present(alert, animated: true, completion: .none)
    }


    
    
}

