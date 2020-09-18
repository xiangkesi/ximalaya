//
//  XMHomeFmLevelSectionController.swift
//  himalaya
//
//  Created by Farben on 2020/9/9.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import IGListKit

class XMHomeFmLevelSectionController: ListSectionController {
    
    
    private var layout: HomeLayout?
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
    
    override func numberOfItems() -> Int {
        return 2
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return index == 0 ? CGSize(width: content_view_width, height: 40) : CGSize(width: collectionContext!.containerSize.width, height: layout!.cellSize.height)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
            if index == 0 {
                guard let cell: XMHomeTopTitleCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                    fatalError()
                }
                cell.title = layout?.heder.headerItem?.title
                return cell
            }else {
                guard let cell: XMHomeFmLevelSectionCollectionCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                    fatalError()
                }
                adapter.collectionView = cell.collectionView
                return cell
            }
        }
    
    override func didUpdate(to object: Any) {
        if let l = object as? HomeLayout {
            layout = l
        }
    }
    
    private lazy var adapter: ListAdapter = {
        let adapter = ListAdapter(updater: ListAdapterUpdater(),
                                     viewController: self.viewController)
        adapter.dataSource = self
        return adapter
    }()
}

extension XMHomeFmLevelSectionController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        guard let items = layout?.headItems else {
            fatalError()
        }
        return items
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return XMFmListSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
    
}

class XMHomeFmLevelSectionCollectionCell: XMCommonCollectionViewCell {
    
    override func initWithSubViews() {
        super.initWithSubViews()
        contentView.addSubview(collectionView)
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.alwaysBounceVertical = false
        view.alwaysBounceHorizontal = true
        view.showsHorizontalScrollIndicator = false
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: xm_padding)
        return view
    }()
      
      override func layoutSubviews() {
          super.layoutSubviews()
          collectionView.frame = contentView.bounds
      }
}
