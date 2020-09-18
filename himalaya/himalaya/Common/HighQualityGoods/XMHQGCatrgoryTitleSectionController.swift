//
//  XMHQGCatrgoryTitleSectionController.swift
//  himalaya
//
//  Created by Farben on 2020/9/16.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import IGListKit

class XMHQGCatrgoryTitleSectionController: ListSectionController {
    
    private weak var viewModel: XMHQGViewModel?
    
    private var layout: XMHQGLayout?
//    override init() {
//        super.init()
//        inset = UIEdgeInsets(top: xm_padding, left: 0, bottom: 0, right: 0)
//        supplementaryViewSource = self
//        minimumLineSpacing = xm_padding
//    }
    
    required init(viewModel: XMHQGViewModel) {
        super.init()
        self.viewModel = viewModel
        inset = UIEdgeInsets(top: xm_padding, left: 0, bottom: 0, right: 0)
        supplementaryViewSource = self
        minimumLineSpacing = xm_padding
    }
    
    override func numberOfItems() -> Int {
        return layout?.albumLayouts.count ?? 0
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        if let albumLayouts = layout?.albumLayouts {
          return CGSize(width: collectionContext!.containerSize.width, height: albumLayouts[index].cellHeight)
        }
        return CGSize(width: collectionContext!.containerSize.width, height: 0)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
//        XMHQGTitlePictureCell
        guard let albumLayouts = layout?.albumLayouts else {
            fatalError()
        }
        let albumLayout = albumLayouts[index]
        switch albumLayout.cellType {
        case .module(.picture):
            guard let cell: XMHQGTitlePictureCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                fatalError()
            }
            cell.imageView?.setWebpImage(urlString: albumLayout.resultAlbum.albumData?.picture, placeHolderName: "new_playpage_default_wide")
            return cell
        case .module(.rank_list):
            guard let cell: XMHQGAlbumCollectionCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                fatalError()
            }
            cell.albumData = albumLayout.resultAlbum.albumData
            return cell
        case .module(.star):
            guard let cell: XMHQGStarMemberCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                fatalError()
            }
            cell.albumModel = albumLayout.resultAlbum
            return cell
        default:
            guard let cell: HomeBodyAlbumCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                fatalError()
            }
            if let albumLayouts = layout?.albumLayouts {
                cell.hqgLayout = albumLayouts[index]
            }
            return cell
        }
        
        
    }
    
    override func didUpdate(to object: Any) {
        layout = (object as! XMHQGLayout)
    }
    
    private lazy var headView: XMHQGTitleHeadView = {
        guard let headView = collectionContext?.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: self, class: XMHQGTitleHeadView.self, at: 0) as? XMHQGTitleHeadView else {
              fatalError()
        }
        headView.callBack = { [weak self](word) in
            self?.viewModel?.requestParam.offset = 0
            self?.viewModel?.requestAlbum.onNext(word.categoryId)
        }
        return headView
    }()
}

extension XMHQGCatrgoryTitleSectionController: ListSupplementaryViewSource {
    func sizeForSupplementaryView(ofKind elementKind: String, at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 50)
    }
    
    
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
    
    private func titleHeaderView(atIndex index: Int) -> UICollectionReusableView {
        
        let head_view = headView
        head_view.titleModels = layout?.words
        return head_view
    }
}
