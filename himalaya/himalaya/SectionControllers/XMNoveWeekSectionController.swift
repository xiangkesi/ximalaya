//
//  XMNoveWeekSectionController.swift
//  himalaya
//
//  Created by cocoazhang on 2020/8/29.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import IGListKit

class XMNoveWeekSectionController: ListSectionController {
    
    
    private var layout: XMNoveLayout?
    override init() {
        super.init()
        inset = UIEdgeInsets(top: xm_padding, left: 0, bottom: 0, right: 0)
    }
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: layout?.cellHeight ?? 0)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell: XMNoveWeekCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
            fatalError()
        }
        cell.layout = layout
        adapter.collectionView = cell.collectionView
        return cell
    }
    
    private lazy var adapter: ListAdapter = {
        let adapter = ListAdapter(updater: ListAdapterUpdater(),
                                     viewController: self.viewController)
        adapter.dataSource = self
        return adapter
    }()
    
    override func didUpdate(to object: Any) {
        layout = (object as! XMNoveLayout)
    }
}

extension XMNoveWeekSectionController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return [layout!]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return XMNoveWeekScrollerSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
    
}

class XMNoveWeekScrollerSectionController: ListSectionController {
    
    private var cellWidth: CGFloat = 0
    private var cellHeight: CGFloat = 0
    private var cellImageViewHeight: CGFloat = 0
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: xm_padding, bottom: 0, right: xm_padding)
        minimumLineSpacing = 10
        cellWidth = floor((content_view_width - 40) * 0.5)
        cellImageViewHeight = ceil(cellWidth * 0.56)
        cellHeight = cellImageViewHeight + 40
    }
    
    private var layout: XMNoveLayout?
    
    override func numberOfItems() -> Int {
        return layout?.categoryContent?.lists?.count ?? 0
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell: XMCommonLevelListDetailCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                   fatalError()
        }
        if let items = layout?.categoryContent?.lists {
            let item = items[index]
            cell.topView.xm_height = cellImageViewHeight
            cell.topView.imageView.setWebpImage(urlString: item.coverSmall, placeHolderName: "new_playpage_default_wide")
            cell.labelTitle.xm_origin = CGPoint(x: 0, y: cell.topView.xm_bottom + 10)
            cell.labelTitle.xm_size = CGSize(width: cellWidth, height: item.titleAttrHeight)
            cell.labelTitle.attributedText = item.titleAttr
        }
        return cell
    }
    
    override func didUpdate(to object: Any) {
        layout = (object as! XMNoveLayout)
    }
}
