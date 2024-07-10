//
//  AccessPermission.swift
//  KW
//
//  Created by 渴望 on 2023/7/11.
//

import UIKit

import CoreTelephony
import NetworkExtension
import Reachability
import CoreLocation
import AVFoundation
import Contacts


@objcMembers public class Permission: NSObject {
    ///跳转到设置
    @objc static func openAppSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(settingsUrl) else {
            return
        }
        UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
    }
}

struct NetWorkStatus {
    //监听网络状态数据
    static var NetWork_Had:Bool = false //是否有网络
    static var NetWork_Status:Int = 0   //0 无网络 1 蜂窝 2 Wi-Fi
}
//MARK: 网络权限
@objcMembers public class Permission_NetWork: NSObject {
    /*
     在iOS 10之后 ，首次进入应用时，就会有是否允许网络连接权限的的弹窗
     pod 'Reachability'
     pod 'ReachabilitySwift'
     二选一
     */
    
    ///查询是否有蜂窝网络权限
    @objc static func checkCellularDataPermission(completion: @escaping (Bool) -> Void) {
        let cellularData = CTCellularData()
        cellularData.cellularDataRestrictionDidUpdateNotifier = { state in
            cellularData.cellularDataRestrictionDidUpdateNotifier = nil
            DispatchQueue.main.async {
                completion(state != .restricted)
            }
        }
    }
    ///查询是否有Wi-Fi权限
    /// NEHotspotHelper 需要一些前置的配置才能使用
    @objc static func checkWiFiPermission(completion: @escaping (Bool) -> Void) {
        NEHotspotHelper.register(options: nil, queue: DispatchQueue.main) { (command: NEHotspotHelperCommand) in
            completion(command.networkList != nil)
        }
    }
    
    ///查询当前网络状态 使用前必须开启网络状态监听
    ///直接调用 NetWorkStatus.NetWork_Had 即可
    @objc static func checkPermission () ->Bool {
        return NetWorkStatus.NetWork_Had
    }
    
    
    //pod 'Reachability'
    public static let reachability = Reachability.forInternetConnection()
    ///开始监听网络状态 【若未申请权限，调用此方法时会弹框请求网络权限】
    static func StartMonitorNetworkChange () {
        reachability!.reachableOnWWAN = false
        NotificationCenter.default.addObserver(self,selector: #selector(reachabilityChanged(notification:)),name: .reachabilityChanged,object: nil)
        reachability!.startNotifier()
        print("开始监听网络变化")
    }
    ///停止监听网络状态
    static func StopMonitorNetworkChange () {
        reachability!.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
        print("结束监听网络变化")
    }
    static func reachabilityChanged(notification: NSNotification) {
        if Permission_NetWork.reachability!.isReachableViaWiFi() {
            print("wifi")
            NetWorkStatus.NetWork_Had = true
            NetWorkStatus.NetWork_Status = 2
        } else if Permission_NetWork.reachability!.isReachableViaWWAN() {
            print("蜂窝")
            NetWorkStatus.NetWork_Had = true
            NetWorkStatus.NetWork_Status = 1
        } else {
            print("无网络")
            NetWorkStatus.NetWork_Had = false
            NetWorkStatus.NetWork_Status = 0
        }
    }
    
    /*
    //pod 'ReachabilitySwift'
    public static let reachability = try! Reachability()
    ///开始监听网络状态 【若未申请权限，调用此方法时会弹框请求网络权限】
    static func StartMonitorNetworkChange () {
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
    }
    ///停止监听网络状态
    static func StopMonitorNetworkChange () {
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
    
    @objc static func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        switch reachability.connection {
        case .wifi:
            print("wifi")
            NetWorkStatus.NetWork_Had = true
            NetWorkStatus.NetWork_Status = 2
            break
        case .cellular:
            print("蜂窝")
            NetWorkStatus.NetWork_Had = true
            NetWorkStatus.NetWork_Status = 1
            break
        case .unavailable:
            print("无网络")
            NetWorkStatus.NetWork_Had = false
            NetWorkStatus.NetWork_Status = 0
            break
        case .none:
            NetWorkStatus.NetWork_Had = false
            NetWorkStatus.NetWork_Status = 0
            break
        }
    }
    */
    
    /*
     请注意，在 iOS 11 及更高版本中，应用程序被使用 open(_:options:completionHandler:) 方法打开设置页面之前，需要在 Info.plist 文件中添加 NSAppTransportSecurity 键，值为 NSExceptionDomains 字典，其中包含一个键值对，键为 settings，值为一个包含 NSExceptionAllowsInsecureHTTPLoads 键并设置为 true 的字典。这是因为设置页面默认使用 HTTP 协议加载。
     */
    ///跳转到设置
    @objc static func openAppSettings() {
        Permission.openAppSettings()
    }
}


//MARK: 定位权限
@objcMembers public class Permission_Location: NSObject ,CLLocationManagerDelegate {
    /*
     Privacy - Location Always and When In Use Usage Description
     定位权限：Privacy - Location When In Use Usage Description
     定位权限: Privacy - Location Always Usage Description
     位置权限：Privacy - Location Usage Description
     */
    
