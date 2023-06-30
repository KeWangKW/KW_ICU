//
//  TestCollectionVCShow1.swift
//  KW
//
//  Created by 渴望 on 2023/6/28.
//

import UIKit

class TestCollectionVCShow1: KSCollectionVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func kw_initData() {
        super.kw_initData()
        
        emptyDataSetImage = UIImage(named: "ic_sxy_searchBG")
        emptyDataSetTitle = "列表为空"
        emptyDataSetDescription = "暂无数据"
        
        isAddRefreshFooter = true
        isAddRefreshHeader = true
        
        DataArr.append(Section0Arr)
        DataArr.append(Section1Arr)
        
        
        
        
        collectionView.kw_register(cell: TestCollectionVCShowCell.self, isXib: true)
        collectionView.kw_register(cell: TestCollectionVCShowCell1.self, isXib: false)
        collectionView.kw_register(header: testHeaderView.self, isXib: false)
        collectionView.kw_register(footer: testHeaderView.self, isXib: false)
    }
    
    override func kw_initUI() {
        super.kw_initUI()
        collectionView.backgroundColor = UIColor.red
        collectionView.frame = CGRect(x: 0, y: KNavigationStatusHeight, width: KScreenWidth, height: KScreenHeight-KNavigationStatusHeight)
        
        let layout = KWFlowLayout()
        layout.stickyHeaders = [0,1]
//        layout.stickyAllHeader = true
        collectionView.collectionViewLayout = layout
    }
    
    
    override func kw_requestData() {
        super.kw_requestData()
        
        //模拟数据请求
        let SSSS = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomStringArr:[String] = []
        for _ in 1..<20 {
            let ssss = String(SSSS.map { String($0) }.randomElement()!)
            randomStringArr.append(ssss)
        }

        pageCount = 3

        refreshCell(randomStringArr)
    }
    
    func refreshCell(_ arr:[String]) { //此方法仅供演示处理
        
        if page == 1 {
            for string in arr {
                let item = TestCollectionVCShowCellItem()
                item.str = string
                DataArr[0].append(item)
            }
        }
        
        for string in arr {
            let item = TestCollectionVCShowCell1Item()
            item.str = string
            DataArr[1].append(item)
        }
        
        kw_collectionViewReloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = DataArr[indexPath.section][indexPath.row] as? TestCollectionVCShowCellItem{
            print(item.str)
        }
    }

}

extension TestCollectionVCShow1 {
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.kw_dequeue(header: testHeaderView.self, for: indexPath)
            if indexPath.section == 0 {
                header.testLab.text = "Section0 header view";
            }else{
                header.testLab.text = "Section1 header view";
            }
            header.backgroundColor = .purple
            return header
        } else if kind == UICollectionView.elementKindSectionFooter {
            let footer  = collectionView.kw_dequeue(footer: testHeaderView.self, for: indexPath)
            if indexPath.section == 0 {
                footer.testLab.text = "Section0 Footer view";
            }else{
                footer.testLab.text = "Section1 Footer view";
            }
            footer.backgroundColor = .systemBlue
            return footer
        }
        return UICollectionReusableView()
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: KScreenWidth, height: 30)
        }else{
            return CGSize(width: KScreenWidth, height: 40)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: KScreenWidth, height: 20)
        }else{
            return CGSize(width: KScreenWidth, height: 20)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
//    func columnNumber(collectionView collection: UICollectionView, layout: KWFlowLayout, section: Int) -> Int {
//        if section == 0 {
//            return 3
//        }else{
//            return 2
//        }
//    }
    
//    func referenceSizeForHeader(collectionView collection: UICollectionView, layout: KWFlowLayout, section: Int) -> CGSize {
//        if section == 0 {
//            return CGSize(width: KScreenWidth, height: 30)
//        }else{
//            return CGSize(width: KScreenWidth, height: 40)
//        }
//    }
//
//    func referenceSizeForFooter(collectionView collection: UICollectionView, layout: KWFlowLayout, section: Int) -> CGSize {
//        if section == 0 {
//            return CGSize(width: KScreenWidth, height: 20)
//        }else{
//            return CGSize(width: KScreenWidth, height: 20)
//        }
//    }
//
//    func insetForSection(collectionView collection: UICollectionView, layout: KWFlowLayout, section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//    }
    
//    func lineSpacing(collectionView collection: UICollectionView, layout: KWFlowLayout, section: Int) -> CGFloat {
//        return 10
//    }
//    
//    func interitemSpacing(collectionView collection: UICollectionView, layout: KWFlowLayout, section: Int) -> CGFloat {
//        return 10
//    }
    
    
    
}




class testHeaderView: UICollectionReusableView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configBaseView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configBaseView() {
    addSubview(testLab)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    testLab.frame = bounds
  }
  
  lazy var testLab: UILabel = {
    let tmp = UILabel()
    tmp.textColor = .white
    tmp.font = .systemFont(ofSize: 14)
    tmp.textAlignment = .center
    tmp.numberOfLines = 0
    return tmp
  }()
}

