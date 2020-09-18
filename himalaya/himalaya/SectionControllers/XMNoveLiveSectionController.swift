//
//  XMNoveLiveSectionController.swift
//  himalaya
//
//  Created by Farben on 2020/8/31.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import IGListKit

class XMNoveLiveLeveSectionController: ListSectionController {
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: xm_padding, bottom: 0, right: xm_padding)
        minimumLineSpacing = 10
    }
    
    private var layout: XMNoveLayout?
    
    override func numberOfItems() -> Int {
        return layout?.categoryContent?.lists?.count ?? 0
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: 100, height: 160)
    }
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell: XMCommonLevelListDetailCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
            fatalError()
        }
        if let items = layout?.categoryContent?.lists {
            let item = items[index]
            cell.topView.xm_height = cell.contentView.xm_width
            cell.topView.imageView.setWebpRoundImage(urlString: item.coverMiddle, placeHolderName: "find_albumcell_cover_bg", corner: 10, rectCorner: [.topLeft, .topRight])
            cell.labelTitle.xm_origin = CGPoint(x: 10, y: cell.topView.xm_bottom + 10)
            cell.labelTitle.xm_size = CGSize(width: 80, height: item.titleAttrHeight)
            cell.labelTitle.attributedText = item.titleAttr
        }
        
        return cell
    }
    
    override func didUpdate(to object: Any) {
        layout = (object as! XMNoveLayout)
    }
}

class XMNoveLiveSectionController: ListSectionController {
    
    
    private var layout: XMNoveLayout? {
        didSet {
            if layout != nil {
                layouts.removeAll()
                layouts.append(layout!)
            }
        }
    }
    
    private lazy var layouts = [XMNoveLayout]()
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: xm_padding, left: 0, bottom: 0, right: 0)
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
    }
    
    override func numberOfItems() -> Int {
        return 2
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return index == 0 ? CGSize(width: collectionContext!.containerSize.width, height: 40) : CGSize(width: collectionContext!.containerSize.width, height: layout!.cellHeight - 40)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        if index == 0 {
            guard let cell: XMCommonLevelListTopCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                fatalError()
            }
            cell.labelTitle.text = layout?.categoryContent?.title
            return cell
        }
        
        guard let cell: XMCommonLevelListCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
            fatalError()
        }
        
        adapter.collectionView = cell.collectionView
        return cell
    }
    
    override func didUpdate(to object: Any) {
        layout = (object as! XMNoveLayout)
    }
    
    private lazy var adapter: ListAdapter = {
        let adapter = ListAdapter(updater: ListAdapterUpdater(),
                                        viewController: self.viewController)
        adapter.dataSource = self
        return adapter
    }()
}

extension XMNoveLiveSectionController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return layouts as [ListDiffable]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return XMNoveLiveLeveSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
    
}
