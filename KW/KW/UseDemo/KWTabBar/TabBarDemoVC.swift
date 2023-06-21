//
//  TabBarDemoVC.swift
//  KW
//
//  Created by 渴望 on 2023/6/13.
//

import UIKit

class TabBarDemoVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        let btn = UIButton(frame: CGRect(x: 10, y: 100, width: 200, height: 30))
        btn.setTitle("普通样式", for: .normal)
        btn.backgroundColor = .black
        btn.addTarget(self, action: #selector(type0Show), for: .touchUpInside)
        view.addSubview(btn)
        
        let btn1 = UIButton(frame: CGRect(x: 10, y: 140, width: 200, height: 30))
        btn1.setTitle("选中凸起样式", for: .normal)
        btn1.backgroundColor = .black
        btn1.addTarget(self, action: #selector(type1Show), for: .touchUpInside)
        view.addSubview(btn1)
        
        let btn2 = UIButton(frame: CGRect(x: 10, y: 180, width: 400, height: 30))
        btn2.setTitle("选中凸起样式（部分Tabbar）", for: .normal)
        btn2.backgroundColor = .black
        btn2.addTarget(self, action: #selector(type2Show), for: .touchUpInside)
        view.addSubview(btn2)
        
        let btn3 = UIButton(frame: CGRect(x: 10, y: 220, width: 400, height: 30))
        btn3.setTitle("选中凸起样式（中间单个Tabbar）", for: .normal)
        btn3.backgroundColor = .black
        btn3.addTarget(self, action: #selector(type3Show), for: .touchUpInside)
        view.addSubview(btn3)
        
        
        let btn4 = UIButton(frame: CGRect(x: 10, y: 260, width: 400, height: 30))
        btn4.setTitle("固定凸起样式（部分Tabbar）", for: .normal)
        btn4.backgroundColor = .black
        btn4.addTarget(self, action: #selector(type4Show), for: .touchUpInside)
        view.addSubview(btn4)
        
        let btn5 = UIButton(frame: CGRect(x: 10, y: 300, width: 400, height: 30))
        btn5.setTitle("固定凸起样式（单个Tabbar）", for: .normal)
        btn5.backgroundColor = .black
        btn5.addTarget(self, action: #selector(type5Show), for: .touchUpInside)
        view.addSubview(btn5)
        
        
        
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
        
        let vcArr = [TabBar1VC(), TabBar2VC(), TabBar3VC(), TabBar4VC(), TabBar5VC()];
        let titleArr = ["tab1", "tab2", "tab3", "tab4", "tab5"];
        let normalImageArr = ["icon_guanli01", "icon_gongzuotai01", "icon_xiaoxi01", "icon_wode01", "icon_wode01"];
        let selectedImageArr = ["icon_guanli02", "icon_gongzuotai02", "icon_xiaoxi02", "icon_wode02", "icon_wode02"];
        
        //let vc = KWTabBarController(vcArr, titleArr, normalImageArr, selectedImageArr)
        let vc = KWTabBarController(vcArr, titleArr, normalImageArr, selectedImageArr ,backGroundColor: .yellow)
        vc.selectedIndex = 0;
        self.changeRootViewController(vc: vc)
    }
    
    
    @objc func type1Show() {
        let vcArr = [TabBar1VC(), TabBar2VC(), TabBar3VC(), TabBar4VC(), TabBar5VC()];
        let titleArr = ["tab1", "tab2", "tab3", "tab4", "tab5"];
        let normalImageArr = ["icon_guanli01", "icon_gongzuotai01", "icon_xiaoxi01", "icon_wode01", "icon_wode01"];
        let selectedImageArr = ["icon_fabu", "icon_fabu", "icon_fabu", "icon_fabu", "icon_fabu"];
        
        let vc = KWTabBarController(vcArr, titleArr, normalImageArr, selectedImageArr ,humpType: 1)
        vc.selectedIndex = 2;
        self.changeRootViewController(vc: vc)
    }
    
    @objc func type2Show() {
        let vcArr = [TabBar1VC(), TabBar2VC(), TabBar3VC(), TabBar4VC(), TabBar5VC()];
        let titleArr = ["tab1", "tab2", "tab3", "tab4", "tab5"];
        let normalImageArr = ["icon_guanli01", "icon_gongzuotai01", "icon_xiaoxi01", "icon_wode01", "icon_wode01"];
        let selectedImageArr = ["icon_fabu", "icon_gongzuotai02", "icon_fabu", "icon_wode02", "icon_fabu"];
        
        let vc = KWTabBarController(vcArr, titleArr, normalImageArr, selectedImageArr ,humpType: 2 ,humpAddress: [0,2,4])
        vc.selectedIndex = 2;
        self.changeRootViewController(vc: vc)
    }
    
    @objc func type3Show() {
        let vcArr = [TabBar1VC(), TabBar2VC(), TabBar3VC(), TabBar4VC(), TabBar5VC()];
        let titleArr = ["tab1", "tab2", "tab3", "tab4", "tab5"];
        let normalImageArr = ["icon_guanli01", "icon_gongzuotai01", "icon_xiaoxi01", "icon_wode01", "icon_wode01"];
        let selectedImageArr = ["icon_guanli02", "icon_gongzuotai02", "icon_fabu", "icon_wode02", "icon_wode02"];
        
        let vc = KWTabBarController(vcArr, titleArr, normalImageArr, selectedImageArr ,humpType: 2 ,humpAddress: [2])
        vc.selectedIndex = 2;
        self.changeRootViewController(vc: vc)
    }
    
    @objc func type4Show() {
        let vcArr = [TabBar1VC(), TabBar2VC(), TabBar3VC(), TabBar4VC(), TabBar5VC()];
        let titleArr = ["tab1", "tab2", "tab3", "tab4", "tab5"];
        let normalImageArr = ["icon_fabu", "icon_gongzuotai01", "icon_fabu", "icon_wode01", "icon_fabu"];
        let selectedImageArr = ["icon_fabu", "icon_gongzuotai02", "icon_fabu", "icon_wode02", "icon_fabu"];
        
        //let vc = KWTabBarController(vcArr, titleArr, normalImageArr, selectedImageArr ,humpType: 3 ,humpAddress: [0,2,4])
        let vc = KWTabBarController(vcArr, titleArr, normalImageArr, selectedImageArr ,humpType: 3 ,humpAddress: [0,2,4] ,backGroundColor: .yellow)
        vc.selectedIndex = 2;
        self.changeRootViewController(vc: vc)
    }
    
    @objc func type5Show() {
        let vcArr = [TabBar1VC(), TabBar2VC(), TabBar3VC(), TabBar4VC(), TabBar5VC()];
        let titleArr = ["tab1", "tab2", "tab3", "tab4", "tab5"];
        let normalImageArr = ["icon_guanli01", "icon_gongzuotai01", "icon_fabu", "icon_wode01", "icon_wode01"];
        let selectedImageArr = ["icon_guanli02", "icon_gongzuotai02", "icon_fabu", "icon_wode02", "icon_wode02"];
        
        let vc = KWTabBarController(vcArr, titleArr, normalImageArr, selectedImageArr ,humpType: 3 ,humpAddress: [2])
        vc.selectedIndex = 2;
        self.changeRootViewController(vc: vc)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
