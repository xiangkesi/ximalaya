//
//  XMOtherSectionController.swift
//  himalaya
//
//  Created by Farben on 2020/8/18.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import IGListKit

class XMHotPlayRankSectionController: ListSectionController {
    
    private var layout: HomeLayout?
    
    override init() {
        super.init()
        self.inset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 10)
        self.minimumLineSpacing = 10
        self.minimumInteritemSpacing = 10
        supplementaryViewSource = self
    }
    override func numberOfItems() -> Int {
        return layout?.heder.headerItem?.lists?.count ?? 0
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        switch layout?.cellType {
        case .module(.hotSearchList):
            return CGSize(width: 200, height: 30)
        case .module(.hotPlayRank):
            return CGSize(width: 260, height: 80)
        default:
            return CGSize.zero
        }
    }
       
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        
        switch layout?.cellType {
        case .module(.hotSearchList):
            guard let cell: HomeHotSearchDetailCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                      fatalError()
                  }
            if let words = layout?.heder.headerItem?.lists {
                cell.labelTitle?.text = words[index].word
                cell.imageView?.attributedText = words[index].workRank
                cell.layerBg?.isHidden = !words[index].isShowSearchHotLayer
            }
            return cell
            
            
        case .module(.hotPlayRank):
            guard let cell: HomeHotPlayRankDetailCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                      fatalError()
                  }
            if let lists = layout?.heder.headerItem?.lists {
                cell.item = lists[index]
            }
            return cell            
        default:
            fatalError()
//            guard let cell: XMHomeCatrgoryKeyWordCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
//                fatalError()
//            }
//            if let lists = headerItem?.lists {
//                cell.item = lists[index]
//            }
//            return cell
            
        }
    }
       
    override func didSelectItem(at index: Int) {
        switch layout?.cellType {
        case .module(.hotSearchList):
            let searchResultVc = XMSearchResultPageController()
            viewController?.navigationController?.pushViewController(searchResultVc, animated: true)
        case .module(.hotPlayRank):
            let albumVc = XMAlbumListController()
            viewController?.navigationController?.pushViewController(albumVc, animated: true)
        default:
            break
        }
    }
    
    override func didUpdate(to object: Any) {
        layout = (object as! HomeLayout)
    }
    
}

extension XMHotPlayRankSectionController: ListSupplementaryViewSource {
    func supportedElementKinds() -> [String] {
        return [UICollectionView.elementKindSectionFooter]
    }
//    XMFooterCollectionReusableView
    func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
        guard let headView = collectionContext?.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, for: self, class: XMFooterCollectionReusableView.self, at: index) as? XMFooterCollectionReusableView else {
            fatalError()
        }
        headView.clickFooter = {[weak self] in
            if self?.layout?.cellType == .module(.hotSearchList) {
                let searchVc = XMSearchViewController()
                 self?.viewController?.navigationController?.pushViewController(searchVc, animated: true)
            }else {
                let rankListVc = XMVeryLoveListViewController()
                self?.viewController?.navigationController?.pushViewController(rankListVc, animated: true)
            }
        }
        headView.btnMore?.xm_y = 10
        headView.btnMore?.xm_height = headView.xm_height - 20
        return headView
    }
    
    func sizeForSupplementaryView(ofKind elementKind: String, at index: Int) -> CGSize {
        return CGSize(width: 100, height: layout?.cellSize.height ?? 0)
    }
}
