//
//  KSPageVC.swift
//  KW
//
//  Created by 渴望 on 2023/7/3.
//

import UIKit

class KSPageVC: KSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let btn5 = UIButton(frame: CGRect(x: 10, y: 330, width: 400, height: 30))
        btn5.setTitle("自定义 titleView", for: .normal)
        btn5.backgroundColor = .black
        btn5.addTarget(self, action: #selector(push1), for: .touchUpInside)
        view.addSubview(btn5)
        
        let btn6 = UIButton(frame: CGRect(x: 10, y: 370, width: 400, height: 30))
        btn6.setTitle("KSPageController", for: .normal)
        btn6.backgroundColor = .black
        btn6.addTarget(self, action: #selector(push), for: .touchUpInside)
        view.addSubview(btn6)
        
        
        let backBtn = UIButton(frame: CGRect(x: 10, y: KScreenHeight-KNavigationStatusHeight-100, width: 100, height: 30))
        backBtn.setTitle("返回", for: .normal)
        backBtn.backgroundColor = .black
        backBtn.addTarget(self, action: #selector(back), for: .touchUpInside)
        view.addSubview(backBtn)
        
    }
    

    @objc func back() {
        let nav = UINavigationController(rootViewController: ViewController())
        self .changeRootViewController(vc: nav)
    }
    
    func changeRootViewController(vc:UIViewController) {
        if #available(iOS 15.0, *) {
            let scenes = UIApplication.shared.connectedScenes
            let windowScene = scenes.first as? UIWindowScene

            if let windowScene = windowScene {
                windowScene.keyWindow?.rootViewController = vc
                windowScene.keyWindow?.makeKeyAndVisible()
            }
        }else{
            UIApplication.shared.windows.first?.rootViewController = vc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
    }
    
    @objc func push() {
        
        let vc = KSPageShow()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func push1() {

        let vc = KSTitleViewShow()
//        self.navigationController?.pushViewController(vc, animated: true)
        view.kw_currentController?.navigationController?.pushViewController(vc, animated: true)

    }


}
