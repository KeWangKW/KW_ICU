//
//  KWNavigationVC.swift
//  KW
//
//  Created by 渴望 on 2023/6/19.
//

import UIKit

class KWNavigationVC: KWViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .cyan
        
        
        self.title = "导航栏"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "tabbar1"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "right", style: .plain, target: self, action: nil)
        
        let btn = UIButton(frame: CGRect(x: 10, y: 100, width: 200, height: 30))
        btn.setTitle("状态栏字体白色", for: .normal)
        btn.backgroundColor = .black
        btn.addTarget(self, action: #selector(type0Show), for: .touchUpInside)
        view.addSubview(btn)
        
        let btn1 = UIButton(frame: CGRect(x: 10, y: 140, width: 200, height: 30))
        btn1.setTitle("状态栏字体黑色", for: .normal)
        btn1.backgroundColor = .black
        btn1.addTarget(self, action: #selector(type1Show), for: .touchUpInside)
        view.addSubview(btn1)
        
        let btn2 = UIButton(frame: CGRect(x: 10, y: 180, width: 400, height: 30))
        btn2.setTitle("BarButtonItem颜色", for: .normal)
        btn2.backgroundColor = .black
        btn2.addTarget(self, action: #selector(type2Show), for: .touchUpInside)
        view.addSubview(btn2)

        let btn3 = UIButton(frame: CGRect(x: 10, y: 220, width: 400, height: 30))
        btn3.setTitle("Title颜色", for: .normal)
        btn3.backgroundColor = .black
        btn3.addTarget(self, action: #selector(type3Show), for: .touchUpInside)
        view.addSubview(btn3)


        let btn4 = UIButton(frame: CGRect(x: 10, y: 260, width: 400, height: 30))
        btn4.setTitle("背景色", for: .normal)
        btn4.backgroundColor = .black
        btn4.addTarget(self, action: #selector(type4Show), for: .touchUpInside)
        view.addSubview(btn4)

        let btn5 = UIButton(frame: CGRect(x: 10, y: 300, width: 400, height: 30))
        btn5.setTitle("背景图", for: .normal)
        btn5.backgroundColor = .black
        btn5.addTarget(self, action: #selector(type5Show), for: .touchUpInside)
        view.addSubview(btn5)
        
        let btn6 = UIButton(frame: CGRect(x: 10, y: 370, width: 400, height: 30))
        btn6.setTitle("背景色渐变", for: .normal)
        btn6.backgroundColor = .black
        btn6.addTarget(self, action: #selector(type6Show), for: .touchUpInside)
        view.addSubview(btn6)
        
        
        let backBtn = UIButton(frame: CGRect(x: 10, y: KScreenHeight-KNavigationStatusHeight-100, width: 100, height: 30))
        backBtn.setTitle("返回", for: .normal)
        backBtn.backgroundColor = .black
        backBtn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
        view.addSubview(backBtn)
    }
    
    @objc func backBtnClick() {
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
    

    @objc func type0Show() {
        kw_statusBarStyle = .lightContent
    }
    
    @objc func type1Show() {
        if #available(iOS 13.0, *) {
            kw_statusBarStyle = .darkContent
        } else {
            kw_statusBarStyle = .default
        }
    }
    
    
    @objc func type2Show() {
        kw_tintColor = .random
    }

    @objc func type3Show() {
        kw_titleColor = .random
        kw_titleFont = .systemFont(ofSize: 29, weight: .bold)
    }
    
    @objc func type4Show() {
        kw_backgroundColor = .random
        kw_shadowColor = .random //分割线颜色
    }
    
    @objc func type5Show() {
        kw_backgroundImage = UIImage(named: "ic_video_dhTBG")
        //kw_backgroundImage = nil 取消背景图
    }
    
    
    @objc func type6Show() {
        let vc = KWNavigationVC1()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}



