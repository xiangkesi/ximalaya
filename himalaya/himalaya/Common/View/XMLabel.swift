//
//  XMLabel.swift
//  himalaya
//
//  Created by Farben on 2020/9/3.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit
import YYText

class XMLabel: YYLabel {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    var xm_displaysAsynchronously: Bool = false {
        didSet {
            self.displaysAsynchronously = xm_displaysAsynchronously
        }
    }
    
    var xm_ignoreCommonProperties: Bool = false {
        didSet {
            self.ignoreCommonProperties = xm_ignoreCommonProperties
        }
    }
    
    var xm_fadeOnAsynchronouslyDisplay: Bool = false {
        didSet {
            self.fadeOnAsynchronouslyDisplay = xm_fadeOnAsynchronouslyDisplay
        }
    }
    
    var xm_fadeOnHighlight: Bool = false {
        didSet {
            self.fadeOnHighlight = xm_fadeOnHighlight
        }
    }
    
    var xm_textLayout: YYTextLayout? {
        didSet {
            self.textLayout = xm_textLayout
        }
    }
    
    var xm_attributedText: NSAttributedString? {
      
        didSet {
            self.attributedText = xm_attributedText
        }
    }
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if #available(iOS 13.0, *) {
            let state = UIApplication.shared.applicationState
            if state == .inactive {
//                textLayout = xm_textLayout
//                attributedText = xm_attributedText
            }
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class XMTextView: YYTextView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
