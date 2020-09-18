//
//  XMCommonGuessLikeView.swift
//  himalaya
//
//  Created by Farben on 2020/8/19.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit

class XMCommonGuessLikeView: UIView {

    var labelTitle: UILabel?
    
    var mainView: XMCommonGuessLikeMainView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        mainView = XMCommonGuessLikeMainView()
        mainView?.xm_origin = CGPoint(x: 0, y: 0)
        addSubview(mainView!)
        labelTitle = UILabel()
        labelTitle?.numberOfLines = 2
        labelTitle?.xm_x = 0
        labelTitle?.xm_height = 0
        addSubview(labelTitle!)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mainView?.xm_size = CGSize(width: xm_width, height: xm_width)
        labelTitle?.xm_y = mainView!.xm_bottom + 10
        labelTitle?.xm_width = xm_width
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class XMCommonGuessLikeMainView: UIView {
    
    lazy var imageView: UIImageView = {
        let image_view = UIImageView()
        image_view.layer.cornerRadius = 5
        image_view.layer.masksToBounds = true
        return image_view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
