//
//  XMHQGTopSectionController.swift
//  himalaya
//
//  Created by Farben on 2020/9/16.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import IGListKit

class XMHQGTopSectionController: ListSectionController {
    
    override init() {
        super.init()
    }
    
    private var layout: XMHQGLayout?
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: layout!.cellHeight)
    }
    
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell: XMHighQualityGoodsTopCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
            fatalError()
        }
        adapter.collectionView = cell.collectionView
        return cell
    }
    
    override func didUpdate(to object: Any) {
        layout = (object as! XMHQGLayout)
    }
    
    private lazy var adapter: ListAdapter = {
        let adapter = ListAdapter(updater: ListAdapterUpdater(),
                                 viewController: self.viewController)
        adapter.dataSource = self
        return adapter
    }()
}

extension XMHQGTopSectionController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        
        return layout?.resultModule?.items ?? []
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return XMHQGTopDetailSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
    
}

class XMHQGTopDetailSectionController: ListSectionController {
    
    override init() {
        super.init()
    }
    
    private var item: XMHQGModuleItemModel?
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: 70, height: 100)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell: XMHighQualityGoodsTopDetailCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
            fatalError()
        }
        cell.imageView?.setImage(urlString: item?.icon, placeHolderName: "album_default")
        cell.labelTitle?.text = item?.name
        
        return cell
    }
    
    override func didUpdate(to object: Any) {
        item = (object as! XMHQGModuleItemModel)
    }
}
