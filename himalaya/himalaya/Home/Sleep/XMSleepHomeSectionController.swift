//
//  XMSleepHomeSectionController.swift
//  himalaya
//
//  Created by Farben on 2020/9/14.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import IGListKit

class XMSleepHomeSectionController: ListSectionController {
    
    
    private var detailModel: XMSleepDetailModel?
    override init() {
        super.init()
        inset = UIEdgeInsets(top: xm_padding, left: 0, bottom: 0, right: 0)
    }
    
    override func numberOfItems() -> Int {
        return 2
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: index == 0 ? 50 : (detailModel?.cellHeight ?? 0))
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        if index == 0 {
            guard let cell: XMSleepTitleCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                fatalError()
            }
            cell.labelTitle?.xm_width = detailModel?.sectionTitleWidth ?? 0
            cell.labelTitle?.attributedText = detailModel?.sectionTitleAttr
            return cell
        }else {
            if detailModel?.sectionId == 17 {
                guard let cell: XMSleepCollectionDiyCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                    fatalError()
                }
                cell.detailModel = detailModel?.detailData?.listModels?.first
                return cell
                
            }
            guard let cell: XMSleepCollectionViewCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
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
        detailModel = (object as! XMSleepDetailModel)
    }
}

extension XMSleepHomeSectionController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        
        guard let models = detailModel?.detailData?.listModels else {
            fatalError()
        }
        return models
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return XMSleepHomeLevelSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
    
}

class XMSleepHomeLevelSectionController: ListSectionController {
    
    
    private var detailModel: XMSleepDetailDataListModel?
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: xm_padding)
    }
    
    
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: 100, height: 140)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell: XMSleepCollectionViewDetailCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
            fatalError()
        }
        
        cell.detailModel = detailModel
        return cell
    }
    
    override func didUpdate(to object: Any) {
        detailModel = (object as! XMSleepDetailDataListModel)
    }
    
    
}
