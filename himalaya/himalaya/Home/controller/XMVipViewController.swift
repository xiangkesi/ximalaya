//
//  XMVipViewController.swift
//  himalaya
//
//  Created by Farben on 2020/8/18.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit
import IGListKit

class XMVipViewController: XMBaseViewController {

    
    private lazy var viewModel = XMVipViewModel(adapter: adapter)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func initWithSubviews() {
        super.initWithSubviews()
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        
        collectionView.jk_headerRefreshBlock = {[weak self] in
            self?.viewModel.request(isDrop: true)
        }
//        collectionView.jk_footerRefreshBlock = {[weak self] in
//            self?.viewModel.request(drop: false)
//        }
    }
    deinit {
        print("销毁了")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    
    
    private lazy var collectionView: UICollectionView = {
        let l = ListCollectionViewLayout(stickyHeaders: true, topContentInset: 0, stretchToEdge: false)
        let c_view = UICollectionView(frame: .zero, collectionViewLayout: l)
        c_view.backgroundColor = UIColor.xm.xm_230_20_color
        return c_view
    }()
    
    private lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()

}

extension XMVipViewController: ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        viewModel.layouts
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let layout = object as! XMVipLayout
        
        switch layout.cellType {
        case .vip_new_status_V3:
            return XMVipCardSectionController()
        case .vip_square(.picture_and_text):
            return XMVipFuncSectionController()
        case .vip_square(.picture):
            return XMVipSquarePictureSectionController()
        case .history:
            return XMVipHistorySectionController()
        case .audition:
            return XMBanderSectionController()
        case .vipcategoriewords:
            return XMVipSupplementSectionController(viewModel: viewModel)
        default:
            return XMVipGuessLikeSectionController()
        }
        
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}

extension XMVipViewController: PageEventHandleable {
    
    func contentViewFirstShow() {
        viewModel.requestDetailParam.isDrop = true
        viewModel.requestTopMsg.onNext(true)
        viewModel.requestCategories.onNext(true)
    }
}
