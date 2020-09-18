//
//  XMBaseAdaperController.swift
//  himalaya
//
//  Created by Farben on 2020/9/16.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit
import IGListKit

class XMBaseAdaperController: XMBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func initWithSubviews() {
        super.initWithSubviews()
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
        
    }
    
    lazy var collectionView: UICollectionView = {
        let c_view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        c_view.backgroundColor = UIColor.xm.xm_230_20_color
//        if #available(iOS 11.0, *) {
//            c_view.contentInsetAdjustmentBehavior = .never
//        } else {
//            automaticallyAdjustsScrollViewInsets = false
//        }
        return c_view
    }()
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
}

extension XMBaseAdaperController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return [0] as [ListDiffable]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return ListSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
    
}
