//
//  XMBaseViewController.swift
//  himalaya
//
//  Created by Farben on 2020/8/20.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit

class XMBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initWithSubviews()
        initWithSubviewsLayout()
    }
    
    func initWithSubviews() {
        print("\(NSStringFromClass(self.classForCoder))显示了")
        view.backgroundColor = UIColor.xm.xm_230_20_color
    }
    
    
    func initWithSubviewsLayout() {
        
    }
    
    deinit {
        print("\(NSStringFromClass(self.classForCoder))销毁了")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        if self.isViewLoaded && (self.view.window == nil) {
            self.view = nil
        }
    }
}
