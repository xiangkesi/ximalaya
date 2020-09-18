//
//  XMNoveAlbumRecomdSectionController.swift
//  himalaya
//
//  Created by Farben on 2020/8/31.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit
import IGListKit

class XMNoveAlbumRecomdSectionController: ListSectionController {
    
    private var layout: XMNoveLayout?
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: 0, bottom: xm_padding, right: 0)
    }
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        CGSize(width: collectionContext!.containerSize.width, height: layout?.cellHeight ?? 0)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell: HomeBodyAlbumCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                   fatalError()
               }
        cell.noveLayout = layout
        return cell
    }
    override func didUpdate(to object: Any) {
        layout = (object as! XMNoveLayout)
    }
    
}
