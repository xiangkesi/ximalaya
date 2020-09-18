//
//  XMVipHistorySectionController.swift
//  himalaya
//
//  Created by Farben on 2020/8/19.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import IGListKit

class XMVipHistorySectionController: ListSectionController {
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
    
    private var layout: XMVipLayout?
    
    override func numberOfItems() -> Int {
        return 2
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return index == 0 ? CGSize(width: xm_screen_width, height: 40) : layout!.cellSize
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        if index == 0 {
            guard let cell: XMVipHistoryTitleCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                       fatalError()
            }
            cell.labelTitle?.text = layout?.module?.moduleName
            return cell
        }else {
            guard let cell: XMVipHistoryListenCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                fatalError()
            }
            adapter.collectionView = cell.collectionView
            return cell
        }
    }
    
    private lazy var adapter: ListAdapter = {
        let adapter = ListAdapter(updater: ListAdapterUpdater(),
                                     viewController: self.viewController)
        adapter.dataSource = self
        return adapter
    }()
    
    override func didUpdate(to object: Any) {
        layout = (object as! XMVipLayout)
    }
}

extension XMVipHistorySectionController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return (layout?.module?.recordLists)!
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return XMVipHistoryHSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
    
}

class XMVipHistoryHSectionController: ListSectionController {
    
    
    
    private var record: XMVipRecordListModel?
    
    private let cellWidth = UIDevice.isPad ? 300 : ceil(content_view_width * 0.8)
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: xm_padding, bottom: 0, right: 0)
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: cellWidth, height: 110)
    }
    override func cellForItem(at index: Int) -> UICollectionViewCell {
         guard let cell: XMVipHistoryListenDetailCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                       fatalError()
         }
        cell.record = record
         return cell
    }
    
    override func didUpdate(to object: Any) {
        record = (object as! XMVipRecordListModel)
    }
    
    override func didSelectItem(at index: Int) {
        
        let videoVc = XMVideoController()
        self.viewController?.navigationController?.pushViewController(videoVc, animated: true)
        
    }
}
