//
//  XMFooterCollectionReusableView.swift
//  himalaya
//
//  Created by Farben on 2020/9/10.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit

class XMFooterCollectionReusableView: UICollectionReusableView {
    
    
    var btnMore: UIButton?
    
    var clickFooter: (() -> ())?
    
    
    @objc func action_click_footer() {
        if clickFooter != nil {
            clickFooter!()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        btnMore = UIButton(type: UIButton.ButtonType.custom)
        btnMore?.layer.cornerRadius = 3
        btnMore?.layer.masksToBounds = true
        btnMore?.backgroundColor = UIColor.xm.xm_255_30_color
        btnMore?.titleLabel?.numberOfLines = 0
        btnMore?.frame = bounds
        let attr = NSMutableAttributedString(string: "查看更多")
        attr.addAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.xm.dynamicRGB((50, 50, 50), (200, 200, 200))], range: NSRange(location: 0, length: attr.length))
        attr.addString(aString: "\n")
        let beginIndex = attr.length
        let title = "MORE"
        attr.addString(aString: title)
        attr.addAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.xm.dynamicRGB((100, 100, 100), (150, 150, 150))], range: NSRange(location: beginIndex, length: title.count))
        let p = NSMutableParagraphStyle()
        p.alignment = .center
        p.lineSpacing = 10
        attr.addAttributes([NSAttributedString.Key.paragraphStyle : p], range: NSRange(location: 0, length: attr.length))
        btnMore?.setAttributedTitle(attr, for: UIControl.State.normal)
        btnMore?.addTarget(self, action: #selector(action_click_footer), for: UIControl.Event.touchUpInside)
        addSubview(btnMore!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
