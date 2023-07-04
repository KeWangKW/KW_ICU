//
//  KSTitleView.swift
//  KW
//
//  Created by 渴望 on 2023/7/3.
//

import UIKit


@objcMembers class KSTitleView: UIView {
    var changeSelected: ((Int) -> Void)?
    
    var titleArr:[String] = []
    
    //1_平均排列（默认） 2_固定宽度 3_自适应宽度
    var ArrangementType:Int = 1
    var fixdWidth:CGFloat = 80 //固定宽度值
    var adaptSpace:CGFloat = 10 //自适应宽度 文字左右间距
    
    
    var selectedIndex:Int = 0
    {
        didSet{
            if isCanViewChnage {
                ViewChange(selectedIndex+1000)
            }
        }
    }

   
    
    var underLineColor               = UIColor.black
    var underLineSize                = CGSize(width: 40, height: 4)
    var underLineRadius:CGFloat      = 2
    var underLineBottomSpace:CGFloat = 2
    var normalTitleColor             = UIColor.lightGray
    var selectTitleColor             = UIColor.black
    var normalTitleFont              = UIFont.systemFont(ofSize: 14)
    var selectTitleFont              = UIFont.systemFont(ofSize: 15, weight: .bold)

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(TitleScrollView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    

    @objc func reloadSubviews() {
        
        
        TitleUnderLine.backgroundColor = underLineColor
        TitleUnderLine.layer.masksToBounds = true
        TitleUnderLine.layer.cornerRadius = underLineRadius
        
        let bg_width = TitleScrollView.bounds.size.width
        let bg_height = TitleScrollView.bounds.size.height
        
        if ArrangementType == 1 {
            TitleScrollView.contentSize = CGSize(width: bg_width, height: 0)
        }else if ArrangementType == 2 {
            TitleScrollView.contentSize = CGSize(width: fixdWidth*CGFloat(titleArr.count), height: 0)
        }else{
            
        }
        
        var frame_x:CGFloat = 0
        
        for idx in 0..<titleArr.count {
            let btn = UIButton()
            btn.setTitle(titleArr[idx], for: .normal)
//            btn.backgroundColor = .random
            btn.tag = 1000+idx
            btn.addTarget(self, action: #selector(btnClick(btn:)), for: .touchUpInside)
            btn.setTitleColor(normalTitleColor, for: .normal)
            btn.setTitleColor(selectTitleColor, for: .selected)
            
            if ArrangementType == 1 {
                btn.frame = CGRect(x: CGFloat(idx)*bg_width/CGFloat(titleArr.count), y: 0, width: bg_width/CGFloat(titleArr.count), height: bg_height)
            }else if ArrangementType == 2 {
                btn.frame = CGRect(x: CGFloat(idx)*fixdWidth, y: 0, width: fixdWidth, height: bg_height)
            }else{
                let font = normalTitleFont.pointSize > selectTitleFont.pointSize ? normalTitleFont : selectTitleFont
                let width = widthForText(str: titleArr[idx], font: font, size: CGSize(width: bg_width*2, height: bg_height)) + adaptSpace*2
                btn.frame = CGRect(x: frame_x, y: 0, width: width, height: bg_height)
                frame_x += width
                if idx == titleArr.count-1 {
                    TitleScrollView.contentSize = CGSize(width: frame_x, height: 0)
                }
            }
            
            if idx == selectedIndex {
                let line_x = btn.frame.origin.x + btn.frame.size.width/2 - underLineSize.width/2
                TitleUnderLine.frame = CGRect(x: line_x, y: self.bounds.size.height-underLineBottomSpace-underLineSize.height, width: underLineSize.width, height: underLineSize.height)
                btn.titleLabel?.font = selectTitleFont
                btn.isSelected = true
                
                contentOffsetChange(btn)
            }else{
                btn.titleLabel?.font = normalTitleFont
                btn.isSelected = false
            }
            
            TitleScrollView.addSubview(btn)
        }
        
        TitleScrollView.addSubview(TitleUnderLine)
    }
    
    private lazy var TitleScrollView:UIScrollView = {
        let v = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        v.showsVerticalScrollIndicator = false
        v.showsHorizontalScrollIndicator = false
        return v
    }()
    private lazy var TitleUnderLine:UIView = {
        let v = UIView()
        return v
    }()
    
    private func widthForText(str: String, font: UIFont, size: CGSize) -> CGFloat {
        let attributes = [NSAttributedString.Key.font: font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        return (str as NSString).boundingRect(with: size, options: option, attributes: attributes, context: .none).size.width
    }
    
    private var isCanViewChnage:Bool = true
}

extension KSTitleView {
    
    
    @objc private func btnClick(btn:UIButton) {
        isCanViewChnage = false
        self.selectedIndex = btn.tag - 1000
        ViewChange(btn.tag)
        
    }
    
    private func ViewChange(_ selTag:Int) {
        isCanViewChnage = true
        print("选中\(selectedIndex)")
        for idx in 0..<titleArr.count {
            if let button = viewWithTag(1000+idx) as? UIButton {
                if button.tag == selTag{
                    
                    
                    let line_x = button.frame.origin.x + button.frame.size.width/2 - underLineSize.width/2
                    UIView.animate(withDuration: 0.2) {
                        self.TitleUnderLine.frame = CGRect(x: line_x, y: self.bounds.size.height-self.underLineBottomSpace-self.underLineSize.height, width: self.underLineSize.width, height: self.underLineSize.height)
                    }
                    
                    button.titleLabel?.font = selectTitleFont
                    button.isSelected = true
                    
                    contentOffsetChange(button)
                    
                    changeSelected?(selectedIndex)
                }else{
                    button.titleLabel?.font = normalTitleFont
                    button.isSelected = false
                }
            }
            
        }
        
    }
    
    private func contentOffsetChange(_ btn:UIButton) {
        let bg_width = TitleScrollView.bounds.size.width
        if (btn.frame.origin.x + btn.frame.size.width - TitleScrollView.contentOffset.x) > bg_width {
            UIView.animate(withDuration: 0.2) {
                self.TitleScrollView.contentOffset = CGPoint(x: (btn.frame.origin.x + btn.frame.size.width - bg_width), y: 0)
//                if btn.tag-1000 == self.titleArr.count-1 {
//                    self.TitleScrollView.contentOffset = CGPoint(x: (btn.frame.origin.x + btn.frame.size.width - bg_width), y: 0)
//                }else{
//                    self.TitleScrollView.contentOffset = CGPoint(x: (btn.frame.origin.x + btn.frame.size.width*1.5 - bg_width), y: 0)
//                }
                
            }
        }else if TitleScrollView.contentOffset.x > btn.frame.origin.x {
            UIView.animate(withDuration: 0.2) {
                self.TitleScrollView.contentOffset = CGPoint(x: btn.frame.origin.x, y: 0)
//                if btn.tag-1000 == 0 {
//                    self.TitleScrollView.contentOffset = CGPoint(x: btn.frame.origin.x, y: 0)
//                }else{
//                    self.TitleScrollView.contentOffset = CGPoint(x: btn.frame.origin.x*0.5, y: 0)
//                }
                
            }
        }
    }
    
}


