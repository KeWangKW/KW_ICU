//
//  KSPageController.swift
//  KW
//
//  Created by 渴望 on 2023/7/3.
//

import UIKit

class KSPageController: KSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    
    
    var titleArr:[String] = []
    var vcArr:[UIViewController] = []
    
    
    override func kw_initData() {
        super.kw_initData()
        
        
        
    }
    
    override func kw_initUI() {
        super.kw_initUI()
        
        if titleArr.count != vcArr.count {
            print("titleArr 和 vcArr 数量不匹配")
            return
        }
        
        titleView.reloadSubviews()
        weak var weakSelf = self
        titleView.changeSelected = { idx in
            
            let vc = (weakSelf?.vcArr[idx])!
            vc.viewWillAppear(true) //手动调用
            
            UIView.animate(withDuration: 0.2) {
                weakSelf?.VCScrollView.contentOffset = CGPoint(x: (weakSelf?.VCScrollView.frame.size.width)! * CGFloat(idx), y: 0)
            }
        }
        
        view.addSubview(titleView)
        view.addSubview(VCScrollView)
//        VCScrollView.panGestureRecognizer.addTarget(self, action: #selector(handlePanGesture(_:)))

        addVC()
        
        // 处理右滑返回冲突
        // 设置popGesture优先
        if let popGesture = self.navigationController?.interactivePopGestureRecognizer {
            self.VCScrollView.panGestureRecognizer.require(toFail: popGesture)
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    lazy var titleView:KSTitleView = {
        let v = KSTitleView(frame: CGRect(x: 0, y: KNavigationStatusHeight, width: KScreenWidth, height: 50))
        return v
    }()
    
    private lazy var VCScrollView:UIScrollView = {
        let v = UIScrollView(frame: CGRect(x: 0, y: KNavigationStatusHeight+titleView.frame.size.height, width: KScreenWidth, height: KScreenHeight-KNavigationStatusHeight-titleView.frame.size.height))
        v.isPagingEnabled = true
        //v.bounces = false
        v.showsVerticalScrollIndicator = false
        v.showsHorizontalScrollIndicator = false
        v.delegate = self
        return v
    }()
    
    

//    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
//        let translation = gesture.translation(in: view)
//        let velocity = gesture.velocity(in: view)
//
//        if gesture.state == .ended {
//            if translation.x > 100 && velocity.x > 0 && titleView.selectedIndex == 0 {
//                navigationController?.popViewController(animated: true)
//            }
//        }
//    }
    
}

extension KSPageController {
    
    func addVC() {
        VCScrollView.contentSize = CGSize(width: VCScrollView.frame.size.width * CGFloat(titleArr.count), height: 0)
        VCScrollView.contentOffset = CGPoint(x: (VCScrollView.frame.size.width) * CGFloat(titleView.selectedIndex), y: 0)
        
        for idx in 0..<titleArr.count {
            
            let vc = vcArr[idx]
            vc.view.frame = CGRect(x: VCScrollView.frame.size.width * CGFloat(idx), y: 0, width: VCScrollView.frame.size.width, height: VCScrollView.frame.size.height)
            VCScrollView.addSubview(vc.view)
            
            //此写法不会调用 viewWillAppear viewDidAppear 等方法，可手动调用
            vc.viewWillAppear(true)
        }
    }
    
}

extension KSPageController:UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let off = self.VCScrollView.contentOffset.x/VCScrollView.frame.size.width
//        if off.truncatingRemainder(dividingBy: 1) == 0 && Int(off) != titleView.selectedIndex {
//            titleView.selectedIndex = Int(off)
//        }
//    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(self.VCScrollView.contentOffset.x/VCScrollView.frame.size.width)
        titleView.selectedIndex = page
    }
}

