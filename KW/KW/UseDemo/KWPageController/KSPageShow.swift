//
//  KSPageShow.swift
//  KW
//
//  Created by 渴望 on 2023/7/3.
//

import UIKit

class KSPageShow: KSPageController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func kw_initData() {
        super.kw_initData()
        
        titleArr = ["全部","待付款","待发货","待收货","售后服务和退款服务","售后服务和退款服务","售后服务和退款服务","售后服务和退款服务","售后服务和退款服务","售后服务和退款服务","售后服务和退款服务","售后服务和退款服务","售后服务和退款服务"]
        vcArr = [KSPageController1(),KSPageController2(),KSPageController3(),KSPageController4(),KSPageController5(),KSPageController5(),KSPageController5(),KSPageController5(),KSPageController5(),KSPageController5(),KSPageController5(),KSPageController5(),KSPageController5()]
        
        titleView.ArrangementType = 3
        titleView.titleArr = titleArr
        titleView.selectedIndex = 2
        
    }
    
    override func kw_initUI() {
        super.kw_initUI()
        
    }

}
