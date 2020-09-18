//
//  XMVipAlbumSectionController.swift
//  himalaya
//
//  Created by Farben on 2020/8/21.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import IGListKit

class XMVipAlbumSectionController: ListSectionController {
    
    override init() {
        super.init()
    }
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell: HomeBodyAlbumCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
            fatalError()
        }
        return cell
    }
}
