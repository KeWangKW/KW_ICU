//
//  TabBar1VC.swift
//  KW
//
//  Created by 渴望 on 2023/6/13.
//

import UIKit

class TabBar1VC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        let btn = UIButton(frame: CGRectMake(10, UIScreen.main.bounds.size.height-200, 100, 40))
        btn.backgroundColor = .black
        btn.setTitle("返回", for: .normal)
        btn.addTarget(self, action: #selector(back), for: .touchUpInside)
        view.addSubview(btn)
        
        
        
//        self.tabBarController?.tabBar.layer.shadowColor = UIColor(red: 78/255, green: 112/255, blue: 145/255, alpha: 0.19).cgColor
//        self.tabBarController?.tabBar.layer.shadowOffset = CGSizeMake(0, -1.5)
//        self.tabBarController?.tabBar.layer.shadowOpacity = 1;
        
        self.tabBarItem.badgeValue = "99"
    }
    
    
    @objc func back(){
        if #available(iOS 15.0, *) {
            let scenes = UIApplication.shared.connectedScenes
            let windowScene = scenes.first as? UIWindowScene

            if let windowScene = windowScene {
                windowScene.keyWindow?.rootViewController = TabBarDemoVC()
                windowScene.keyWindow?.makeKeyAndVisible()
            }
        }else{
            UIApplication.shared.windows.first?.rootViewController = TabBarDemoVC()
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
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
