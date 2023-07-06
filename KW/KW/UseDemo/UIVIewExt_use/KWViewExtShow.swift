//
//  KWViewExtShow.swift
//  KW
//
//  Created by 渴望 on 2023/7/4.
//

import UIKit

class KWViewExtShow: KSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.cyan
        // Do any additional setup after loading the view.
        
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: KNavigationStatusHeight, width: KScreenWidth, height: KScreenHeight-KNavigationStatusHeight))
        scrollView.contentSize = CGSize(width: 0, height: KScreenHeight*2)
        view.addSubview(scrollView)
        
        
        
        let view1 = UIView(frame: CGRect(x: 10, y: 10, width: 200, height: 40));
        view1.backgroundColor = UIColor.red
        scrollView.addSubview(view1)
        view1.kw_setupLayer(roundCorners: [.topLeft] ,
                            roundRadius: 35 ,
                            borderWidth: 5 ,
                            borderColor: UIColor.black ,
                            shadowColor: UIColor.red ,
                            shadowOffset: CGSize(width: 2, height: 2) ,
                            shadowOpacity: 0.6,
                            shadowRadius: 5)
        
        
        let view2 = UIView(frame: CGRect(x: 10, y: 70, width: 200, height: 40));
        scrollView.addSubview(view2)
        view2.kw_setupLayer(roundCorners: [.topLeft ,.topRight ,.bottomLeft] ,
                            roundRadius: 35 )
        
        
        let view3 = UIView(frame: CGRect(x: 10, y: 130, width: 200, height: 40));
        scrollView.addSubview(view3)
        view3.kw_setupLayer(borderWidth: 5 ,
                            borderColor: UIColor.red )
        
        
        let view4 = UIView(frame: CGRect(x: 10, y: 190, width: 200, height: 40));
        scrollView.addSubview(view4)
        view4.kw_setupLayer(shadowColor: UIColor.red ,
                            shadowOffset: CGSize(width: 0, height: 0) ,
                            shadowOpacity: 0.6,
                            shadowRadius: 5 )
        
        
        let view5 = UIView(frame: CGRect(x: 10, y: 250, width: 200, height: 40));
        scrollView.addSubview(view5)
        view5.kw_setupLayer(gradientColors: [UIColor.red ,UIColor.blue] ,
                            gradientStart: CGPoint(x: 0, y: 0.5) ,
                            gradientEnd: CGPoint(x: 1, y: 0.5) )
        
        
        let lab = UILabel(frame: CGRect(x: 230, y: 10, width: 100, height: 280))
        lab.text = "UILabel使用";
        lab.textColor = UIColor.black
        lab.numberOfLines = 0
        lab.textAlignment = .center
        scrollView.addSubview(lab)
        lab.kw_setupLayer(roundCorners: [.topLeft] ,
                            roundRadius: 35 ,
                            borderWidth: 5 ,
                            borderColor: UIColor.black ,
                            shadowColor: UIColor.red ,
                            shadowOffset: CGSize(width: 2, height: 2) ,
                            shadowOpacity: 0.6,
                            shadowRadius: 5,
                          gradientColors: [UIColor.red ,UIColor.blue] ,
                          gradientStart: CGPoint(x: 0, y: 0.5) ,
                          gradientEnd: CGPoint(x: 1, y: 0.5) )
        
        
        let btn = UIButton(frame: CGRect(x: 10, y: 310, width: 320, height: 40))
        btn.setTitle("UIButton", for: .normal)
        btn.setTitle("UIButtonxxxxxxx", for: .highlighted)
        btn.setTitleColor(.black, for: .normal)
        scrollView.addSubview(btn)
        btn.kw_setupLayer(roundCorners: [.topLeft,.bottomLeft] ,
                            roundRadius: 35 ,
                            borderWidth: 3 ,
                            borderColor: UIColor.black ,
                            shadowColor: UIColor.red ,
                            shadowOffset: CGSize(width: 2, height: 2) ,
                            shadowOpacity: 0.6,
                            shadowRadius: 5,
                          gradientColors: [UIColor.red ,UIColor.blue] ,
                          gradientStart: CGPoint(x: 0, y: 0.5) ,
                          gradientEnd: CGPoint(x: 1, y: 0.5) )
        
        
        view1.kw_tapAtion { r in
            print("UIView")
        }
        
        lab.kw_tapAtion { r in
            print("UILabel")
        }
        
        
