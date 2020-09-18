//
//  XMLiveViewController.swift
//  himalaya
//
//  Created by Farben on 2020/8/20.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit
import IGListKit

class XMLiveViewController: XMBaseViewController {

    lazy var viewModel = XMLiveViewModel(adapter: adapter)
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.resultCategoryVoLists.subscribe(onNext: {[weak self] (layout) in
            self?.topView.lauout = layout
        }).disposed(by: viewModel.disposeBag)
    }
    
    private lazy var topView: XMLiveCategoryView = {
        let top_view = XMLiveCategoryView()
        return top_view
    }()
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: ListCollectionViewLayout(stickyHeaders: false, topContentInset: 0, stretchToEdge: true))
        view.backgroundColor = .clear
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    private lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topView.xm_origin = CGPoint(x: 0, y: 0)
        topView.xm_size = CGSize(width: view.xm_width, height: 60)
        collectionView.xm_origin = CGPoint(x: xm_padding, y: topView.xm_bottom)
        collectionView.xm_size = CGSize(width: content_view_width, height: view.xm_height - topView.xm_height)
    }
    
    override func initWithSubviews() {
        super.initWithSubviews()
        view.addSubview(topView)
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        collectionView.jk_headerRefreshBlock = {[weak self] in
            if self?.viewModel.liveRequest.categoryType == 1 {
                self?.viewModel.request()
            }else {
                self?.viewModel.liveCommonRequestPublish.onNext(true)
            }
            
        }
        collectionView.jk_footerRefreshBlock = {[weak self] in
            self?.viewModel.liveCommonRequestPublish.onNext(false)
        }
        topView.clickItemPublish.subscribe(onNext: {[weak self] (model) in
            self?.viewModel.liveRequest.categoryType = model.id
            self?.collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            if model.id == 1 {
                self?.viewModel.request()
            }else {
                self?.viewModel.liveCommonRequestPublish.onNext(true)
            }
        }).disposed(by: topView.disposeBag)
    }

}

extension XMLiveViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return viewModel.layouts
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        
        guard let layout = object as? XMLiveLayout else {
            fatalError()
        }
        
        switch layout.cellType {
        case XMLiveLayout.XMLiveCellType.live:
            return XMLiveCellSectionController()
        case XMLiveLayout.XMLiveCellType.hotChatRoom:
            return XMLiveChatRoomSectionController()
        default:
            return XMLiveFocusImageSectionController()
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
    
}

extension XMLiveViewController: PageEventHandleable {
    func contentViewFirstShow() {
           viewModel.request()
       }
}
