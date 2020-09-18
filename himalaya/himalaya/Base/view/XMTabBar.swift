//
//  XMTabBar.swift
//  himalaya
//
//  Created by Farben on 2020/8/4.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit

class XMTabBar: UITabBar {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(contentView)
    }
    
    private lazy var contentView: XMCenterView = {
        let content_view = XMCenterView()
        return content_view
    }()
    
  
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let centerViewW: CGFloat = xm_width * 0.2
        let centerViewH: CGFloat = xm_height
        let centerViewX = ceil((xm_width - centerViewW) * 0.5)
        let centerViewY: CGFloat = 0
        contentView.frame = CGRect(x: centerViewX, y: centerViewY, width: centerViewW, height: centerViewH)
        var index: Int = 0
        for subView in subviews {
            if subView.isKind(of: NSClassFromString("UITabBarButton")!) == true {
                contentView.xm_height = subView.xm_height
                let subViewX = (index > 1) ? CGFloat((index + 1)) * centerViewW : CGFloat(index) * centerViewW
                index += 1
                subView.frame = CGRect(x: subViewX, y: subView.xm_y, width: centerViewW, height: subView.xm_height)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class XMCenterView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageViewWH: CGFloat = xm_height - 10
        let imageViewY: CGFloat = 7
        let imageViewX: CGFloat = ceil((xm_width - imageViewWH) * 0.5)
        imageView.frame = CGRect(x: imageViewX, y: imageViewY, width: imageViewWH, height: imageViewWH)
        
    }
    private lazy var imageView: UIImageView = {
          let image_view = UIImageView()
          image_view.image = UIImage(named: "image_choice_girl_2")
          return image_view
      }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