//////////////////////////////////////////////////////////////////////////////////////////////////
        
        lab1 = UILabel(frame: CGRect(x: 170, y: 370, width: 180, height: 200))
        lab1.text = "UILabel \n 默认全属性设置";
        lab1.numberOfLines = 0
        lab1.textColor = UIColor.black
        lab1.textAlignment = .center
        scrollView.addSubview(lab1)
        lab1.kw_setupLayer(roundCorners: [.topLeft] ,
                            roundRadius: 35 ,
                            borderWidth: 5 ,
                            borderColor: UIColor.black ,
                            shadowColor: UIColor.red ,
                            shadowOffset: CGSize(width: 2, height: 2) ,
                            shadowOpacity: 0.6,
                            shadowRadius: 5,
                          gradientColors: [UIColor.red ,UIColor.blue] ,
                          gradientStart: CGPoint(x: 0, y: 0.5) ,
                          gradientEnd: CGPoint(x: 1, y: 0.5) )
        
        btn1 = UIButton(frame: CGRect(x: 170, y: 590, width: 180, height: 200))
        btn1.setTitle("UIbutton \n 默认全属性设置", for: .normal)
        btn1.setTitleColor(.black, for: .normal)
        btn1.titleLabel?.numberOfLines = 0
        scrollView.addSubview(btn1)
        btn1.kw_setupLayer(roundCorners: [.topLeft] ,
                            roundRadius: 35 ,
                            borderWidth: 5 ,
                            borderColor: UIColor.black ,
                            shadowColor: UIColor.red ,
                            shadowOffset: CGSize(width: 2, height: 2) ,
                            shadowOpacity: 0.6,
                            shadowRadius: 5,
                          gradientColors: [UIColor.red ,UIColor.blue] ,
                          gradientStart: CGPoint(x: 0, y: 0.5) ,
                          gradientEnd: CGPoint(x: 1, y: 0.5) )
        
        let arr = ["恢复Layer","圆角","圆角+边框","圆角+阴影","圆角+渐变","圆角+边框+阴影","圆角+边框+渐变","圆角+阴影+渐变","圆角+边框+阴影+渐变","边框","边框+阴影","边框+渐变","边框+阴影+渐变","阴影","阴影+渐变","渐变"]
        
        for idx in 0..<arr.count {
            let btn1 = UIButton(frame: CGRect(x: 5, y: 370 + 32*idx, width: 150, height: 30))
            btn1.setTitle(arr[idx], for: .normal)
            btn1.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            btn1.backgroundColor = .black
            btn1.addTarget(self, action: #selector(reset(btn:)), for: .touchUpInside)
            btn1.tag = 500+idx
            scrollView.addSubview(btn1)
        }
        
        
        
    }
    
    var lab1 = UILabel()
    var btn1 = UIButton()
    
    
    @objc func reset(btn:UIButton) {
        
        lab1.kw_resetLayer()
        btn1.kw_resetLayer()
        
        lab1.text = String(format: "UILabel \n %@", btn.titleLabel!.text!)
        btn1.setTitle(String(format: "UIBUtton \n %@", btn.titleLabel!.text!), for: .normal)
        
        if btn.tag == 500 {
            //恢复Layer
        }else if btn.tag == 501 {
            //圆角
            lab1.kw_setupLayer(roundCorners: [.topLeft] ,
                                roundRadius: 35 )
            btn1.kw_setupLayer(roundCorners: [.topLeft] ,
                                roundRadius: 35 )
        }else if btn.tag == 502 {
            //圆角+边框
            lab1.kw_setupLayer(roundCorners: [.topLeft] ,
                                roundRadius: 35 ,
                                borderWidth: 5 ,
                                borderColor: UIColor.black )
            btn1.kw_setupLayer(roundCorners: [.topLeft] ,
                                roundRadius: 35 ,
                                borderWidth: 5 ,
                                borderColor: UIColor.black )
        }else if btn.tag == 503 {
            //圆角+阴影
            lab1.kw_setupLayer(roundCorners: [.topLeft] ,
                                roundRadius: 35 ,
                                shadowColor: UIColor.red ,
                                shadowOffset: CGSize(width: 2, height: 2) ,
                                shadowOpacity: 0.6,
                                shadowRadius: 5 )
            btn1.kw_setupLayer(roundCorners: [.topLeft] ,
                                roundRadius: 35 ,
                                shadowColor: UIColor.red ,
                                shadowOffset: CGSize(width: 2, height: 2) ,
                                shadowOpacity: 0.6,
                                shadowRadius: 5 )
        }else if btn.tag == 504 {
            //圆角+渐变
            lab1.kw_setupLayer(roundCorners: [.topLeft] ,
                                roundRadius: 35 ,
                              gradientColors: [UIColor.red ,UIColor.blue] ,
                              gradientStart: CGPoint(x: 0, y: 0.5) ,
                              gradientEnd: CGPoint(x: 1, y: 0.5) )
            btn1.kw_setupLayer(roundCorners: [.topLeft] ,
                                roundRadius: 35 ,
                              gradientColors: [UIColor.red ,UIColor.blue] ,
                              gradientStart: CGPoint(x: 0, y: 0.5) ,
                              gradientEnd: CGPoint(x: 1, y: 0.5) )
        }else if btn.tag == 505 {
            //圆角+边框+阴影
            lab1.kw_setupLayer(roundCorners: [.topLeft] ,
                                roundRadius: 35 ,
                                borderWidth: 5 ,
                                borderColor: UIColor.black ,
                                shadowColor: UIColor.red ,
                                shadowOffset: CGSize(width: 2, height: 2) ,
                                shadowOpacity: 0.6,
                                shadowRadius: 5 )
            btn1.kw_setupLayer(roundCorners: [.topLeft] ,
                                roundRadius: 35 ,
                                borderWidth: 5 ,
                                borderColor: UIColor.black ,
                                shadowColor: UIColor.red ,
                                shadowOffset: CGSize(width: 2, height: 2) ,
                                shadowOpacity: 0.6,
                                shadowRadius: 5 )
        }else if btn.tag == 506 {
            //圆角+边框+渐变
            lab1.kw_setupLayer(roundCorners: [.topLeft] ,
                                roundRadius: 35 ,
                                borderWidth: 5 ,
                                borderColor: UIColor.black ,
                              gradientColors: [UIColor.red ,UIColor.blue] ,
                              gradientStart: CGPoint(x: 0, y: 0.5) ,
                              gradientEnd: CGPoint(x: 1, y: 0.5) )
            btn1.kw_setupLayer(roundCorners: [.topLeft] ,
                                roundRadius: 35 ,
                                borderWidth: 5 ,
                                borderColor: UIColor.black ,
                              gradientColors: [UIColor.red ,UIColor.blue] ,
                              gradientStart: CGPoint(x: 0, y: 0.5) ,
                              gradientEnd: CGPoint(x: 1, y: 0.5) )
        }else if btn.tag == 507 {
            //圆角+阴影+渐变
            lab1.kw_setupLayer(roundCorners: [.topLeft] ,
                                roundRadius: 35 ,
                                shadowColor: UIColor.red ,
                                shadowOffset: CGSize(width: 2, height: 2) ,
                                shadowOpacity: 0.6,
                                shadowRadius: 5,
                              gradientColors: [UIColor.red ,UIColor.blue] ,
                              gradientStart: CGPoint(x: 0, y: 0.5) ,
                              gradientEnd: CGPoint(x: 1, y: 0.5) )
            btn1.kw_setupLayer(roundCorners: [.topLeft] ,
                                roundRadius: 35 ,
                                shadowColor: UIColor.red ,
                                shadowOffset: CGSize(width: 2, height: 2) ,
                                shadowOpacity: 0.6,
                                shadowRadius: 5,
                              gradientColors: [UIColor.red ,UIColor.blue] ,
                              gradientStart: CGPoint(x: 0, y: 0.5) ,
                              gradientEnd: CGPoint(x: 1, y: 0.5) )
        }else if btn.tag == 508 {
            //圆角+边框+阴影+渐变
            lab1.kw_setupLayer(roundCorners: [.topLeft] ,
                                roundRadius: 35 ,
                                borderWidth: 5 ,
                                borderColor: UIColor.black ,
                                shadowColor: UIColor.red ,
                                shadowOffset: CGSize(width: 2, height: 2) ,
                                shadowOpacity: 0.6,
                                shadowRadius: 5,
                              gradientColors: [UIColor.red ,UIColor.blue] ,
                              gradientStart: CGPoint(x: 0, y: 0.5) ,
                              gradientEnd: CGPoint(x: 1, y: 0.5) )
            btn1.kw_setupLayer(roundCorners: [.topLeft] ,
                                roundRadius: 35 ,
                                borderWidth: 5 ,
                                borderColor: UIColor.black ,
                                shadowColor: UIColor.red ,
                                shadowOffset: CGSize(width: 2, height: 2) ,
                                shadowOpacity: 0.6,
                                shadowRadius: 5,
                              gradientColors: [UIColor.red ,UIColor.blue] ,
                              gradientStart: CGPoint(x: 0, y: 0.5) ,
                              gradientEnd: CGPoint(x: 1, y: 0.5) )
        }else if btn.tag == 509 {
            //边框
            lab1.kw_setupLayer( borderWidth: 5 ,
                                borderColor: UIColor.black )
            btn1.kw_setupLayer( borderWidth: 5 ,
                                borderColor: UIColor.black )
        }else if btn.tag == 510 {
            //边框+阴影
            lab1.kw_setupLayer( borderWidth: 5 ,
                                borderColor: UIColor.black ,
                                shadowColor: UIColor.red ,
                                shadowOffset: CGSize(width: 2, height: 2) ,
                                shadowOpacity: 0.6,
                                shadowRadius: 5 )
            btn1.kw_setupLayer( borderWidth: 5 ,
                                borderColor: UIColor.black ,
                                shadowColor: UIColor.red ,
                                shadowOffset: CGSize(width: 2, height: 2) ,
                                shadowOpacity: 0.6,
                                shadowRadius: 5 )
        }else if btn.tag == 511 {
            //边框+渐变
            lab1.kw_setupLayer( borderWidth: 5 ,
                                borderColor: UIColor.black ,
                              gradientColors: [UIColor.red ,UIColor.blue] ,
                              gradientStart: CGPoint(x: 0, y: 0.5) ,
                              gradientEnd: CGPoint(x: 1, y: 0.5) )
            btn1.kw_setupLayer( borderWidth: 5 ,
                                borderColor: UIColor.black ,
                              gradientColors: [UIColor.red ,UIColor.blue] ,
                              gradientStart: CGPoint(x: 0, y: 0.5) ,
                              gradientEnd: CGPoint(x: 1, y: 0.5) )
        }else if btn.tag == 512 {
            //边框+阴影+渐变
            lab1.kw_setupLayer( borderWidth: 5 ,
                                borderColor: UIColor.black ,
                                shadowColor: UIColor.red ,
                                shadowOffset: CGSize(width: 2, height: 2) ,
                                shadowOpacity: 0.6,
                                shadowRadius: 5,
                              gradientColors: [UIColor.red ,UIColor.blue] ,
                              gradientStart: CGPoint(x: 0, y: 0.5) ,
                              gradientEnd: CGPoint(x: 1, y: 0.5) )
            btn1.kw_setupLayer( borderWidth: 5 ,
                                borderColor: UIColor.black ,
                                shadowColor: UIColor.red ,
                                shadowOffset: CGSize(width: 2, height: 2) ,
                                shadowOpacity: 0.6,
                                shadowRadius: 5,
                              gradientColors: [UIColor.red ,UIColor.blue] ,
                              gradientStart: CGPoint(x: 0, y: 0.5) ,
                              gradientEnd: CGPoint(x: 1, y: 0.5) )
        }else if btn.tag == 513 {
            //阴影
            lab1.kw_setupLayer(
                                shadowColor: UIColor.red ,
                                shadowOffset: CGSize(width: 2, height: 2) ,
                                shadowOpacity: 0.6,
                                shadowRadius: 5)
            btn1.kw_setupLayer(
                                shadowColor: UIColor.red ,
                                shadowOffset: CGSize(width: 2, height: 2) ,
                                shadowOpacity: 0.6,
                                shadowRadius: 5)
        }else if btn.tag == 514 {
            //阴影+渐变
            lab1.kw_setupLayer(
                                shadowColor: UIColor.red ,
                                shadowOffset: CGSize(width: 2, height: 2) ,
                                shadowOpacity: 0.6,
                                shadowRadius: 5,
                              gradientColors: [UIColor.red ,UIColor.blue] ,
                              gradientStart: CGPoint(x: 0, y: 0.5) ,
                              gradientEnd: CGPoint(x: 1, y: 0.5) )
            btn1.kw_setupLayer(
                                shadowColor: UIColor.red ,
                                shadowOffset: CGSize(width: 2, height: 2) ,
                                shadowOpacity: 0.6,
                                shadowRadius: 5,
                              gradientColors: [UIColor.red ,UIColor.blue] ,
                              gradientStart: CGPoint(x: 0, y: 0.5) ,
                              gradientEnd: CGPoint(x: 1, y: 0.5) )
        }else if btn.tag == 515 {
            //渐变
            lab1.kw_setupLayer(
                              gradientColors: [UIColor.red ,UIColor.blue] ,
                              gradientStart: CGPoint(x: 0, y: 0.5) ,
                              gradientEnd: CGPoint(x: 1, y: 0.5) )
            btn1.kw_setupLayer(
                              gradientColors: [UIColor.red ,UIColor.blue] ,
                              gradientStart: CGPoint(x: 0, y: 0.5) ,
                              gradientEnd: CGPoint(x: 1, y: 0.5) )
        }
        
        
        
    }
    
    
    
}


