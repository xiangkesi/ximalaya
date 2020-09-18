//
//  FindVoiceSectionController.swift
//  himalaya
//
//  Created by Farben on 2020/8/13.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit
import IGListKit

class FindVoiceSectionController: ListSectionController {
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
    }
    
    override func numberOfItems() -> Int {
        return layout?.rows.count ?? 0
    }
    
    var layout: XMFindVoiceLayout?
    
    
    override func sizeForItem(at index: Int) -> CGSize {
        let width: CGFloat = collectionContext?.containerSize.width ?? 0
        let row = layout?.rows[index]
        return CGSize(width: width, height: row?.cellHeight ?? 0)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let row = layout?.rows[index]
        switch row?.cellType {
            case .video:
                guard let cell: ZSVideoCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                    fatalError()
                }
                cell.row = row
                return cell
            case .content:
                guard let cell: ZSContentLabelCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                    fatalError()
                }
                cell.row = row
            return cell
            default:
                guard let cell: ZSBottomViewCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                    fatalError()
                }
                cell.row = row
                return cell
        }
    }
    
    override func didUpdate(to object: Any) {
        layout = (object as! XMFindVoiceLayout)
    }
    
    
}

class FindVoiceHorizontalSectionController: ListSectionController, ListAdapterDataSource {
    
    
    private var layout: XMFindVoiceLayout?
    
    private lazy var adapter: ListAdapter = {
        let adapter = ListAdapter(updater: ListAdapterUpdater(),
                                  viewController: self.viewController)
        adapter.dataSource = self
        return adapter
    }()
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
    }
    
//    case .module(.dubFeedRecoDub),
//                .module(.dubFeedAd),
//                .module(.dubFeedRecoAnchor):
//               return FindVoiceHorizontalSectionController()
    
    override func numberOfItems() -> Int {
        return 2
        
    }
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: index == 0 ? 40 : layout!.cellHeight)
    }
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        if index == 0 {
            guard let cell: ActiveTitleCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                fatalError()
            }
            cell.labelTitle?.text = layout?.active.title
            return cell
        }else {
            guard let cell: XMFindVoiceLevelCollectionViewCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                fatalError()
            }
            adapter.collectionView = cell.collectionView
            return cell
        }
    }
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return (layout!.active.item?.contents)!
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return EmbeddedSectionController(cellType: layout!.cellType)
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
    
    override func didUpdate(to object: Any) {
        layout = (object as! XMFindVoiceLayout)
    }
    
    
}

class EmbeddedSectionController: ListSectionController {
    
    
    private var cell_type: XMCellType = .unKnow
    required init(cellType: XMCellType) {
        super.init()
        cell_type = cellType
        self.inset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    }
//    override init() {
//        super.init()
//        self.inset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
//    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let height = collectionContext?.containerSize.height ?? 0
        if cell_type == .module(.dubFeedRecoDub) {
            return CGSize(width: height, height: height)
        }
        return CGSize(width: 280, height: 300)
        
    }
    
    var item: XMFindVoiceContentModel?

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        
        if cell_type == .module(.dubFeedRecoDub) {
            guard let cell: ActiveSelectDetailCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                fatalError()
            }
            cell.item = item
            return cell
        }else {
            guard let cell: XMFindVoiceTalentCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                fatalError()
            }
            cell.item = item
            return cell
        }
        
    }
    override func didUpdate(to object: Any) {
        item = (object as! XMFindVoiceContentModel)
    }
}


class XMFindVoiceFocusImageSectionController: ListSectionController {
    
    
    private var layout: XMFindVoiceLayout?
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: 0, bottom: xm_padding, right: 0)
    }
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: layout?.cellHeight ?? 0)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell: XMCommonFocusImageCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
            fatalError()
        }
        cell.imageUrls = layout?.focusImages
        return cell
    }
    
    override func didUpdate(to object: Any) {
        layout = (object as! XMFindVoiceLayout)
    }
}
