//
//  ViewController.swift
//  KW
//
//  Created by 渴望 on 2023/6/13.
//

import UIKit

class ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.red;
        
        view.addSubview(tableView)
    }

    let dataArr:[String] = ["KWTabBar",
    "KWColor",
    "KWNavigation",
    "KWViewController",
    "KWTableViewController",
    "KWCollectionViewController"];
    
    
    lazy var tableView: UITableView =  {
        let table = UITableView.init(frame: CGRect(x: 0, y: KNavigationStatusHeight, width: KScreenWidth, height: KScreenHeight-KNavigationStatusHeight), style: .plain)
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.tableFooterView = UIView()
        table.tableHeaderView = UIView.init(frame: CGRect.init(origin: .zero, size: CGSize(width: 1, height: CGFloat.leastNormalMagnitude)))
        table.estimatedSectionHeaderHeight = 0
        table.estimatedSectionFooterHeight = 0
        if #available(iOS 11.0, *) {
            table.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        if #available(iOS 15.0, *) {
            table.sectionHeaderTopPadding = 0
        }
        return table
    }()
    
    let ss = CGRect(x: KAdapt(20), y: KAdapt(20), width: KAdapt(100), height: KAdapt(100))
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: NSString(format: "%d%d",indexPath.section,indexPath.row) as String)
        
        cell.textLabel?.text = dataArr[indexPath.row]
        cell.backgroundColor = .KW_L(.section)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            let vc = TabBarDemoVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 1 {
            let vc = KWColorDemoVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 2 {
            let vc = KWNavigationVC()
            let nav = KWNavigationController(rootViewController: vc)
            self.changeRootViewController(vc: nav)
        }else if indexPath.row == 3 {
            let vc = TestBaseVC()
            let nav = KWNavigationController(rootViewController: vc)
            self.changeRootViewController(vc: nav)
        }else if indexPath.row == 4 {
            let vc = TestTableView()
            let nav = KWNavigationController(rootViewController: vc)
            self.changeRootViewController(vc: nav)
        }else if indexPath.row == 5 {
            let vc = TestCollectionVC()
            let nav = KWNavigationController(rootViewController: vc)
            self.changeRootViewController(vc: nav)
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    func changeRootViewController(vc:UIViewController) {
        if #available(iOS 15.0, *) {
            let scenes = UIApplication.shared.connectedScenes
            let windowScene = scenes.first as? UIWindowScene

            if let windowScene = windowScene {
                windowScene.keyWindow?.rootViewController = vc
                windowScene.keyWindow?.makeKeyAndVisible()
            }
        }else{
            UIApplication.shared.windows.first?.rootViewController = vc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
    }
    
    
}

