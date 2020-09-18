//
//  UIDeviceExtension.swift
//  HimalayanHD
//
//  Created by Farben on 2020/7/3.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import UIKit

extension UIDevice {
    
    ///计算属性, 只读是不是刘海屏
    public static var is_X: Bool {
        get {
            if isPad {
                return false
            }
            if #available(iOS 11.0, *) {
                guard let unwrapedWindow = keyWindow else {
                    return isNotchScreen
                }
                if unwrapedWindow.safeAreaInsets.left > 0 || unwrapedWindow.safeAreaInsets.bottom > 0 {
                    return true
                }
            }
            return false
        }
    }
    
    //是有可能获取不到的,比如刚启动时候
    public static var keyWindow: UIWindow? {
        get {
            if #available(iOS 13.0, *) {
                for windowScene: UIWindowScene in ((UIApplication.shared.connectedScenes as?  Set<UIWindowScene>)!) {
                    if windowScene.activationState == .foregroundActive {
                        return windowScene.windows.first
                    }
                }
                return nil
            } else {
                return UIApplication.shared.windows.first
            }
        }
    }
    
    public static var isNotchScreen: Bool {
        let notchValue: Int = Int(screen_width / screen_height * 100)
        if notchValue == 216 || notchValue == 46 {
            return true
        }
        return false
    }
    
    public static var isPad: Bool {
        return current.userInterfaceIdiom == .pad
    }
    
    public static var deviceModel: String {
        
        if isSimulator {
            return String(format: "%s", getenv("SIMULATOR_MODEL_IDENTIFIER"))
        }
        
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") {identifier, element  in
            guard let value = element.value as? Int8, value != 0 else {
                return identifier
            }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
    
    
    public static var deviceName: String {
        let identifier = deviceModel
        switch identifier {
        case "iPod1,1":  return "iPod Touch 1"
        case "iPod2,1":  return "iPod Touch 2"
        case "iPod3,1":  return "iPod Touch 3"
        case "iPod4,1":  return "iPod Touch 4"
        case "iPod5,1":  return "iPod Touch (5 Gen)"
        case "iPod7,1":   return "iPod Touch 6"
            
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":  return "iPhone 4"
        case "iPhone4,1":  return "iPhone 4s"
        case "iPhone5,1":   return "iPhone 5"
        case  "iPhone5,2":  return "iPhone 5 (GSM+CDMA)"
        case "iPhone5,3":  return "iPhone 5c (GSM)"
        case "iPhone5,4":  return "iPhone 5c (GSM+CDMA)"
        case "iPhone6,1":  return "iPhone 5s (GSM)"
        case "iPhone6,2":  return "iPhone 5s (GSM+CDMA)"
        case "iPhone7,2":  return "iPhone 6"
        case "iPhone7,1":  return "iPhone 6 Plus"
        case "iPhone8,1":  return "iPhone 6s"
        case "iPhone8,2":  return "iPhone 6s Plus"
        case "iPhone8,4":  return "iPhone SE"
        case "iPhone9,1":  return "国行、日版、港行iPhone 7"
        case "iPhone9,2":  return "港行、国行iPhone 7 Plus"
        case "iPhone9,3":  return "美版、台版iPhone 7"
        case "iPhone9,4":  return "美版、台版iPhone 7 Plus"
        case "iPhone10,1","iPhone10,4":   return "iPhone 8"
        case "iPhone10,2","iPhone10,5":   return "iPhone 8 Plus"
        case "iPhone10,3","iPhone10,6":   return "iPhone X"
            
        case "iPad1,1":   return "iPad"
        case "iPad1,2":   return "iPad 3G"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":   return "iPad 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":  return "iPad Mini"
        case "iPad3,1", "iPad3,2", "iPad3,3":  return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":   return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":   return "iPad Air"
        case "iPad4,4", "iPad4,5", "iPad4,6":  return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":  return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":  return "iPad Mini 4"
        case "iPad5,3", "iPad5,4":   return "iPad Air 2"
        case "iPad6,3", "iPad6,4":  return "iPad Pro 9.7"
        case "iPad6,7", "iPad6,8":  return "iPad Pro 12.9"
        case "AppleTV2,1":  return "Apple TV 2"
        case "AppleTV3,1","AppleTV3,2":  return "Apple TV 3"
        case "AppleTV5,3":   return "Apple TV 4"
        case "i386", "x86_64":   return "Simulator"
        default:  return identifier
        }
    }

    public static var isSimulator: Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }
    
    public static var isLandscape: Bool {
        return UIApplication.shared.statusBarOrientation.isLandscape
    }
    
    public static var ios_version: Double {
        return (UIDevice.current.systemVersion as NSString).doubleValue
    }
    
    public static var statusHeight: CGFloat {
        get { UIApplication.shared.isStatusBarHidden ? 0 : UIApplication.shared.statusBarFrame.size.height}
    }
    
    public static var navigationBarHeight: CGFloat {
        get { isPad ? (ios_version >= 12.0 ? 50 : 44) : UIDevice.isLandscape ? isRegularScreen ? 44 : 32 : 44}
    }
    
    public static var navBar_statusHeight: CGFloat {
        return statusHeight + navigationBarHeight
    }

    public static var tabBarHeight: CGFloat {
        get { ios_version >= 12.0 ? 50 : 49}
    }
    
    public static var tabbarBottomHeight: CGFloat {
        get {is_X ? 34.0 : 0.0}
    }
    
    public static var navigationSubviewY: CGFloat {
        get {is_X ? 51.0 : 27.0}
    }
    
    /// 屏幕宽度，会根据横竖屏的变化而变化
    public static var screen_width: CGFloat {
        get { UIScreen.main.bounds.size.width }
    }
    
    /// 屏幕高度，会根据横竖屏的变化而变化
    public static var screen_height: CGFloat {
        get { UIScreen.main.bounds.size.height}
    }
    
    /// 设备宽度，跟横竖屏无关
    public static var device_width: CGFloat {
        get {
            min(screen_width, screen_height)
        }
    }
    
    public static var device_height: CGFloat {
        return max(screen_width, screen_height)
    }
    
    
    /// 系统设置里是否开启了“放大显示-试图-放大”，支持放大模式的 iPhone 设备可在官方文档中查询
    public static var isZoomedMode: Bool {
        if isPad {
            return false
        }
        let nativeScale = UIScreen.main.nativeScale
        var scale = UIScreen.main.scale
        let shouldBeDownsampledDevice = __CGSizeEqualToSize(UIScreen.main.nativeBounds.size, CGSize(width: 1080, height: 1920))
        if shouldBeDownsampledDevice {
            scale = scale / 1.15
        }
        return nativeScale > scale
        
        
    }
    
    public static var isRegularScreen: Bool {
        return isPad || (isZoomedMode == false && (is65InchScreen || is61InchScreen || is55InchScreen))
    }
    
    /// iPhone XS Max / 11 Pro Max
    private static var is_65InchScreen = -1
    public static var is65InchScreen: Bool {
        if is_65InchScreen < 0 {
            is_65InchScreen = (device_width == screenSizeFor65Inch.width && device_height == screenSizeFor65Inch.height && (deviceModel == "iPhone11,4" || deviceModel == "iPhone11,6" || deviceModel == "iPhone12,5")) ? 1 : 0
        }
        return is_65InchScreen > 0
    }
    
    /// iPhone XR / 11
    private static var is_61InchScreen = -1
    public static var is61InchScreen: Bool {
        if is_61InchScreen < 0 {
            is_61InchScreen = (device_width == screenSizeFor61Inch.width && device_height == screenSizeFor61Inch.height && (deviceModel == "iPhone11,8" || deviceModel == "iPhone12,1")) ? 1 : 0
        }
        return is_61InchScreen > 0
    }
    
    private static var is_55InchScreen = -1
    public static var is55InchScreen: Bool {
        if is_55InchScreen < 0 {
            is_55InchScreen = (device_width == screenSizeFor55Inch.width && device_height == screenSizeFor55Inch.height) ? 1 : 0
        }
        return is_55InchScreen > 0
    }
    
    public static var screenSizeFor65Inch: CGSize {
        return CGSize(width: 414, height: 896)
    }
    
    public static var screenSizeFor61Inch: CGSize {
        return CGSize(width: 414, height: 896)
    }
    
    public static var screenSizeFor58Inch: CGSize {
        return CGSize(width: 375, height: 812)
    }
    
    public static var screenSizeFor55Inch: CGSize {
        return CGSize(width: 414, height: 736)
    }
    
    
    @available(iOS 13.0, *)
    public static var currentModel: UIUserInterfaceStyle {
        return UITraitCollection.current.userInterfaceStyle
    }
}
