//
//  UIImageExt.swift
//  KW
//
//  Created by 渴望 on 2023/7/6.
//

import UIKit
import Photos

public extension UIImage {
    
    //MARK: 修改图片颜色
    /// 修改图片颜色
    @objc func kw_tintColor(_ color: UIColor) -> UIImage {
        if #available(iOS 13.0, *) {
            return self.withTintColor(color)
        } else {
            UIGraphicsBeginImageContextWithOptions(CGSize(width: self.size.width, height: self.size.height), false, 5)
            let context = UIGraphicsGetCurrentContext()
            context?.translateBy(x: 0, y: self.size.height)
            context?.scaleBy(x: 1.0, y: -1.0)
            context?.setBlendMode(CGBlendMode.normal)
            let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
            context?.clip(to: rect, mask: self.cgImage!)
            color.setFill()
            context?.fill(rect)
            let newImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            return newImage
        }
    }
    
    //MARK: 内存大小 kb
    /// 内存大小 kb
    @objc var kw_kb: Int {
        return (self.jpegData(compressionQuality: 1.0)?.count ?? 0) / 1024
    }
    
//----------------------------------------------------------------------------------
//压缩图片
    //MARK: 压缩图片
    /// 压缩图片  压缩质量 默认0.5
    @objc func kw_compressed(quality: CGFloat = 0.5) -> UIImage? {
        guard let data = self.jpegData(compressionQuality: quality) else { return nil }
        return UIImage(data: data)
    }
    
    //MARK: 图片转base64字符串
    /// 图片转base64字符串  压缩质量 默认0.5
    @objc func kw_toBase64(quality: CGFloat = 0.5) -> String? {
        guard let data = self.jpegData(compressionQuality: quality) else { return nil }
        return data.base64EncodedString()
    }

    //MARK: 图片转data
    /// 图片转data  压缩质量 默认0.5
    @objc func kw_toData(quality: CGFloat = 0.5) -> Data? {
        return self.jpegData(compressionQuality: quality)
    }
//----------------------------------------------------------------------------------
//压缩图片，可指定压缩后的大小，返回压缩后的Data，
    //MARK: 压缩图片
    ///压缩图片 maxSize：指定压缩到的大小 单位kb
    @objc func kw_compressedToData(maxSize: Int) -> Data? {
        if let finallImageData = self.jpegData(compressionQuality: 1.0) {
            return UIImage.resetSizeOfImageData(sourceData: finallImageData, maxSize: maxSize)
        }
        return nil
    }
//----------------------------------------------------------------------------------
    
    //MARK: 裁剪图片
    /// 裁剪图片 rect: 裁剪的位置
    @objc func kw_cropped(to rect: CGRect) -> UIImage {
        guard rect.size.width <= self.size.width && rect.size.height <= self.size.height else { return self }
        let scaledRect = rect.applying(CGAffineTransform(scaleX: self.scale, y: self.scale))
        guard let image = self.cgImage?.cropping(to: scaledRect) else { return self }
        return UIImage(cgImage: image, scale: self.scale, orientation: self.imageOrientation)
    }
    
    //MARK: 图片保存到本地
    /// 图片保存到本地
    /// - Parameter completion: 回调（yes or no）
    @objc func kw_saveLocally(_ completion: ((Bool) -> ())? = nil) {
        self.saveToLocation(completion)
    }
    
    typealias SaveCompletion = (Bool) -> ()
    
    struct AssociatedKeys {
        static var saveKey = "saveKey"
    }
    
    private var completion: SaveCompletion? {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.saveKey) as? SaveCompletion ?? nil}
        set { objc_setAssociatedObject(self, &AssociatedKeys.saveKey, newValue, .OBJC_ASSOCIATION_COPY)}
    }
    
    private func saveToLocation(_ completion: SaveCompletion? = nil) {
        self.completion = completion
        UIImageWriteToSavedPhotosAlbum(self, self, #selector(image(image:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc private func image(image: UIImage, didFinishSavingWithError: NSError?, contextInfo: AnyObject) {
        completion?(didFinishSavingWithError == nil)
    }
    
    
    
    
}


public extension UIImage {

    class func resetSizeOfImageData(sourceData: Data, maxSize: Int) -> Data? {
        
        //先判断当前质量是否满足要求，不满足再进行压缩
        guard let sourceImage = UIImage(data: sourceData) else {
            return nil
        }
        var finallImageData = sourceData
        let sizeOrigin      = finallImageData.count
        let sizeOriginKB    = sizeOrigin / 1024
        print("压缩前：\(sizeOriginKB) kb")
        if sizeOriginKB <= maxSize {
            print("压缩后：\(sizeOriginKB) kb")
            return finallImageData
        }

