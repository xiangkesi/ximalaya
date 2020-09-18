//
//  XMFindNoticeHeadSectionController.swift
//  himalaya
//
//  Created by Farben on 2020/9/10.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import IGListKit

class XMFindNoticeHeadSectionController: ListSectionController {
    
    
    private var layout: XMFindRecdLayout?
    override init() {
        super.init()
    }
    
    override func numberOfItems() -> Int {
        return 2
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: index == 0 ? 50 : 110)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        if index == 0 {
            guard let cell: XMFIndNoticeHeadTitleCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                fatalError()
            }
            cell.labelTitle?.text = "我加入的圈子"
            return cell
        }else {
            guard let cell: XMFindNoticeCollectionCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                fatalError()
            }
            cell.lists = layout?.noticeHeadModel?.communitieModel?.lists
            return cell
        }
    }
    
    override func didUpdate(to object: Any) {
        
        guard let l = object as? XMFindRecdLayout else {
            fatalError()
        }
        layout = l
    }
//
//    private lazy var adapter: ListAdapter = {
//        let adapter = ListAdapter(updater: ListAdapterUpdater(),
//                                     viewController: self.viewController)
//        adapter.dataSource = self
//        return adapter
//    }()
}

//extension XMFindNoticeHeadSectionController: ListAdapterDataSource {
//    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
//        guard let lists = layout?.noticeHeadModel?.communitieModel?.lists else {
//            fatalError()
//        }
//        return lists
//    }
//
//    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
//        let configureBlock = { (item: Any, cell: UICollectionViewCell) in
//            guard let cell = cell as? XMFindNoticeHeadCell else { return }
//            cell.backgroundColor = UIColor.red
//        }
//
//        let sizeBlock = { (item: Any, context: ListCollectionContext?) -> CGSize in
//            guard context != nil else { return .zero }
//            return CGSize(width: 100, height: 130)
//        }
//
//        return ListSingleSectionController(cellClass: XMFindNoticeHeadCell.self, configureBlock: configureBlock, sizeBlock: sizeBlock)
//    }
//
//    func emptyView(for listAdapter: ListAdapter) -> UIView? {
//        return nil
//    }
//
//
//}
