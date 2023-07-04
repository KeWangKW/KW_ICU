//
//  TestBaseVC.swift
//  KW
//
//  Created by 渴望 on 2023/6/25.
//

import UIKit

class TestBaseVC: KSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "哈哈";
        // Do any additional setup after loading the view.
    }
    
    override func kw_initData() {
        super.kw_initData()
        
    }
    
    override func kw_initUI() {
        super.kw_initUI()
        
        let btn = UIButton(frame: CGRect(x: 10, y: 100, width: 200, height: 30))
        btn.setTitle("Push", for: .normal)
        btn.backgroundColor = .black
        btn.addTarget(self, action: #selector(type0Show), for: .touchUpInside)
        view.addSubview(btn)
        
        let backBtn = UIButton(frame: CGRect(x: 10, y: KScreenHeight-KNavigationStatusHeight-100, width: 100, height: 30))
        backBtn.setTitle("返回", for: .normal)
        backBtn.backgroundColor = .black
        backBtn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
        view.addSubview(backBtn)
    }
    
    override func kw_requestData() {
        super.kw_requestData()
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @objc func type0Show() {
        let vc = TestBaseVC11()
        self.navigationController?.pushViewController(vc, animated: true)
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

}
