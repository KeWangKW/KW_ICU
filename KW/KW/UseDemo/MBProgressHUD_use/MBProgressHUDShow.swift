//
//  MBProgressHUDShow.swift
//  KW
//
//  Created by 渴望 on 2023/7/7.
//

import UIKit
import SDWebImage


class MBProgressHUDShow: KSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "隐藏", style: .plain, target: self, action: #selector(hideClick))
        
        
        //let imageView = UIImageView(image: UIImage(named: "HUD_success"))
        let imageView = UIImageView()
        if let localGifURL = Bundle.main.url(forResource: "加载缓存", withExtension: "gif") {
            imageView.sd_setImage(with: localGifURL, completed: nil)
        }
        let hud = HUD.showMBProgressHUD( mode: .customView, bezelViewColor: UIColor.init(white: 0, alpha: 0.3) ,contentColor: UIColor.white ,text: "Text" ,detailText: "Deatil" ,imageV: imageView )
        
        
        
//        var seconds = 0
//        let timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { timer in
//            seconds += 5
//            print("Elapsed time: \(seconds) seconds")
//            if seconds >= 100 {
//                timer.invalidate()
//
//            }
//            DispatchQueue.main.async {
//                hud.progress = Float(seconds)/100
//                hud.label.text = "\(Float(seconds)/100)"
//            }
//        }
        
//        HUD.show(text: "2222222222222222222222222")
        
        
        let vvvv = UIView(frame: CGRect(x: 0, y: 100, width: KScreenWidth, height: 150))
        vvvv.backgroundColor = .yellow
        self.vvvv = vvvv
        view.addSubview(vvvv)
        
        
        
        let arr = ["转圈","转圈带字","仅展示文字","","成功","成功带字","失败","失败带字","提示","提示带字","进度","进度带字"]
        for idx in 0..<arr.count {
            let btn = UIButton(frame: CGRect(x: idx%2 * 101, y: 400+Int(idx/2)*41, width: 100, height: 40))
            btn.backgroundColor = .black
            btn.setTitle(arr[idx], for: .normal)
            btn.tag = 500+idx
            btn.addTarget(self, action: #selector(showType(btn:)), for: .touchUpInside)
            view.addSubview(btn)
        }
        
        
    }
    
    
    @objc func showType(btn:UIButton) {
        if btn.tag == 500 {
            DispatchQueue.main.async {
                HUD.show()
                HUD.show(self.vvvv)
            }
        }else if btn.tag == 501 {
            HUD.show(text: "233")
            HUD.show(vvvv, text: "233")
        }else if btn.tag == 502 {
            HUD.showText(text: "23333")
            HUD.showText(vvvv,text: "23333")
        }else if btn.tag == 503 {
            
        }else if btn.tag == 504 {
            HUD.showSuccess()
            HUD.showSuccess(vvvv)
        }else if btn.tag == 505 {
            HUD.showSuccess(text:"2333")
            HUD.showSuccess(vvvv,text: "2333")
        }else if btn.tag == 506 {
            HUD.showError()
            HUD.showError(vvvv)
        }else if btn.tag == 507 {
            HUD.showError(text:"2333")
            HUD.showError(vvvv,text:"2333")
        }else if btn.tag == 508 {
            HUD.showInfo()
            HUD.showInfo(vvvv)
        }else if btn.tag == 509 {
            HUD.showInfo(text:"2333")
            HUD.showInfo(vvvv,text:"2333")
        }else if btn.tag == 510 {
            let hud = HUD.showProgress()
            hud.progress = 0.3
            let hud1 = HUD.showProgress(vvvv)
            hud1.progress = 0.7
        }else if btn.tag == 511 {
            let hud = HUD.showProgress(text: "进度")
            hud.progress = 0.3
            let hud1 = HUD.showProgress(vvvv ,text: "进度")
            hud1.progress = 0.7
        }
    }
    
    
    
    
    
    

    var vvvv = UIView()
    @objc func hideClick() {
        HUD.hide()
        HUD.hide(vvvv)
    }
    
    
}
