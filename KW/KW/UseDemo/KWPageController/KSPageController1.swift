//
//  KSPageController1.swift
//  KW
//
//  Created by 渴望 on 2023/7/3.
//

import UIKit

class KSPageController1: KSViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .random
        
        let btn = UIButton(frame: CGRect(x: 0, y: KScreenHeight-KNavigationStatusHeight-50-100, width: 100, height: 100))
        btn.backgroundColor = .black
        btn.addTarget(self, action: #selector(btnClcik), for: .touchUpInside)
        view.addSubview(btn)
        
    }
    
    @objc func btnClcik() {
        
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
