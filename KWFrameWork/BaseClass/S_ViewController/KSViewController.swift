//
//  KWViewController.swift
//  BaseSwift
//
//  Created by 渴望 on 2019/6/5.
//  Copyright © 2019 渴望. All rights reserved.
//


import UIKit

public class KSViewController: UIViewController {
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        kw_reloadData()
        
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
    
    deinit {
        debugPrint(#function + ": " + String(describing: type(of: self)))
    }
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        //修改返回按钮图片
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "fanhui")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "fanhui")
        //导航栏返回按钮长按处理
        let backBarButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        if #available(iOS 14, *) {
            self.navigationItem.backButtonDisplayMode = .minimal
        }else{
            navigationItem.backBarButtonItem = backBarButton
        }
        
        kw_statusBarStyle = .default
        kw_shadowHidden = true
        //不做任何扩展,如果有navigationBar和tabBar时,self.view显示区域在二者之间
        //self.edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        self.edgesForExtendedLayout = .top
        
        view.backgroundColor = .white
        kw_initData()
        kw_initUI()
        kw_requestData()
    }
    
    
    public func kw_initData() -> Void {}
    
    public func kw_initUI() -> Void {}
    
    public func kw_requestData() -> Void {}
    
    public func kw_reloadData() {}
}






