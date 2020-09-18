//
//  MyTingController.swift
//  himalaya
//
//  Created by Farben on 2020/8/4.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit
import IGListKit

class MyTingController: XMBaseAdaperController {
    
    
    var viewModel = XMMeTingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func initWithSubviews() {
        super.initWithSubviews()
    }

}

extension MyTingController {
    
    override func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return viewModel.layouts
    }
    
    override func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return XMItingSectionController()
    }
}
