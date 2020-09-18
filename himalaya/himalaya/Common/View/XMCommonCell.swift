//
//  XMCommonCell.swift
//  himalaya
//
//  Created by Farben on 2020/9/9.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import UIKit

class XMCommonCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initWithSubViews()
    }
    
    func initWithSubViews() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class XMCommonView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initWithSubViews()
    }
    
    func initWithSubViews() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
