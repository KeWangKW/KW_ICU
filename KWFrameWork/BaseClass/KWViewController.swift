//
//  KWViewController.swift
//  BaseSwift
//
//  Created by 渴望 on 2019/6/5.
//  Copyright © 2019 渴望. All rights reserved.
//


import UIKit

public class KWViewController: UIViewController {
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        if #available(iOS 14, *) { //导航栏返回按钮长按
//            self.navigationItem.backButtonDisplayMode = .minimal
//        }else{
//            navigationItem.backBarButtonItem = backBarButton
//        }
        
        kw_reloadData()
        
        kw_statusBarStyle = .default
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
    
    
//    let backBarButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    
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
        
        
        kw_shadowHidden = true
        //不做任何扩展,如果有navigationBar和tabBar时,self.view显示区域在二者之间
        //self.edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        self.edgesForExtendedLayout = .top
        
        kw_setupData()
        kw_setupUI()
        kw_requestData()
    }
    
    
    public func kw_setupData() -> Void {
        
    }
    
    public func kw_setupUI() -> Void {
        view.backgroundColor = .white
    }
    
    public func kw_requestData() -> Void {}
    
    public func kw_reloadData() {}
}



public extension KWViewController {
    
    
    //取消所有接口
//    func cancelAllRequest() {
//        MoyaProvider.cancelCompletion(<#T##self: MoyaProvider<_>##MoyaProvider<_>#>)
//        MoyaProvider.manager.session.getTasksWithCompletionHandler {
//            (sessionDataTask, uploadData, downloadData) in
//            sessionDataTask.forEach { $0.cancel() }
//            uploadData.forEach { $0.cancel() }
//            downloadData.forEach { $0.cancel() }
//        }
//    }
//    func cancelCompletion(_ completion: Moya.Completion, target: ApiTargetType) {
//        let error = MoyaError.underlying(NSError(domain: NSURLErrorDomain, code: NSURLErrorCancelled, userInfo: nil), nil)
//        plugins.forEach { $0.didReceive(.failure(error), target: target) }
//        completion(.failure(error))
//    }
    
//    func cancelReq() {
//        Alamofire.Session.default.session.getTasksWithCompletionHandler { tasks, uploads, downloads in
//            tasks.forEach { $0.cancel() }
//            uploads.forEach { $0.cancel() }
//            downloads.forEach { $0.cancel() }
//        }
//
//    }
    
}


