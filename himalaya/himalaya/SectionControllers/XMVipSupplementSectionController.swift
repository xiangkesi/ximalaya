//
//  XMVipSupplementSectionController.swift
//  himalaya
//
//  Created by Farben on 2020/8/21.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import IGListKit

class XMVipSupplementSectionController: ListSectionController {
    
    private weak var viewModel: XMVipViewModel?
    
    private var currentIndex: Int = 0
    
    init(viewModel: XMVipViewModel) {
        super.init()
        self.viewModel = viewModel
        supplementaryViewSource = self
        minimumLineSpacing = xm_padding
        inset = UIEdgeInsets(top: xm_padding, left: 0, bottom: xm_padding, right: 0)
    }
    
    override func numberOfItems() -> Int {
        return viewModel?.currentLayouts.count ?? 0
        
        
    }
    override func sizeForItem(at index: Int) -> CGSize {
        guard let height = viewModel?.currentLayouts[index].cellHeight else {
            return CGSize(width: collectionContext!.containerSize.width, height: 150)
        }
        return CGSize(width: collectionContext!.containerSize.width, height: height)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let layout = viewModel?.currentLayouts[index] else {
            fatalError()
        }
        switch layout.cellType {
        case .album,
             .track:
            guard let cell: HomeBodyAlbumCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                fatalError()
            }
            cell.vipLayoput = layout
            return cell
        case .module(.interest_and_hot_word):
            guard let cell: XMVipInsterestCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                           fatalError()
                       }
            cell.album = layout.album.adModel
            return cell
        case .module(.custom_album_aggregate_card):
            guard let cell: XMVipFilmTelevisionCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                           fatalError()
                       }
            cell.layout = layout
            return cell
        case .module(.rank_list):
            guard let cell: XMVipHistoryListenCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                           fatalError()
                       }
            self.currentAlbumLayout = layout
            adapter.collectionView = cell.collectionView
            return cell
        case .module(.custom_album_aggregate_picture):
            guard let cell: XMVipAdListCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                fatalError()
            }
            cell.imageView.setWebpImage(urlString: layout.album.adModel?.propertieModel?.aggregatePictures, placeHolderName: "new_playpage_default_wide")
            return cell
        default:
            fatalError()
        }        
    }
    private var layout: XMVipLayout?
    
    private var currentAlbumLayout: XMVipAlbumLayout?
    
    override func didUpdate(to object: Any) {
        layout = (object as! XMVipLayout)
    }
    
    private lazy var adapter: ListAdapter = {
        let adapter = ListAdapter(updater: ListAdapterUpdater(),
                                     viewController: self.viewController)
        adapter.dataSource = self
        return adapter
    }()
    
    private lazy var headView: XMVipTitlesHeaderView = {
        guard let headView = collectionContext?.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: self, class: XMVipTitlesHeaderView.self, at: 0) as? XMVipTitlesHeaderView else {
              fatalError()
        }
        
        headView.clickLabel = {[weak self](word) in
            self?.viewModel?.requestDetailParam.isDrop = true
            self?.viewModel?.requestDetailParam.offset = 16
            self?.viewModel?.requestDetail.onNext(word)
        }
        return headView
    }()
    
}

extension XMVipSupplementSectionController: ListSupplementaryViewSource {
    func supportedElementKinds() -> [String] {
        return [UICollectionView.elementKindSectionHeader]
    }
    
    func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
        switch elementKind {
        case UICollectionView.elementKindSectionHeader:
            return titleHeaderView(atIndex: index)
        default:
            fatalError()
        }
    }
    
    func sizeForSupplementaryView(ofKind elementKind: String, at index: Int) -> CGSize {
        return layout?.cellSize ?? CGSize(width: 0, height: 0)
    }
    
    private func titleHeaderView(atIndex index: Int) -> UICollectionReusableView {
        let head_view = headView
        head_view.categorieWords = layout?.categorieWords
        return head_view
    }
}

extension XMVipSupplementSectionController: ListAdapterDataSource {
//    ListAdapterDataSource
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        guard let layout = self.currentAlbumLayout else {
            fatalError()
        }
        return [layout]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return XMVipRankListSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