    ///查询是否开启定位权限 --------
    /// 返回值 = -1 手动关闭了权限
    /// 返回值 = 0 尚未确定定位权限，可以请求定位权限
    /// 返回值 > 0 有权限
    /// 返回值 = 1 Always
    /// 返回值 = 2 WhenInUse
    @objc static func checkPermission (completion: @escaping (Int) -> Void) {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                let status = CLLocationManager.authorizationStatus()
                DispatchQueue.main.async {
                    switch status {
                    case .authorizedAlways:
                        // 已经获得定位权限
                        completion(1)
                    case .authorizedWhenInUse:
                        // 已经获得定位权限
                        completion(2)
                    case .denied, .restricted:
                        // 没有定位权限，即关闭了定位权限
                        completion(-1)
                    case .notDetermined:
                        // 尚未确定定位权限，可以请求定位权限
                        completion(0)
                    @unknown default:
                        break
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion(0)
                }
            }
        }
    }
    
    
    /*
     从iOS 14开始，苹果在定位权限授权弹框中进行了一些改变。改变之一是，在某些情况下，可能不再显示 “始终” 选项。具体而言，当用户第一次请求定位权限时，系统会显示 “允许一次”、“使用app时允许” 和 “不允许” 三个选项。
     如果选了 ‘允许一次’ ，在当前app生命周期内使用定位，重新打开app后需要再次申请权限
     如果需要 ‘始终’ ，需要手动在设置中修改
     so：以下写法没区别
     CLLocationManager().requestAlwaysAuthorization()
     CLLocationManager().requestWhenInUseAuthorization()
     */
    
    /// Bool = true  有权限
    /// Bool = false 无权限
    public typealias PermissionCompletion = (Bool) -> Void
    private static var permissionCompletion: PermissionCompletion?
    /// Int = -1 手动关闭了权限
    /// Int = 0 尚未确定定位权限，可以请求定位权限
    /// Int > 0 有权限
    /// Int = 1 Always
    /// Int = 2 WhenInUse
    public typealias PermissionTypeCompletion = (Int) -> Void
    private static var permissionTypeCompletion: PermissionTypeCompletion?
    private static let manager = CLLocationManager()
    private static let shared = Permission_Location()
    private static var isMonitor:Bool = false
    private override init() {
        super.init()
    }
    ///【首次】请求定位权限并回调结果 【也可用于监听定位权限变动】
    /// isMonitor 是否一直监听 定位权限 在设置中的修改 ，默认不监听，调用 cancelMonitor 取消监听
    @objc static func requestPermission(isMonitor:Bool = false ,
                                        completion: @escaping PermissionCompletion ,
                                        typeCompletion: PermissionTypeCompletion? = nil) {
        Permission_Location.isMonitor = isMonitor
        permissionCompletion = completion
        permissionTypeCompletion = typeCompletion
        manager.delegate = shared
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
    }
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        manager.stopUpdatingLocation()
        
