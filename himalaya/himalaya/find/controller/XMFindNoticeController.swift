//
//  XMFindNoticeController.swift
//  himalaya
//
//  Created by cocoazhang on 2020/9/6.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit
import IGListKit

class XMFindNoticeController: XMBaseViewController {

//    m.ximalaya.com
//    http://114.80.161.19/community/v1/user/communities
//    http://114.80.161.19/community/v1/user/communities/joined?pageId=2
    private lazy var viewModel = XMFindNoticeViewModel(adapter: adapter)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func initWithSubviews() {
        super.initWithSubviews()
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        collectionView.jk_headerRefreshBlock = { [weak self] in
            self?.viewModel.requestPublist.onNext(true)
        }
        
        collectionView.jk_footerRefreshBlock = { [weak self] in
            self?.viewModel.requestPublist.onNext(false)
        }
    }
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if #available(iOS 13.0, *) {
            if UIApplication.shared.applicationState == .inactive {
                 viewModel.requestPublist.onNext(true)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.xm_origin = CGPoint(x: 0, y: 0)
        collectionView.xm_size = CGSize(width: view.xm_width, height: view.xm_height - xm_navgationheight)
    }
    
    private lazy var collectionView: UICollectionView = {
        let c_view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        c_view.backgroundColor = UIColor.xm.xm_230_20_color
        if #available(iOS 11.0, *) {
            c_view.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        c_view.jk_headerRefreshBlock = {
            c_view.refresh_status = .DropDownSuccess
        }
        return c_view
    }()
    private lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()

}


extension XMFindNoticeController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return viewModel.layouts
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        
        guard let layout = object as? XMFindRecdLayout else {
            fatalError()
        }
        if layout.uniqueId == 1234566 {
            return XMFindNoticeHeadSectionController()
        }
        return XMFindRecdSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
    
}

extension XMFindNoticeController: PageEventHandleable {
    func contentViewFirstShow() {
        viewModel.requestPublist.onNext(true)
    }
}
