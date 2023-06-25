//
//  KWNavigationVC1.swift
//  KW
//
//  Created by 渴望 on 2023/6/19.
//

import UIKit

class KWNavigationVC1: UIViewController,UIScrollViewDelegate {

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        nav_color_gradient(.white)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nav_color_gradient(.white)
        
        view.backgroundColor = .cyan
        self.title = "23333"
        
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: KScreenHeight, height: KScreenHeight))
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: 0, height: KScreenHeight*2)
        view.addSubview(scrollView)
        
        let img = UIImageView(frame: CGRect(x: 0, y: -KNavigationStatusHeight, width: KScreenWidth, height: 800))
        img.contentMode = .scaleToFill
        img.image = UIImage(named: "ic_video_dhTBG")
        scrollView.addSubview(img)
    }
    
    

    
    @objc func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        let progress = min(1, max(0, contentOffsetY / 60))
        if progress < 0.1 {
            kw_statusBarStyle = .lightContent
            kw_tintColor = .white
            kw_titleColor = .white
        } else {
            if #available(iOS 13.0, *) {
                kw_statusBarStyle = .darkContent
            } else {
                kw_statusBarStyle = .default
            }
            kw_tintColor = UIColor(white: 0, alpha: progress)
            kw_titleColor = UIColor(white: 0, alpha: progress)
        }
        kw_barAlpha = progress
    }
    

}
