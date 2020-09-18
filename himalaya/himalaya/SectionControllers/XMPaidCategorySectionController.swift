//
//  XMPaidCategorySectionController.swift
//  himalaya
//
//  Created by Farben on 2020/8/17.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import IGListKit

class XMPaidCategorySectionController: ListSectionController {
    
    private var item: HomeHeaderItem?
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        minimumLineSpacing = 10
        supplementaryViewSource = self
    }
    override func numberOfItems() -> Int {
        return item?.lists?.count ?? 0
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: 100, height: 155)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell: HomeGuessLikeCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                   fatalError()
        }
       
        if let items = item?.lists {
            cell.itemData = items[index]
        }
        return cell
    }
    
    
    override func didSelectItem(at index: Int) {
        let albumList = XMAlbumListController()
        viewController?.navigationController?.pushViewController(albumList, animated: true)
    }
    
    override func didUpdate(to object: Any) {
        if let item = object as? HomeHeaderItem {
            self.item = item
        }
        
    }
}

extension XMPaidCategorySectionController: ListSupplementaryViewSource {
    func supportedElementKinds() -> [String] {
        return [UICollectionView.elementKindSectionFooter]
    }
    
    func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
        guard let headView = collectionContext?.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, for: self, class: XMFooterCollectionReusableView.self, at: index) as? XMFooterCollectionReusableView else {
            fatalError()
        }
        headView.clickFooter = {[weak self] in
            let jingpinVc = XMHighQualityGoodsViewController()
            self?.viewController?.navigationController?.pushViewController(jingpinVc, animated: true)
        }
        headView.btnMore?.frame = headView.bounds
        return headView
    }
    
    func sizeForSupplementaryView(ofKind elementKind: String, at index: Int) -> CGSize {
        return CGSize(width: 100, height: 155)
    }
}
