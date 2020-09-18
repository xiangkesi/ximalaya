//
//  NSAttributedStringExtension.swift
//  gokarting
//
//  Created by Farben on 2020/7/21.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import UIKit
import YYText

extension NSMutableAttributedString {
    
    @discardableResult
    func addString(aString: String) -> NSMutableAttributedString {
        let attr = NSAttributedString(string: aString)
        self.append(attr)
        return self
    }
    
    @discardableResult
    func xm_addAttributes(_ font: UIFont, color: UIColor, lineSpace: CGFloat = 0) -> NSMutableAttributedString {
        var paragraphStyle: NSMutableParagraphStyle?
        if lineSpace > 0 {
            paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle?.lineSpacing = lineSpace
            addAttributes([NSAttributedString.Key.font : font, NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.paragraphStyle: paragraphStyle!], range: NSRange(location: 0, length: length))
        }else {
            addAttributes([NSAttributedString.Key.font : font, NSAttributedString.Key.foregroundColor: color], range: NSRange(location: 0, length: length))
        }
        return self
    }
}

extension NSAttributedString {
    
    
    func zs_attributedString(color: UIColor, font: UIFont, lineSpace: CGFloat) -> NSAttributedString {
        
        let attStr = NSMutableAttributedString(attributedString: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpace
        attStr.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attStr.length))
        attStr.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: NSRange(location: 0, length: attStr.length))
        attStr.addAttribute(NSAttributedString.Key.font, value: font, range: NSRange(location: 0, length: attStr.length))
        return attStr
    }
    /// 给富文本添加图片
    /// - Parameters:
    ///   - image: 图片
    ///   - font: 字体大小
    ///   - color: 字体颜色
    ///   - baselineOffset: 上下便宜量
    ///   - leftMargin: 图片做边距
    ///   - rightMargin: 图片右边距
    /// - Returns: 新的富文本
    func zs_attributedString(_ image: UIImage?,
                             _ font: UIFont?,
                             _ color: UIColor?,
                             _ baselineOffset: CGFloat = -3,
                             _ leftMargin: CGFloat = 0,
                             _ rightMargin: CGFloat = 0,
                             _ lineSpace: CGFloat = 0) -> NSAttributedString? {
        if image == nil || self.length == 0 {
            return self
        }
        let attStr = NSMutableAttributedString(attributedString: self)
        if let imageStr = zs_addImage(image, font, baselineOffset, leftMargin, rightMargin) {
            attStr.insert(imageStr, at: 0)
//            attStr.append(imageStr)
        }
        if lineSpace > 0 {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineSpace
            attStr.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attStr.length))
        }
        
        if color != nil {
            attStr.addAttribute(NSAttributedString.Key.foregroundColor, value: color!, range: NSRange(location: 0, length: attStr.length))
        }
        if font != nil {
            attStr.addAttribute(NSAttributedString.Key.font, value: font!, range: NSRange(location: 0, length: attStr.length))
        }
        return attStr
    }
    
    func zs_addImage(_ image: UIImage?,
                     _ font: UIFont?,
                     _ baselineOffset: CGFloat = -3,
                     _ leftMargin: CGFloat = 0,
                     _ rightMargin: CGFloat = 0) -> NSAttributedString? {
        if image == nil {
            return nil
        }
        var imageW = image!.size.width
        var imageH = image!.size.height
        if font != nil {
            let newheight = font!.pointSize
            let newWidth = ceil(newheight * imageW / imageH)
            imageH = newheight + 5
            imageW = newWidth + 5
        }
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = CGRect(x: 0, y: 0, width: imageW, height: imageH)
        let string = NSMutableAttributedString(attachment: attachment)
        string.addAttribute(NSAttributedString.Key.baselineOffset, value: baselineOffset, range: NSRange(location: 0, length: string.length))
        if leftMargin > 0 {
            string.insert(zx_attributedStringWithFixedSpace(width: leftMargin), at: 0)
        }
        if rightMargin > 0 {
            string.append(zx_attributedStringWithFixedSpace(width: rightMargin))
        }
        return string
    }
    
    static func addImage(_ image: UIImage?,_ baselineOffset: CGFloat,_ size: CGSize = CGSize.zero) -> NSAttributedString? {
        if image == nil {
                  return nil
        }
        var imageW = image!.size.width
        var imageH = image!.size.height
        if size.width > 0 {
            imageW = size.width
        }
        if size.height > 0 {
            imageH = size.height
        }
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = CGRect(x: 0, y: 0, width: imageW, height: imageH)
        let string = NSMutableAttributedString(attachment: attachment)
        string.addAttribute(NSAttributedString.Key.baselineOffset, value: baselineOffset, range: NSRange(location: 0, length: string.length))
        return string
    }
    
    private func zx_attributedStringWithFixedSpace(width: CGFloat) -> NSAttributedString {
        UIGraphicsBeginImageContext(CGSize(width: width, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = CGRect(x: 0, y: 0, width: image!.size.width, height: image!.size.height)
        let string = NSMutableAttributedString(attachment: attachment)
        return string
    }
    
      class func xm_attachment(fontSize: CGFloat, image: UIImage, shrink: Bool) -> NSAttributedString {
        
            let ascent = fontSize * 0.86
            let descent = fontSize * 0.14
            
            let bounding = CGRect(x: 0, y: -0.14 * fontSize, width: image.size.width, height: image.size.height)
            var contentInsets = UIEdgeInsets(top: ascent - (bounding.size.height + bounding.origin.y) + 2, left: 0, bottom: descent + bounding.origin.y, right: 5)
            
            let delegate = YYTextRunDelegate()
            delegate.ascent = ascent
            delegate.descent = descent
            delegate.width = bounding.size.width
            
            let attachment = YYTextAttachment()
            attachment.contentMode = .scaleAspectFit
            attachment.contentInsets = contentInsets
            attachment.content = image
            
            if shrink {
                let scale = CGFloat(1 / 10.0)
                contentInsets.top += fontSize * scale
                contentInsets.bottom += fontSize * scale
                contentInsets.left += fontSize * scale
                contentInsets.right += fontSize * scale
    //            contentInsets =
                
            }
            
            let atr = NSMutableAttributedString(string: YYTextAttachmentToken)
            atr.yy_setTextAttachment(attachment, range: NSRange(location: 0, length: atr.length))
            let ctDelegate = delegate.ctRunDelegate()
            atr.yy_setRunDelegate(ctDelegate, range: NSRange(location: 0, length: atr.length))
            return atr
        }

}
