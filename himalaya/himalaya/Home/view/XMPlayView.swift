//
//  XMPlayView.swift
//  himalaya
//
//  Created by Farben on 2020/8/18.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit

class XMPlayView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class XMVideoTopView: UIView {
    
    var btnLeft: UIButton?
    var btnRight: UIButton?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        btnLeft = UIButton(type: UIButton.ButtonType.custom)
        btnLeft?.setTitle("简介", for: UIControl.State.normal)
        btnLeft?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        addSubview(btnLeft!)
        
        
        btnRight = UIButton(type: UIButton.ButtonType.custom)
        btnRight?.setTitle("评论", for: UIControl.State.normal)
        btnRight?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        addSubview(btnRight!)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        btnLeft?.xm_origin = CGPoint(x: 0, y: 0)
        btnLeft?.xm_size = CGSize(width: xm_width * 0.5, height: xm_height)
        btnRight?.xm_origin = CGPoint(x: btnLeft!.xm_right, y: 0)
        btnRight?.xm_size = btnLeft!.xm_size
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
