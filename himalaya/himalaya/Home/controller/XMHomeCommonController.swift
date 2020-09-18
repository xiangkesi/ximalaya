//
//  XMHomeCommonController.swift
//  himalaya
//
//  Created by Farben on 2020/9/3.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit

class XMHomeCommonController: XMBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.frame = CGRect(x: 100, y: 200, width: 100, height: 100)
        btn.backgroundColor = UIColor.red
        btn.addTarget(self, action: #selector(actionClick), for: UIControl.Event.touchUpInside)
        view.addSubview(btn)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func actionClick() {
        ConfigKingfisher.removeMemoryCache()
    }

}
