//
//  XMPageView.swift
//  himalaya
//
//  Created by Farben on 2020/8/24.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit
import IGListKit

class XMPageView: UIView {
    
    private weak var viewController: UIViewController?
    
    private var items: [XMPageItem]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(viewController: UIViewController, items: [XMPageItem]) {
        super.init(frame: .zero)
        self.viewController = viewController
        self.items = items
        addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = bounds
    }
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let c_view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        c_view.backgroundColor = UIColor.xm.xm_230_20_color
        if #available(iOS 11.0, *) {
            c_view.contentInsetAdjustmentBehavior = .never
        }
        c_view.isPagingEnabled = true
        return c_view
    }()
    
    private lazy var adapter: ListAdapter = {
           return ListAdapter(updater: ListAdapterUpdater(), viewController: viewController!)
       }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension XMPageView: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return items!
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let item = object as! XMPageItem
        if item.theOnlyId == 0 {
            return XMPageHomeSectionController(height: xm_height)
        }
        return XMPageCommonSectionController(height: xm_height)
        
        
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
    
}
