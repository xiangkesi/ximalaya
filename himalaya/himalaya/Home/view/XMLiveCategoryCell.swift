//
//  XMLiveCategoryCell.swift
//  himalaya
//
//  Created by cocoazhang on 2020/8/29.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit

class XMLiveCategoryCell: UICollectionViewCell {
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(labelTitle)
        contentView.addSubview(lineView)
    }
    
    var isClickSelected: Bool = false {
        didSet {
            if isClickSelected == true {
                labelTitle.textColor = UIColor.colorWidthHexString(hex: mainColorString)
            }else {
                labelTitle.textColor = UIColor.xm.dynamicRGB((20, 20, 20), (245, 245, 245))
            }
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    lazy var imageView: UIImageView = {
        let i_view = UIImageView()
        i_view.xm_size = CGSize(width: 30, height: 30)
        i_view.xm_origin = CGPoint(x: 20, y: 5)
        return i_view
    }()
    
    lazy var lineView: UIView = {
        let l_view = UIView()
        l_view.xm_height = 24
        l_view.xm_width = 1
        l_view.backgroundColor = UIColor.xm.dynamicRGB((220, 220, 220), (50, 50, 50))
        l_view.xm_origin = CGPoint(x: 69, y: 18)
        return l_view
    }()
    
    lazy var labelTitle: UILabel = {
        let l_title = UILabel()
        l_title.font = UIFont.systemFont(ofSize: 12)
        l_title.textColor = UIColor.white
        l_title.textAlignment = .center
        l_title.xm_size = CGSize(width: contentView.xm_width, height: 20)
        l_title.xm_origin = CGPoint(x: 0, y: imageView.xm_bottom)
        return l_title
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
