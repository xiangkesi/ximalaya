//
//  HomeNavView.swift
//  himalaya
//
//  Created by Farben on 2020/8/19.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit

class HomeNavView: UIView {

    override init(frame: CGRect) {        
        super.init(frame: frame)
//        backgroundColor = UIColor.white
        backgroundColor = UIColor.xm.dynamic(UIColor.white, UIColor.colorWithrgba(22, 22, 22))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
