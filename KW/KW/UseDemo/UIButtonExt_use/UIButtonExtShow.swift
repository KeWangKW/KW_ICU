//
//  UIButtonExtShow.swift
//  KW
//
//  Created by 渴望 on 2023/7/6.
//

import UIKit

class UIButtonExtShow: KSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        let btn = UIButton(frame: CGRect(x: 20, y: 100, width: 300, height: 50))
        btn.backgroundColor = .cyan
        btn.setTitle("默认样式", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.setImage(UIImage(named: "icon_fabu"), for: .normal)
        view.addSubview(btn)
        
        
        let btn1 = UIButton(frame: CGRect(x: 20, y: 160, width: 300, height: 50))
        btn1.backgroundColor = .cyan
        btn1.setTitle("图片在左侧 间距10", for: .normal)
        btn1.setTitleColor(.black, for: .normal)
        btn1.setImage(UIImage(named: "icon_fabu"), for: .normal)
        view.addSubview(btn1)
        btn1.kw_set(image: .left, spacing: 10)
        
        
        let btn2 = UIButton(frame: CGRect(x: 20, y: 220, width: 300, height: 50))
        btn2.backgroundColor = .cyan
        btn2.setTitle("图片在右侧 间距10", for: .normal)
        btn2.setTitleColor(.black, for: .normal)
        btn2.setImage(UIImage(named: "icon_fabu"), for: .normal)
        view.addSubview(btn2)
        btn2.kw_set(image: .right, spacing: 10)
        
        
        let btn3 = UIButton(frame: CGRect(x: 20, y: 280, width: 300, height: 100))
        btn3.backgroundColor = .cyan
        btn3.setTitle("图片在上侧 间距10", for: .normal)
        btn3.setTitleColor(.black, for: .normal)
        btn3.setImage(UIImage(named: "icon_fabu"), for: .normal)
        view.addSubview(btn3)
        btn3.kw_set(image: .top, spacing: 10)
        
        
        let btn4 = UIButton(frame: CGRect(x: 20, y: 390, width: 300, height: 100))
        btn4.backgroundColor = .cyan
        btn4.setTitle("图片在下侧 间距10", for: .normal)
        btn4.setTitleColor(.black, for: .normal)
        btn4.setImage(UIImage(named: "icon_fabu"), for: .normal)
        view.addSubview(btn4)
        btn4.kw_set(image: .bottom, spacing: 10)
        
        
        
        
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
