//
//  TestTableView.swift
//  KW
//
//  Created by 渴望 on 2023/6/25.
//

import UIKit

class TestTableView: KSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func back(_ sender: Any) {
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
    
    @IBAction func push(_ sender: Any) {
        
        let vc = TestTableVIewShow()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    

}
