//
//  KWColorDemoVC.swift
//  KW
//
//  Created by 渴望 on 2023/6/17.
//

import UIKit

class KWColorDemoVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = .cyan
        
        
        
        let lab1 = UILabel(frame: CGRect(x: 10, y: KNavigationStatusHeight, width: KScreenWidth-20, height: 40))
        lab1.text = "仅使用Light色值";
        lab1.backgroundColor = .KW_L(.background)
        lab1.textColor = .KW_L(.title)
        view.addSubview(lab1)
        
        
        let lab2 = UILabel(frame: CGRect(x: 10, y: KNavigationStatusHeight+50, width: KScreenWidth-20, height: 40))
        lab2.text = "使用适配暗黑色值";
        lab2.backgroundColor = .KW_LD(.background)
        lab2.textColor = .KW_LD(.title)
        view.addSubview(lab2)
        
        
        let lab3 = UILabel(frame: CGRect(x: 10, y: KNavigationStatusHeight+100, width: KScreenWidth-20, height: 40))
        lab3.text = "使用适配暗黑色值,但没有在扩展类定义";
        lab3.backgroundColor = .init(light: UIColor.white, dark: UIColor.black)
        lab3.textColor = .init(light: UIColor.init(hexString: "0x000000"), dark: UIColor.init(hexString: "0xFFFFFF"))
        view.addSubview(lab3)
        
        
        
        
    }
    

    

}
