//
//  XMMineViewController.swift
//  himalaya
//
//  Created by Farben on 2020/8/28.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit
import IGListKit

class XMMineViewController: XMBaseViewController {

    
    lazy var viewModel = XMMineViewModel(adapter: adapter)
//    http://180.153.255.122/community/v1/user/communities
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.requestMine.onNext(true)
        viewModel.requestMineMsg.onNext(true)
    }
    
    override func initWithSubviews() {
        super.initWithSubviews()
        navigationItem.title = ""
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }
    
    override func initWithSubviewsLayout() {
        super.initWithSubviewsLayout()
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        collectionView.xm_origin = CGPoint(x: 0, y: 0)
//        collectionView.xm_size = CGSize(width: view.xm_width, height: view.xm_height)
//    }
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let c_view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        c_view.backgroundColor = UIColor.xm.xm_230_20_color
//        if #available(iOS 11.0, *) {
//            c_view.contentInsetAdjustmentBehavior = .never
//        } else {
//            automaticallyAdjustsScrollViewInsets = false
//        }
        return c_view
    }()
    
    private lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()

}

extension XMMineViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return viewModel.layouts
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        guard let layout = object as? XMMineLayout else {
            fatalError()
        }
        if layout.section?.moduleId == 10001 {
            return XMMineHeadMsgSectionController()
        }
        return XMMineVipSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
    
}
