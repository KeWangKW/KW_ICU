//
//  PermissionShow.swift
//  KW
//
//  Created by 渴望 on 2023/7/14.
//

import UIKit

class PermissionShow: KSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func netWorkClick1(_ sender: Any) {
        Permission_NetWork.StartMonitorNetworkChange()
    }
    
    @IBAction func netWorkClick2(_ sender: Any) {
        Permission_NetWork.StopMonitorNetworkChange()
        print("\(NetWorkStatus.NetWork_Had)")
        
    }
    
    @IBAction func netWorkClick3(_ sender: Any) {
        let str = NetWorkStatus.NetWork_Had ? "有网络连接" : "无网络"
        HUD.showText(text: str)
    }
    
    @IBAction func netWorkClick4(_ sender: Any) {
        Permission_NetWork.openAppSettings()
    }
    
    @IBAction func netWorkClick5(_ sender: Any) {
        Permission_NetWork.checkCellularDataPermission { bool in
            if bool {
                Alert.showText("有蜂窝网络权限")
            }else{
                Alert.showText("无蜂窝网络权限")
            }
        }
    }
    
    @IBAction func netWorkClick6(_ sender: Any) {
        Permission_NetWork.checkWiFiPermission { bool in
            if bool {
                Alert.showText("有Wi-Fi权限")
            }else{
                Alert.showText("无Wi-Fi权限")
            }
        }
    }
    
    
    
    @IBAction func locationClick1(_ sender: Any) {
        Permission_Location.checkPermission { type in
            if type == -1 {
                Alert.showText("用户禁止定位")
            }else if type == 0 {
                Alert.showText("未申请定位权限")
            }else if type == 1 {
                Alert.showText("可使用定位","Always")
            }else if type == 2 {
                Alert.showText("可使用定位","WhenInUse")
            }
        }
    }
    
    @IBAction func loactionClick2(_ sender: Any) {
        Permission_Location.requestPermission { bool in
            if bool {
                Alert.showText("申请 定位权限 同意")
            }else{
                Alert.showText("申请 定位权限 拒绝或其他")
            }
        }
    }
    
    @IBAction func loactionClick4(_ sender: Any) {
        Permission_Location.requestPermission(isMonitor: true) { bool in
            if bool {
                Alert.showText("申请监听 定位权限 同意")
            }else{
                Alert.showText("申请监听 定位权限 拒绝或其他")
            }
        } typeCompletion: { type in
            if type == -1 {
                Alert.showText("用户禁止定位")
            }else if type == 0 {
                Alert.showText("未申请定位权限")
            }else if type == 1 {
                Alert.showText("可使用定位","Always")
            }else if type == 2 {
                Alert.showText("可使用定位","WhenInUse")
            }
        }
    }
    
    @IBAction func locationClick5(_ sender: Any) {
        Permission_Location.cancelMonitor()
    }
    
    
    @IBAction func locationClick3(_ sender: Any) {
        Permission_Location.openAppSettings()
    }
    
    
    
    
    @IBAction func cameraClick1(_ sender: Any) {
        Permission_Camera.checkPermission { type in
            if type == 1 {
                Alert.showText("有权限")
            }else if type == 0 {
                Alert.showText("还未申请权限")
            }else{
                Alert.showText("禁止使用")
            }
        }
    }
    
    @IBAction func cameraClick2(_ sender: Any) {
        Permission_Camera.requestPermission { bool in
            if bool {
                Alert.showText("申请权限 并同意")
            }else{
                Alert.showText("申请权限 并拒绝")
            }
        }
    }
    
    @IBAction func cameraClick3(_ sender: Any) {
        Permission_Camera.openAppSettings()
    }
    
    
    
    @IBAction func photoClick1(_ sender: Any) {
        Permission_Photo.checkPermission { type in
            if type == -1 {
                Alert.showText("用户拒绝")
            }else if type == 0 {
                Alert.showText("未申请权限")
            }else if type == 1 {
                Alert.showText("已授权")
            }else if type == 2 {
                Alert.showText("已授权【有限制】")
            }
        }
    }
    
    @IBAction func photoClick2(_ sender: Any) {
        Permission_Photo.requestPermission { bool in
            if bool {
                Alert.showText("申请授权 同意")
            }else{
                Alert.showText("申请授权 拒绝")
            }
        }
    }
    
    @IBAction func photoClick3(_ sender: Any) {
        Permission_Photo.openAppSettings()
    }
    
    
    
    @IBAction func MicrophoneClick1(_ sender: Any) {
        Permission_Microphone.checkPermission { type in
            if type == -1 {
                Alert.showText("用户拒绝")
            }else if type == 0 {
                Alert.showText("未申请权限")
            }else if type == 1 {
                Alert.showText("已授权")
            }
        }
    }
    
    @IBAction func MicrophoneClick2(_ sender: Any) {
        Permission_Microphone.requestPermission { bool in
            if bool {
                Alert.showText("申请授权 同意")
            }else{
                Alert.showText("申请授权 拒绝")
            }
        }
    }
    
    @IBAction func MicrophoneClick3(_ sender: Any) {
        Permission_Microphone.openAppSettings()
    }
    
}
