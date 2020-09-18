//
//  XMSleepUnpackController.swift
//  himalaya
//
//  Created by cocoazhang on 2020/9/13.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit
import IGListKit

class XMSleepUnpackController: XMSleepBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        viewModel.requestPublish.onNext(5)
       
    }
}

extension XMSleepUnpackController {
    
    override func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return viewModel.detailModels
    }
    
    override func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        guard let model = object as? XMSleepDetailModel else {
            fatalError()
        }
        if model.uniqueId == 103 {
            return XMSleepCommonFotterSectionController()
        }else {
            return XMSleepHomeSectionController()
        }
        
    }
}
