//
//  XMBoutiqueViewController.swift
//  himalaya
//
//  Created by Farben on 2020/8/20.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit
import IGListKit

class XMHighQualityGoodsViewController: XMBaseViewController {

    
    
    lazy var viewModel = XMHQGViewModel(adapter)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.requestTop.onNext(true)
        viewModel.requestCategory.onNext(true)
    }
    
    override func initWithSubviews() {
        super.initWithSubviews()
        title = "精品"
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        collectionView.jk_headerRefreshBlock = {[weak self] in
            self?.viewModel.requestParam.offset = 0
            self?.viewModel.requestAlbum.onNext((self?.viewModel.requestParam.categoryId)!)
        }
        
        collectionView.jk_footerRefreshBlock = {[weak self] in
            self?.viewModel.requestAlbum.onNext((self?.viewModel.requestParam.categoryId)!)
        }
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.xm_origin = CGPoint(x: 0, y: 0)
        collectionView.xm_size = CGSize(width: view.xm_width, height: view.xm_height)
    }
    
    private lazy var collectionView: UICollectionView = {
        
        let flowLayout = ListCollectionViewLayout(stickyHeaders: true, topContentInset: 0, stretchToEdge: false)
        flowLayout.showHeaderWhenEmpty = true
        let c_view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        c_view.backgroundColor = UIColor.xm.xm_230_20_color
        if #available(iOS 11.0, *) {
            c_view.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        return c_view
    }()
    
    private lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
}

extension XMHighQualityGoodsViewController: ListAdapterDataSource {
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        print(viewModel.layouts.count)
        return viewModel.layouts
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        guard let layout = object as? XMHQGLayout else {
            fatalError()
        }
        switch layout.cellType {
        case .square:
            return XMHQGTopSectionController()
        case .focus:
            return XMHQGBanderSectionController()
        case .categoryWord:
            return XMHQGCatrgoryTitleSectionController(viewModel: viewModel)
        default:
            return XMHQGGuessLikeSectionController()
        }
        
    }
}