        switch status {
        case .authorizedAlways:
            // 定位权限已获得
            Permission_Location.permissionCompletion?(true)
            Permission_Location.permissionTypeCompletion?(1)
            
            if !Permission_Location.isMonitor {
                Permission_Location.manager.delegate = nil
            }
        case .authorizedWhenInUse:
            // 定位权限已获得
            Permission_Location.permissionCompletion?(true)
            Permission_Location.permissionTypeCompletion?(2)
            
            if !Permission_Location.isMonitor {
                Permission_Location.manager.delegate = nil
            }
        case .denied, .restricted:
            // 定位权限被拒绝或受限制
            Permission_Location.permissionCompletion?(false)
            Permission_Location.permissionTypeCompletion?(-1)
            
            if !Permission_Location.isMonitor {
                Permission_Location.manager.delegate = nil
            }
        case .notDetermined:
            // 定位权限尚未确定
            Permission_Location.permissionTypeCompletion?(0)
            break
        @unknown default:
            break
        }
        
        
    }
    
    ///取消监听 定位权限 在 设置 中的变动
    @objc static func cancelMonitor() {
        manager.delegate = nil
    }
    
    ///跳转到设置
    @objc static func openAppSettings() {
        Permission.openAppSettings()
    }
    
}


//MARK: 相机权限
@objcMembers public class Permission_Camera: NSObject {
    /*
     相机权限： Privacy - Camera Usage Description 是否允许此App使用你的相机？
     */
    
    ///查询是否开启相机权限 --------
    ///返回值 = 1  已获取权限
    ///返回值 = 0  未申请
    ///返回值 = -1 已拒绝
    @objc static func checkPermission(completion: @escaping (Int) -> Void) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            // 相机权限已经获得
            completion(1)
        case .notDetermined:
            // 未申请相机权限
            completion(0)
        case .denied, .restricted:
            // 相机权限拒绝或受限制
            completion(-1)
        @unknown default:
            break
        }
    }
    
    ///申请相机权限
    /// - 也可用此方法查询是否开启权限，【若未申请，会弹框，选择后回调】【若已申请，直接回调结果】
    @objc static func requestPermission(completion: @escaping (Bool) -> Void) {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            DispatchQueue.main.async {
                completion(granted)
            }
        }
    }
    
    ///跳转到设置
    @objc static func openAppSettings() {
        Permission.openAppSettings()
    }
}


//MARK: 相册权限
@objcMembers public class Permission_Photo: NSObject {
    /*
     相册权限： Privacy - Photo Library Usage Description 是否允许此App访问你的媒体资料库？
     */
    
