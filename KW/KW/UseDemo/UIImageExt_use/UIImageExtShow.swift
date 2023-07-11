//
//  UIImageExtShow.swift
//  KW
//
//  Created by 渴望 on 2023/7/6.
//

import UIKit

class UIImageExtShow: KSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: KNavigationStatusHeight, width: KScreenWidth, height: KScreenHeight-KNavigationStatusHeight))
        scrollView.backgroundColor = .cyan
        scrollView.contentSize = CGSize(width: 0, height: KScreenHeight*2)
        view.addSubview(scrollView)

        
        let image = UIImage(named: "icon_gongzuotai02")
        //原图标
        let imageView = UIImageView(frame: CGRect(x: 10, y: 20, width: 60, height: 60))
        imageView.image = image
        scrollView.addSubview(imageView)
        //修改成红色
        let imageView1 = UIImageView(frame: CGRect(x: 100, y: 20, width: 60, height: 60))
        imageView1.image = image!.kw_tintColor(.red)
        scrollView.addSubview(imageView1)
        //压缩0.1
        let imageView2 = UIImageView(frame: CGRect(x: 190, y: 20, width: 60, height: 60))
        imageView2.image = image!.kw_compressed(quality: 0.1)
        scrollView.addSubview(imageView2)
        //指定压缩
        let imageView3 = UIImageView(frame: CGRect(x: 260, y: 20, width: 60, height: 60))
        imageView3.image = UIImage(data: (image!.kw_compressedToData(maxSize: 2))!)
        scrollView.addSubview(imageView3)
        
        
        let imageM = UIImage(named: "233")
        //原图片
        let imageViewM1 = UIImageView(frame: CGRect(x: 10, y: 100, width: 207, height: 155))
        imageViewM1.image = imageM
        scrollView.addSubview(imageViewM1)
        //裁剪
        let imageViewM2 = UIImageView(frame: CGRect(x: 10, y: 265, width: 207, height: 155))
        imageViewM2.image = imageM!.kw_cropped(to: CGRect(x: 150, y: 20, width: 200, height: 200))
        scrollView.addSubview(imageViewM2)
        //系统压缩 jpegData(compressionQuality:)
        let imageViewM3 = UIImageView(frame: CGRect(x: 10, y: 430, width: 207, height: 155))
        imageViewM3.image = imageM!.kw_compressed(quality: 0.1)
        scrollView.addSubview(imageViewM3)
        print(imageViewM3.image?.kw_kb)
        //指定压缩
        let imageViewM4 = UIImageView(frame: CGRect(x: 10, y: 595, width: 207, height: 155))
        imageViewM4.image = UIImage(data: (imageM?.kw_compressedToData(maxSize: 100))!)
        scrollView.addSubview(imageViewM4)
        
        
        
        
        
        let btn = UIButton(frame: CGRect(x: 10, y: 770, width: 300, height: 40))
        btn.backgroundColor = UIColor.black
        btn.setTitle("选择视频", for: .normal)
        btn.addTarget(self, action: #selector(TZImagePickerSel), for: .touchUpInside)
        scrollView.addSubview(btn)
        
        
        
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func TZImagePickerSel(){
        
        let tz = TZImagePickerController()
        tz.maxImagesCount = 1
        tz.allowPickingGif = false
        tz.allowPickingImage = false
        tz.allowPickingVideo = true
        tz.didFinishPickingVideoHandle = { coverImage,asset in
            
            UIImage.kw_compressedVideoToUrlStr(asset!) { urlStr ,size ,duration in
                print(urlStr ?? "")
                UIImage.removeFile(filePath: urlStr!)
            }
            
        }
        
        self.present(tz, animated: true)
    }
    
    

}
