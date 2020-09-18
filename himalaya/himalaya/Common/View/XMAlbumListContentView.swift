//
//  XMAlbumListContentView.swift
//  himalaya
//
//  Created by Farben on 2020/8/26.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit

class XMAlbumListContentView: UIView {

    override init(frame: CGRect) {
        var selfFrame = frame
        if selfFrame.size == CGSize(width: 0, height: 0) {
            selfFrame.size = CGSize(width: xm_screen_width, height: xm_screen_height - xm_navgationheight)
        }
        
        super.init(frame: selfFrame)
        backgroundColor = UIColor.orange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