    ///查询是否开启相册权限
    /// 1 有权限
    /// 2 有限的访问权限
    /// 0 未申请权限
    /// -1 用户拒绝或限制了访问相册的权限
    @objc static func checkPermission(completion: @escaping (Int) -> Void) {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            // 用户已授权访问相册
            completion(1)
            break
        case .denied, .restricted:
            // 用户拒绝或限制了访问相册的权限
            completion(-1)
            break
        case .notDetermined:
            // 未申请权限 相册权限尚未确定，需要请求权限
            completion(0)
            break
        case .limited:
            // 有限的访问权限 //这个类型不会被调用 无论是允许访问所有照片还是部分照片，都会返回.authorized状态。
            completion(2)
            break
        @unknown default:
            break
        }
    }
    
    ///申请相册权限
    /// - 也可用此方法查询是否开启权限，【若未申请，会弹框，选择后回调】【若已申请，直接回调结果】
    @objc static func requestPermission(completion: @escaping (Bool) -> Void) {
        PHPhotoLibrary.requestAuthorization { (newStatus) in
            DispatchQueue.main.async {
                if newStatus == .authorized {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }
    
    ///跳转到设置
    @objc static func openAppSettings() {
        Permission.openAppSettings()
    }
}



//MARK: 麦克风权限

@objcMembers public class Permission_Microphone: NSObject {
    /*
     麦克风权限：Privacy - Microphone Usage Description 是否允许此App使用你的麦克风？
     */
    ///查询是否开启麦克风权限
    /// 1 有权限
    /// 0 未申请权限
    /// -1 用户拒绝
    @objc static func checkPermission(completion: @escaping (Int) -> Void) {
        let permissionStatus = AVAudioSession.sharedInstance().recordPermission
        switch permissionStatus {
        case .granted:
            //print("用户已授予麦克风权限")
            completion(1)
        case .denied:
            //print("用户已拒绝麦克风权限")
            completion(-1)
        case .undetermined:
            //print("麦克风权限尚未确定")
            completion(0)
        @unknown default:
           // print("麦克风权限状态异常")
            break
        }
    }
    
    ///申请麦克风权限
    /// - 也可用此方法查询是否开启权限，【若未申请，会弹框，选择后回调】【若已申请，直接回调结果】
    @objc static func requestPermission(completion: @escaping (Bool) -> Void) {
        AVAudioSession.sharedInstance().requestRecordPermission { granted in
            DispatchQueue.main.async {
                completion(granted)
            }
        }
    }
    
    ///跳转到设置
    @objc static func openAppSettings() {
        Permission.openAppSettings()
    }
}



//MARK: 通讯录权限
@objcMembers public class Permission_Contacts: NSObject {
    /*
     通讯录权限： Privacy - Contacts Usage Description 是否允许此App访问你的通讯录？
     */
    ///查询是否开启通讯录权限
    /// 1 有权限
    /// 0 未申请权限
    /// -1 用户拒绝
    @objc static func checkPermission(completion: @escaping (Int) -> Void) {
        let status = CNContactStore.authorizationStatus(for: .contacts)
        switch status {
        case .authorized:
            //print("用户已授予通讯录权限")
            completion(1)
        case .denied, .restricted:
            //print("用户已拒绝或受限制访问通讯录")
            completion(-1)
        case .notDetermined:
            //print("通讯录权限尚未确定")
            completion(0)
        @unknown default:
            //print("通讯录权限状态异常")
            break
        }
    }
    
    ///申请通讯录权限
    /// - 也可用此方法查询是否开启权限，【若未申请，会弹框，选择后回调】【若已申请，直接回调结果】
    @objc static func requestPermission(completion: @escaping (Bool) -> Void) {
        CNContactStore().requestAccess(for: .contacts) { granted, error in
            DispatchQueue.main.async {
                completion(granted)
            }
        }
    }
    
    ///跳转到设置
    @objc static func openAppSettings() {
        Permission.openAppSettings()
    }
}



//MARK: 蓝牙权限
@objcMembers public class Permission_Bluetooth: NSObject {
    /*
     蓝牙权限：Privacy - Bluetooth Peripheral Usage Description 是否许允此App使用蓝牙？
     */
}

//MARK: 语音转文字权限
@objcMembers public class Permission_SpeechRecognition: NSObject {
    /*
     语音转文字权限：Privacy - Speech Recognition Usage Description 是否允许此App使用语音识别？
     */
}

//MARK: 日历权限
@objcMembers public class Permission_Calendars: NSObject {
    /*
     日历权限：Privacy - Calendars Usage Description
     */
}

//MARK: 媒体库权限
@objcMembers public class Permission_Media: NSObject {
    /*
     媒体库权限：Privacy - Media Library Usage Description
     */
}

//MARK: 健康权限
@objcMembers public class Permission_Health: NSObject {
    /*
     健康分享权限：Privacy - Health Share Usage Description
     健康更新权限：Privacy - Health Update Usage Description
     */
}

//MARK: 运动使用权限
@objcMembers public class Permission_Motion: NSObject {
    /*
     运动使用权限：Privacy - Motion Usage Description
     */
}

//MARK: 音乐权限
@objcMembers public class Permission_Music: NSObject {
    /*
     音乐权限：Privacy - Music Usage Description
     */
}

//MARK: 提醒使用权限
@objcMembers public class Permission_Reminders: NSObject {
    /*
     提醒使用权限：Privacy - Reminders Usage Description
     */
}

//MARK: Siri使用权限
@objcMembers public class Permission_Siri: NSObject {
    /*
     Siri使用权限：Privacy - Siri Usage Description
     */
}

//MARK: 电视供应商使用权限
@objcMembers public class Permission_TV: NSObject {
    /*
     电视供应商使用权限：Privacy - TV Provider Usage Description
     */
}

//MARK: 视频用户账号使用权限
@objcMembers public class Permission_VideoSubscriberAccount: NSObject {
    /*
     视频用户账号使用权限：Privacy - Video Subscriber Account Usage Description
     */
}

//MARK: 应用内购买权限
@objcMembers public class Permission_InPurchase: NSObject {
    /*
     应用内购买权限
     */
}
