//
//  UITextFieldExtShow.swift
//  KW
//
//  Created by 渴望 on 2023/7/6.
//

import UIKit

class UITextFieldExtShow: KSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .cyan
        
        let tf = UITextField(frame: CGRect(x: 10, y: 110, width: 200, height: 45))
        tf.backgroundColor = UIColor.white
        tf.placeholder = "let tf = UITextField(frame: CGRect(x: 10, y: 110, width: 200, height: 45))"
        tf.kw_addPaddingLeftIcon(UIImage(named: "icon_xiaoxi02")!, padding: 25)
        tf.kw_addPaddingRightIcon(UIImage(named: "icon_xiaoxi02")!, padding: 45)
        view.addSubview(tf)
        
        
        
        
        
        
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
