//
//  XMBangController.swift
//  himalaya
//
//  Created by cocoazhang on 2020/8/30.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit

class XMBangController: XMPageViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for index in 0..<20 {
            let item = XMPageItem()
//            item.titleNormalFont = UIFont.systemFont(ofSize: 13)
//            item.titleSelectedFont = UIFont.systemFont(ofSize: 15)
//            item.itemSize = CGSize(width: <#T##CGFloat#>, height: <#T##CGFloat#>)
            item.title = "第\(index)个"
            item.theOnlyId = index
            items.append(item)
        }
        
        self.reloadData()
        
    }
}
