//
//  FindVoiceController.swift
//  himalaya
//
//  Created by Farben on 2020/8/4.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit
import IGListKit

class FindVoiceController: XMBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    
    override func initWithSubviews() {
        super.initWithSubviews()
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        collectionView.jk_headerRefreshBlock = {[weak self] in
            self?.viewModel.requestActive.onNext(true)
        }
        collectionView.jk_footerRefreshBlock = {[weak self] in
            self?.viewModel.requestActive.onNext(false)
        }
    }
    
    deinit {
        print("当前控制器销毁了")
    }
    
    private lazy var collectionView: UICollectionView = {
        let c_view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        c_view.backgroundColor = UIColor.xm.dynamicRGB((230, 230, 230), (30, 30, 30))
        return c_view
        
    }()
    
    private lazy var viewModel: XMFindVoiceViewModel = {
        let view_model = XMFindVoiceViewModel(adapter)
        return view_model
    }()
    
    private lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }

}

extension FindVoiceController: ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return viewModel.layouts
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        guard let layout = object as? XMFindVoiceLayout else {
            fatalError()
        }
        switch layout.cellType {
        case .module(.dubFeedRecoDub),
             .module(.dubFeedRecoAnchor):
            return FindVoiceHorizontalSectionController()
        case .module(.dubFeedAd):
            return XMFindVoiceFocusImageSectionController()
        default:
            return FindVoiceSectionController()
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
}

extension FindVoiceController: PageEventHandleable {

     func contentViewFirstShow() {
        viewModel.requestActive.onNext(true)
    }
}
