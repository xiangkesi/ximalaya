//
//  XMSleepHomeController.swift
//  himalaya
//
//  Created by cocoazhang on 2020/9/13.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit
import IGListKit

class XMSleepHomeController: XMSleepBaseViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.setImage(urlString: titleModel?.baseCover, placeHolderName: nil)
        viewModel.requestPublish.onNext(Int(titleModel?.sceneId ?? 4))
    }
    
    override func initWithSubviews() {
        view.addSubview(imageView)
        super.initWithSubviews()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = view.bounds
    }
    
}

extension XMSleepHomeController {
    
    override func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return viewModel.detailModels
    }
    
    override func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
            guard let model = object as? XMSleepDetailModel else {
            fatalError()
            }
            if model.uniqueId == 100 {
                return XMSleepHomeTopSectionController()
            }else if model.uniqueId == 103 {
                return XMSleepCommonFotterSectionController()
            }else {
                return XMSleepHomeSectionController()
            }
    }
}
