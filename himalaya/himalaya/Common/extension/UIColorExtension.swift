//
//  UIColorExtension.swift
//  gokarting
//
//  Created by Farben on 2020/7/28.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func colorWithrgba(_ r: CGFloat,_ g: CGFloat,_ b: CGFloat,_ a: CGFloat = 1.0) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue:b / 255.0, alpha: a)
    }
    static func colorWidthHexString(hex: String,_ alpha: CGFloat = 1.0) -> UIColor {
            
    //        if hex.count != 6 || hex.count != 7 {
    //            return UIColor.clear
    //        }
            
            let set = CharacterSet.whitespacesAndNewlines
            var stringColor = hex.trimmingCharacters(in: set)
            
            if stringColor.hasPrefix("#"){
                stringColor = String(stringColor.suffix(stringColor.count - 1))
            }
            if stringColor.count != 6 {
                return UIColor.clear
            }
            
            let rString = String(stringColor.prefix(2))
                    
            let startIndex = stringColor.index(stringColor.startIndex, offsetBy: 2)
            let endIndex = stringColor.index(stringColor.startIndex, offsetBy: 4)
            
            let gString = String(stringColor[startIndex..<endIndex])
            
            let bString = String(stringColor.suffix(2))
                    
            var r: CUnsignedInt = 0
            var g: CUnsignedInt = 0
            var b: CUnsignedInt = 0
            Scanner(string: rString).scanHexInt32(&r)
            Scanner(string: gString).scanHexInt32(&g)
            Scanner(string: bString).scanHexInt32(&b)
            
    //        print("\(r)--\(g)---\(b)")
            
            return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
        }
    
    
    func zs_alpha() -> CGFloat {
        var a: CGFloat = 0
        var red: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        if self.getRed(&red, green: &g, blue: &b, alpha: &a) {
            return a
        }
        return 0
        
    }
}


public struct XMExtension<ExtendedType> {
    internal let type: ExtendedType
    internal init(_ type: ExtendedType) {
        self.type = type
    }
}


public protocol XMExtended {

}

extension XMExtended {
    
    public var xm: XMExtension<Self> {
        get { XMExtension(self) }
    }
    public static var xm: XMExtension<Self>.Type {
        get { XMExtension<Self>.self }
    }
    
}

extension UIColor: XMExtended {}

public extension XMExtension where ExtendedType: UIColor {
    
    static func dynamic(_ light: UIColor,_ dark: UIColor? = nil) -> UIColor {
        if #available(iOS 13.0, *) {
         return UIColor { traitCollection -> UIColor in
             if traitCollection.userInterfaceStyle == .light {
                 return light
             } else {
                 return dark!
             }
         }
        }else {
            return light
        }
    }
    
    static func dynamicRGB(_ light: (r: CGFloat, g: CGFloat, b: CGFloat), _ dark: (r: CGFloat, g: CGFloat, b: CGFloat)) -> UIColor {
        if #available(iOS 13.0, *) {
         return UIColor { traitCollection -> UIColor in
             if traitCollection.userInterfaceStyle == .light {
                return UIColor.colorWithrgba(light.r, light.g, light.b)
             } else {
                return UIColor.colorWithrgba(dark.r, dark.g, dark.b)
             }
         }
        }else {
            return UIColor.colorWithrgba(light.r, light.g, light.b)
        }
    }
    
    static func dynamicHEX(_ light: String, _ dark: String = "000000") -> UIColor {
        if #available(iOS 13.0, *) {
         return UIColor { traitCollection -> UIColor in
             if traitCollection.userInterfaceStyle == .light {
                return UIColor.colorWidthHexString(hex: light)
             } else {
                return UIColor.colorWidthHexString(hex: dark)
             }
         }
        }else {
            return UIColor.colorWidthHexString(hex: light)
        }
    }
    
    
    static var xm_230_20_color: UIColor {
        return UIColor.xm.dynamicRGB((245, 245, 245), (20, 20, 20))
    }
//    UIColor.xm.dynamicRGB((255, 255, 255), (30, 30, 30))
    static var xm_255_30_color: UIColor {
        return UIColor.xm.dynamicRGB((255, 255, 255), (30, 30, 30))
    }
    
}
