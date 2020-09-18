//
//  HomeRcmdController.swift
//  himalaya
//
//  Created by Farben on 2020/8/17.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit
import IGListKit

class HomeRcmdController: XMBaseAdaperController {

    lazy var viewModel = HomeViewModel(adapter: adapter)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.requestHome.onNext(false)
    }
    
    override func initWithSubviews() {
        super.initWithSubviews()
        collectionView.jk_headerRefreshBlock = {[weak self] in
            self?.viewModel.requestHome.onNext(false)
        }
        collectionView.jk_footerRefreshBlock = { [weak self] in
            self?.viewModel.requestHome.onNext(true)
        }
    }
    
    deinit {
        print("销毁了")
    }
}

extension HomeRcmdController {
    
    override func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        viewModel.layouts
    }
    
    override func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let layout = object as! HomeLayout
        switch layout.cellType {
        case .module(.hotPlayRank),
             .module(.hotSearchList):
            return XMVHSectionController()
        case .module(.categoryWord):
            return XMHomeCategoryWordSectionController()
        case .module(.voice_room_card),
             .module(.paidCategory),
             .module(.live),
             .module(.cityCategory):
            return XMHomeHorizontalSectionController()
        case .module(.specialList):
            return XMHomeSpecialListSectionController()
        case .module(.anchor_card):
            return XMHomeRadioSectionController()
        case .module(.fmList):
            return XMHomeFmLevelSectionController()
        default:
            return XMHomeSectionController()
        }
    }
}
