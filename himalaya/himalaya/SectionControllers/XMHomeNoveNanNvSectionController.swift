//
//  XMHomeNoveNanNvSectionController.swift
//  himalaya
//
//  Created by cocoazhang on 2020/9/8.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import IGListKit

class XMHomeNoveNanNvSectionController: ListSectionController {
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: xm_padding, left: 0, bottom: 0, right: 0)
    }
    
    private var layout: XMNoveLayout?
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: layout?.cellHeight ?? 0)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell: HomeNoveManWomenLoveLevelListCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
            fatalError()
        }
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
           if let l = object as? XMNoveLayout {
               layout = l
           }
       }
    
}

extension XMHomeNoveNanNvSectionController: ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        guard let items = layout?.categoryContent?.lists else {
            fatalError()
        }
        return items
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return XMHomeNoveNanNvLevelSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
    
}

class XMHomeNoveNanNvLevelSectionController: ListSectionController {
    
    
    private var listModel: XMNoveCategoryContentList_listModel?
    
    
    private lazy var bgView: UIView = {
        let b_view = UIView()
        b_view.backgroundColor = UIColor.xm.xm_255_30_color
        b_view.xm_origin = CGPoint(x: xm_padding, y: 0)
        b_view.xm_size = CGSize(width: cellWidth + 30, height: 355)
        b_view.layer.cornerRadius = 5
        return b_view
    }()
    
    private var cellWidth: CGFloat = UIDevice.isPad ? 300 : ceil(content_view_width * 0.8)
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 15)
        minimumInteritemSpacing = 10
        minimumLineSpacing = 10
        workingRangeDelegate = self
    }
    
    override func numberOfItems() -> Int {
        guard let count = listModel?.nanNvLoveModels?.count else {
            return 0
        }
        return count + 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: cellWidth, height: index == 0 ? 40 : 90)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        
        if index == 0 {
            guard let cell: HomeNoveManWomenLoveTopCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                fatalError()
            }
            bgView.xm_x = cell.xm_x - xm_padding
            cell.labelTitle?.text = listModel?.subtitle
            return cell
        }
        guard let cell: HomeNoveManWomenLoveCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
            fatalError()
        }
        if let models = listModel?.nanNvLoveModels {
            let model = models[index - 1]
            cell.loveModel = model
        }
        return cell
    }
    
    override func didUpdate(to object: Any) {
        guard let model = object as? XMNoveCategoryContentList_listModel  else {
            fatalError()
        }
        listModel = model
    }
}

extension XMHomeNoveNanNvLevelSectionController: ListWorkingRangeDelegate {
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerWillEnterWorkingRange sectionController: ListSectionController) {
        listAdapter.collectionView?.insertSubview(bgView, at: 0)
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerDidExitWorkingRange sectionController: ListSectionController) {
        bgView.removeFromSuperview()
    }
    
    
}
