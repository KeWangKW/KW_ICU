//
//  AlertShow.swift
//  KW
//
//  Created by 渴望 on 2023/7/11.
//

import UIKit

class AlertUseShow: KSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let arr = ["单个按钮无响应事件","单个按钮带响应事件","双按钮单响应事件","双按钮多响应事件","alert多按钮","actionSheet多按钮"]
        for idx in 0..<arr.count {
            let btn = UIButton(frame: CGRect(x: idx%2 * 181, y: 400+Int(idx/2)*41, width: 180, height: 40))
            btn.backgroundColor = .black
            btn.setTitle(arr[idx], for: .normal)
            btn.tag = 500+idx
            btn.addTarget(self, action: #selector(showType(btn:)), for: .touchUpInside)
            view.addSubview(btn)
        }
        
    }
    
    @objc func showType(btn:UIButton) {
        if btn.tag == 500 {
            Alert.showText("233" ,"33333333")
        }else if btn.tag == 501 {
            Alert.showOnly("233", "3333333", "ok") {
                print("点击ok")
            }
        }else if btn.tag == 502 {
            Alert.showSingle("233", "3333333", "ok", "cancel") {
                print("ok")
            }
        }else if btn.tag == 503 {
            Alert.showDouble("233", "3333333", "ok", "cancel") {
                print("ok")
            } _: {
                print("cancel")
            }

        }else if btn.tag == 504 {
            let arr = ["哈哈","哦哦","呵呵"]
            Alert.AlertController(title: "233", message: "33333", cancel: "cancel", buttonTitles: arr) { selectedIdx in
                print("\(arr[selectedIdx])")
            } cancelAction: {
                print("cancel")
            }
        }else if btn.tag == 505 {
            let arr = ["哈哈","哦哦","呵呵"]
            Alert.AlertControllerSheet(title: "233", message: "333333", cancel: "cancel", buttonTitles: arr) { selectedIdx in
                print("\(arr[selectedIdx])")
            } cancelAction: {
                print("cancel")
            }
        }else if btn.tag == 506 {
            
        }
    }
    

}
