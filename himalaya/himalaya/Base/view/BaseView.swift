//
//  BaseView.swift
//  gokarting
//
//  Created by Farben on 2020/7/22.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        initWithSubviews()
        initWithSubviewsLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initWithSubviews() {
        
    }
    
    func initWithSubviewsLayout() {
        
    }

}
