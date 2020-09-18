//
//  XMNoveFilmSectionController.swift
//  himalaya
//
//  Created by Farben on 2020/8/27.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import IGListKit

class XMNoveFilmSectionController: ListSectionController {
    
    private var layout: XMNoveLayout?
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: xm_padding, left: 0, bottom: 0, right: 0)
    }
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        CGSize(width: collectionContext?.containerSize.width ?? 0, height: layout?.cellHeight ?? 0)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell: XMNoveFlimCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
            fatalError()
         }
        cell.layout = layout
         return cell
    }
    
    
    override func didUpdate(to object: Any) {
        layout = (object as! XMNoveLayout)
    }
}
