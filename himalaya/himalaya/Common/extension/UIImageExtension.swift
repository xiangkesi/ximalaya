//
//  UIImageExtension.swift
//  gokarting
//
//  Created by Farben on 2020/7/28.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    /// 创建一张图片
    /// - Parameters:
    ///   - size: 大小
    ///   - opaque: 透明度
    ///   - scale: 像素
    ///   - actions: 回调
    /// - Returns: 图片
    class func zs_creatImage(size: CGSize, opaque: Bool, scale: CGFloat, actions:(_ contextRef: CGContext) -> ()) -> UIImage? {
        if size.width == 0 || size.height == 0 {
            return nil
        }
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
        let context = UIGraphicsGetCurrentContext()
        if context == nil {
            return nil
        }
        actions(context!)
        let imageOut = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return imageOut
    }

    
    

    class func zs_creatImage(color: UIColor = UIColor.clear, size: CGSize, cornerRadius: CGFloat) -> UIImage? {
        
        if size.width == 0 || size.height == 0 {
            return nil
        }
        let opaque = (cornerRadius == 0 && color.zs_alpha() == 1)
        
        return zs_creatImage(size: size, opaque: opaque, scale: 0) { (context) in
            context.setFillColor(color.cgColor)
            if cornerRadius > 0 {
                let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: size.width, height: size.height), cornerRadius: cornerRadius)
                path.addClip()
                path.fill()
                
            }else {
                context.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
            }
        }
    }
    
    class func zs_creatImage(color: UIColor, size: CGSize) -> UIImage? {
        return zs_creatImage(color: color, size: size, cornerRadius: 0)
    }
    
    
    /// 获取图片的平均色
    /// - Returns: 
    func averageColor() -> UIColor{
        var rgba = [UInt8](repeating: 0, count: 4)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: &rgba, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue)
        context?.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: 1, height: 1))
        if rgba[3] > 0 {
           return UIColor(red: (CGFloat(rgba[0]) / CGFloat(rgba[3])), green: (CGFloat(rgba[1]) / CGFloat(rgba[3])), blue: (CGFloat(rgba[2]) / CGFloat(rgba[3])), alpha: (CGFloat(rgba[3]) / 255.0))
        }else {
           return UIColor(red: CGFloat(rgba[0]) / 255.0, green: CGFloat(rgba[1]) / 255.0, blue: CGFloat(rgba[2]) / 255.0, alpha: CGFloat(rgba[3]) / 255.0)
        }
    }
    
    
    func imageByAddingCornerRadius(corner: CGFloat = 0, rectCorner: UIRectCorner = .allCorners) -> UIImage {
         let path = UIBezierPath(roundedRect: CGRect(origin: .zero, size: size), byRoundingCorners: rectCorner, cornerRadii: CGSize(width: corner, height: corner))
        let render = UIGraphicsImageRenderer(size: size)
        return render.image { (rendererContext) in
            path.addClip()
            rendererContext.cgContext.addPath(path.cgPath)
            rendererContext.cgContext.setFillColor(UIColor.clear.cgColor)
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
    
    func imageByAddingCornerRadius(corner: CGFloat = 0,
                                   rectCorner: UIRectCorner = .allCorners,
                                   borderColor: UIColor,
                                   boderWidth: CGFloat = 0) -> UIImage {
         let path = UIBezierPath(roundedRect: CGRect(origin: .zero, size: size), byRoundingCorners: rectCorner, cornerRadii: CGSize(width: corner, height: corner))
        let render = UIGraphicsImageRenderer(size: size)
        return render.image { (rendererContext) in
            if boderWidth > 0 {
                rendererContext.cgContext.setStrokeColor(borderColor.cgColor)
                rendererContext.cgContext.setFillColor(UIColor.clear.cgColor)
                rendererContext.cgContext.setLineWidth(boderWidth)
                path.addClip()
                rendererContext.cgContext.addPath(path.cgPath)
                rendererContext.cgContext.drawPath(using: CGPathDrawingMode.fillStroke)
            }else {
                path.addClip()
                rendererContext.cgContext.addPath(path.cgPath)
                rendererContext.cgContext.setFillColor(UIColor.clear.cgColor)
                self.draw(in: CGRect(origin: .zero, size: size))
            }
        }
    }
    
}