        //获取原图片宽高比
        let sourceImageAspectRatio = sourceImage.size.width/sourceImage.size.height
        //先调整分辨率
        var defaultSize = CGSize(width: 1024, height: 1024/sourceImageAspectRatio)
        guard let newImage = self.newSizeImage(size: defaultSize, sourceImage: sourceImage) else {
            return nil
        }
        
        guard let newImageData  = newImage.jpegData(compressionQuality: 1.0) else {
            return nil
        }
        finallImageData = newImageData
        //保存压缩系数
        var compressionQualityArr: [CGFloat] = []
        let avg = CGFloat(1.0/250)
        var value = avg
        
        var i = 250
        repeat {
            i -= 1
            value = CGFloat(i)*avg
            compressionQualityArr.append(value)
        } while i >= 1
        
        /*
         调整大小
         说明：压缩系数数组compressionQualityArr是从大到小存储。
         */
        //思路：使用二分法搜索
        
        guard let halfData = self.halfFuntion(arr: compressionQualityArr, image: newImage, sourceData: finallImageData, maxSize: maxSize) else {
            return nil
        }
        finallImageData = halfData
        
        //如果还是未能压缩到指定大小，则进行降分辨率
        while finallImageData.count == 0 {
            //每次降100分辨率
            let reduceWidth = 100.0
            let reduceHeight = 100.0/sourceImageAspectRatio
            if (defaultSize.width-CGFloat(reduceWidth)) <= 0 || (defaultSize.height-CGFloat(reduceHeight)) <= 0 {
                break
            }
            defaultSize = CGSize(width: (defaultSize.width-CGFloat(reduceWidth)), height: (defaultSize.height-CGFloat(reduceHeight)))
            
            guard let lastCompressionData = newImage.jpegData(compressionQuality: compressionQualityArr.last ?? 1) else {
                return nil
            }
            guard let lastCompressionImage = UIImage.init(data: lastCompressionData) else {
                return nil
            }
            guard let image = self.newSizeImage(size: defaultSize, sourceImage: lastCompressionImage) else {
                return nil
            }
            
            guard let sourceData = image.jpegData(compressionQuality: 1.0),
                let halfData = halfFuntion(arr: compressionQualityArr, image: image, sourceData: sourceData, maxSize: maxSize) else {
                    return nil
            }
            finallImageData = halfData
        }
        print("压缩后：\(finallImageData.count/1024) kb")
        return finallImageData
    }
    
    // MARK: - 调整图片分辨率/尺寸（等比例缩放）
    class func newSizeImage(size: CGSize, sourceImage: UIImage) -> UIImage? {
        var newSize = CGSize(width: sourceImage.size.width, height: sourceImage.size.height)
        let tempHeight = newSize.height / size.height
        let tempWidth = newSize.width / size.width
        
        if tempWidth > 1.0 && tempWidth > tempHeight {
            newSize = CGSize(width: sourceImage.size.width / tempWidth, height: sourceImage.size.height / tempWidth)
        } else if tempHeight > 1.0 && tempWidth < tempHeight {
            newSize = CGSize(width: sourceImage.size.width / tempHeight, height: sourceImage.size.height / tempHeight)
        }
        
        UIGraphicsBeginImageContext(newSize)
        sourceImage.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    // MARK: - 二分法
    class func halfFuntion(arr: [CGFloat], image: UIImage, sourceData finallImageData: Data, maxSize: Int) -> Data? {
        var tempFinallImageData = finallImageData
        
        var tempData = Data.init()
        var start = 0
        var end = arr.count - 1
        var index = 0
        
        var difference = Int.max
        while start <= end {
            index = start + (end - start)/2
            
            guard let imageJpegData = image.jpegData(compressionQuality: arr[index]) else {
                return nil
            }
            tempFinallImageData = imageJpegData
            
            let sizeOrigin = tempFinallImageData.count
            let sizeOriginKB = sizeOrigin / 1024
            
            //print("当前降到的质量：\(sizeOriginKB)\n\(index)----\(arr[index])")
            
            if sizeOriginKB > maxSize {
                start = index + 1
            } else if sizeOriginKB < maxSize {
                if maxSize-sizeOriginKB < difference {
                    difference = maxSize-sizeOriginKB
                    tempData = tempFinallImageData
                }
                if index<=0 {
                    break
                }
                end = index - 1
            } else {
                break
            }
        }
        return tempData
    }
}


public extension UIImage {
    //MARK: 压缩视频
    ///TZImagePick 选择视频 iCloud视频需要下载下来
    /// PHAsset 转成 AVURLAsset 后 执行压缩 返回视频链接
    @objc class func kw_compressedVideoToUrlStr(_ asset: PHAsset , completion: @escaping (String? ,CGSize ,Int) -> Void) {
//        let vc = UIViewController.kw.currentController()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//            self.hud = MBProgressHUD.showAdded(to: vc!.view, animated: true)
//            self.hud.isUserInteractionEnabled = false
//            self.hud.mode = .annularDeterminate
//            self.hud.label.text = "icloud视频下载..."
//            self.hud.show(animated: true)
//        }
        
        
        
//        weak var weakSelf = self
        //PHVideoRequestOptions()
        let requestOption = PHVideoRequestOptions()
        requestOption.isNetworkAccessAllowed = true
        requestOption.deliveryMode = .highQualityFormat
        requestOption.version = .original
        requestOption.progressHandler = { (progress, error, stop, info) in
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                self.hud.progress = Float(progress)
//            }
        }
        
        
        
