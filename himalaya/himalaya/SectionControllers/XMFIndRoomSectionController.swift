//
//  XMFIndRoomSectionController.swift
//  himalaya
//
//  Created by cocoazhang on 2020/9/6.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import IGListKit

class XMFIndRoomSectionController: ListSectionController {
    
    
    private var layout: XMFindRecdLayout?
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
    
    override func numberOfItems() -> Int {
        return 2
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return index == 0 ? CGSize(width: content_view_width, height: 40) : CGSize(width: collectionContext!.containerSize.width, height: layout?.cellHeight ?? 0)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        if index == 0 {
            guard let cell: XMHomeTopTitleCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                       fatalError()
                   }
            cell.title = layout?.leverTitle
            return cell
        }else {
            guard let cell: XMCommonLevelListCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
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
        if let l = object as? XMFindRecdLayout {
            layout = l
        }
    }
    
}

extension XMFIndRoomSectionController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return [layout!]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return XMFindRoomLeverSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
    
}

class XMFindRoomLeverSectionController: ListSectionController {
    
    
    private var layout: XMFindRecdLayout? {
        didSet {
            if layout?.findItem?.type == "CommunityRecommendation" {
                minimumLineSpacing = 30
            }else {
                minimumLineSpacing = 10
            }
        }
    }
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: xm_padding, bottom: 0, right: xm_padding)
       
        
    }
    
    override func numberOfItems() -> Int {
        if layout?.findItem?.type == "CommunityRecommendation" {
            return layout?.findItem?.cycles?.count ?? 0
        }
        return layout?.findItem?.item?.advertiseContent?.rooms?.count ?? 0
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        if layout?.findItem?.type == "CommunityRecommendation" {
            return CGSize(width: 90, height: 180)
        }
        return CGSize(width: 100, height: 155)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        
        if layout?.findItem?.type == "CommunityRecommendation" {
            guard let cell: XMFindRecdCycleCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                fatalError()
            }
            if let cycles = layout?.findItem?.cycles {
                let cycle = cycles[index]
                cell.imageView?.setImage(urlString: cycle.logo, placeHolderName: "find_vip_default_icon")
                if cycle.icon != nil {
                    cell.imageBageView?.isHidden = false
                    cell.imageBageView?.setImage(urlString: cycle.icon, placeHolderName: nil)
                }else {
                    cell.imageBageView?.isHidden = true
                }
                cell.labelTitle?.attributedText = cycle.attrTitle
                           cell.backgroundColor = UIColor.lightGray
                
            }
           
            return cell
        }else {
            guard let cell: XMCommonLevelCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                fatalError()
            }
            if let rooms = layout?.findItem?.item?.advertiseContent?.rooms {
                let room = rooms[index]
                cell.topView?.xm_size = CGSize(width: 100, height: 100)
                cell.topView?.imageView?.setImage(urlString: room.coverUrl, placeHolderName: "find_vip_default_icon")
                cell.labelTitle?.xm_height = room.titleAttrHeight
                cell.labelTitle?.attributedText = room.titleAttr
                cell.topView?.labelBottomTitle?.attributedText = room.countAttr
            }
            return cell
        }
    }
    
    override func didUpdate(to object: Any) {
        if let l = object as? XMFindRecdLayout {
            layout = l
        }
    }
    
}
