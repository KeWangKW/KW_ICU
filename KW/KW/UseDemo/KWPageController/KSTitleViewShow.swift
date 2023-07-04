//
//  KSTitleViewShow.swift
//  KW
//
//  Created by 渴望 on 2023/7/3.
//

import UIKit

class KSTitleViewShow: KSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
        // Do any additional setup after loading the view.
        
        
        titleView1.titleArr = ["全部","待付款","待发货","待收货","售后"]
        titleView1.ArrangementType = 1
        titleView1.selectedIndex = 2
        titleView1.underLineSize = CGSize(width: 20, height: 5)
        titleView1.underLineColor = UIColor.red
        titleView1.underLineBottomSpace = 5
        titleView1.underLineRadius = 2.5
        titleView1.reloadSubviews()
        titleView1.changeSelected = { idx in
            print(idx)
        }
        titleView1.backgroundColor = .yellow
        view.addSubview(titleView1)
        
        
        titleView2.titleArr = ["全部","待付款","待发货","待收货","售后服务和退款服务","售后服务","售后服务","售后服务","售后服务","售后服务","售后服务","售后服务","售后服务"]
        titleView2.ArrangementType = 2
        titleView2.fixdWidth = 100
        titleView2.selectedIndex = 2
        titleView2.reloadSubviews()
        titleView2.changeSelected = { idx in
            print(idx)
        }
        titleView2.backgroundColor = .yellow
        view.addSubview(titleView2)
           
        
        titleView3.titleArr = ["全部","待付款","待发货","待收货","售后服务和退款服务","售后服务和退款服务","售后服务和退款服务","售后服务和退款服务","售后服务和退款服务","售后服务和退款服务","售后服务和退款服务","售后服务和退款服务","售后服务和退款服务"]
        titleView3.ArrangementType = 3
        titleView3.selectedIndex = 2
        titleView3.reloadSubviews()
        titleView3.changeSelected = { idx in
            print(idx)
        }
        titleView3.backgroundColor = .yellow
        view.addSubview(titleView3)
        
        
        view.addSubview(lab1)
        view.addSubview(lab2)
        view.addSubview(lab3)
        
        let btn = UIButton(frame: CGRect(x: 0, y: KScreenHeight-KNavigationStatusHeight-50-100, width: 200, height: 100))
        btn.backgroundColor = .black
        btn.setTitle("修改选中位置为1", for: .normal)
        btn.addTarget(self, action: #selector(btnClcik), for: .touchUpInside)
        view.addSubview(btn)
    }
    
    @objc func btnClcik() {
        titleView1.selectedIndex = 1
        titleView2.selectedIndex = 1
        titleView3.selectedIndex = 1
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    lazy var lab1:UILabel = {
        let lab = UILabel(frame: CGRect(x: 0, y: KNavigationStatusHeight, width: KScreenWidth, height: 50))
        lab.text = "宽度均分";
        return lab
    }()
    
    lazy var titleView1:KSTitleView = {
        let v = KSTitleView(frame: CGRect(x: 10, y: KNavigationStatusHeight+50, width: KScreenWidth-20, height: 50))
        return v
    }()
    
    lazy var lab2:UILabel = {
        let lab = UILabel(frame: CGRect(x: 0, y: KNavigationStatusHeight+100, width: KScreenWidth, height: 50))
        lab.text = "宽度固定100";
        return lab
    }()
    
    lazy var titleView2:KSTitleView = {
        let v = KSTitleView(frame: CGRect(x: 10, y: KNavigationStatusHeight + 150, width: KScreenWidth-20, height: 50))
        return v
    }()
    
    lazy var lab3:UILabel = {
        let lab = UILabel(frame: CGRect(x: 0, y: KNavigationStatusHeight+200, width: KScreenWidth, height: 50))
        lab.text = "宽度根据文字自适应 + 文字左右间距";
        return lab
    }()
    
    lazy var titleView3:KSTitleView = {
        let v = KSTitleView(frame: CGRect(x: 10, y: KNavigationStatusHeight + 250, width: KScreenWidth-20, height: 50))
        return v
    }()

}
