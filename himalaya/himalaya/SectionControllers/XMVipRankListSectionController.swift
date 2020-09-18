//
//  XMVipRankListSectionController.swift
//  himalaya
//
//  Created by Farben on 2020/8/25.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import IGListKit

class XMVipRankListSectionController: ListSectionController {
    
    private var layout: XMVipAlbumLayout?
    
    override init() {
        super.init()
        minimumLineSpacing = 10
        minimumInteritemSpacing = 10
        inset = UIEdgeInsets(top: 0, left: xm_padding, bottom: 0, right: xm_padding)
    }
    override func didUpdate(to object: Any) {
        if let l = object as? XMVipAlbumLayout {
            layout = l
        }
    }
    
    override func numberOfItems() -> Int {
        return layout?.album.adModel?.rankTables?.count ?? 0
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: 290, height: 290)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell: XMVipClassificationCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                       fatalError()
         }
        if let rankTables = layout?.album.adModel?.rankTables {
            cell.rankTable = rankTables[index]
        }
         return cell
    }
}