        PHImageManager.default().requestAVAsset(forVideo: asset, options: requestOption) { avAsset, audioMix, info in
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                self.hud.hide(animated: true)
//            }
            
            
            if avAsset != nil {
                if let urlAsset = avAsset as? AVURLAsset {
                    
                    UIImage.createVideoFile(with: urlAsset, videoName: "2333333") { err, pathUrlStr, size, duration in
                        if pathUrlStr != nil && pathUrlStr != "" {
                            completion(pathUrlStr ,size,duration)
                        }
                        
                    } progress: { progress in
                        print(progress)
                    }

                    
                }
            }
        }
    }
    
    
    static var videoExportSession: AVAssetExportSession?
    class func createVideoFile(with asset: AVURLAsset, videoName: String, result: @escaping (Error?, String?, CGSize, Int) -> Void, progress: @escaping (String) -> Void) {
        
        
        var quality: String?
        let compatiblePresets = AVAssetExportSession.exportPresets(compatibleWith: asset)

        if compatiblePresets.contains(AVAssetExportPresetMediumQuality) {
            quality = AVAssetExportPresetMediumQuality
        } else if compatiblePresets.contains(AVAssetExportPresetLowQuality) {
            quality = AVAssetExportPresetLowQuality
        } else {
            let error = NSError(domain: "无质量", code: 101, userInfo: nil)
            result(error,nil,.zero,0)
            return
        }
        
        let videoDuration = Int(asset.duration.value) / Int(asset.duration.timescale)
        let videoPath = "\(NSHomeDirectory())/Library/Caches/\(videoName).mp4"

        videoExportSession = AVAssetExportSession(asset: asset, presetName: quality!)
        videoExportSession?.outputURL = URL(fileURLWithPath: videoPath)
        videoExportSession?.shouldOptimizeForNetworkUse = true
        videoExportSession?.outputFileType = AVFileType.mp4

        DispatchQueue.main.async {
            let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                if let videoExportSession = videoExportSession {
                    //print("=========  \(videoExportSession.progress)")
                    let the_progress = String(format: "%.2f", videoExportSession.progress)
                    progress(the_progress)
                    
                    if videoExportSession.progress >= 0.99 {
                        timer.invalidate()
                    }
                }
            }
            RunLoop.current.add(timer, forMode: .common)
        }
        
        videoExportSession?.exportAsynchronously {
            switch videoExportSession?.status {
            case .failed:
                if let error = videoExportSession?.error {
                    result(error, nil ,.zero ,0)
                }
            case .cancelled:
                let error = NSError(domain: "取消", code: 102, userInfo: nil)
                result(error, nil ,.zero ,0)
            case .completed:
                let convertAvAsset = AVURLAsset(url: URL(fileURLWithPath: videoPath), options: nil)
                let track = convertAvAsset.tracks(withMediaType: .video).first
                let videoSize = track!.naturalSize.applying(track!.preferredTransform)
                
                result(nil, videoPath, videoSize, videoDuration)
                
                do {
                    let fileAttributes = try FileManager.default.attributesOfItem(atPath: videoPath)
                    if let fileSize = fileAttributes[FileAttributeKey.size] as? Int64 {
                        let fileSizeInMB = fileSize / 1024 / 1024
                        print("File Size: \(fileSizeInMB) M")
                    }
                } catch {}
                
                
                
            default:
                let error = NSError(domain: "未知", code: 103, userInfo: nil)
                result(error, nil ,.zero ,0)
            }
        }
        
    }
    
    /// 删除文件
    class func removeFile(filePath: String) {
        do {
            let fileManager = FileManager.default
            try fileManager.removeItem(atPath: filePath)
            print("removeFile Success")
        } catch {
            print("removeFile Failed: \(error.localizedDescription)")
        }
    }
    
}
