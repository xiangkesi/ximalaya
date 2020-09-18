//
//  XMVipSquarePictureSectionController.swift
//  himalaya
//
//  Created by Farben on 2020/8/19.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import IGListKit

class XMVipSquarePictureSectionController: ListSectionController {
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
    
    private var layout: XMVipLayout?
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return layout!.cellSize
    }
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell: XMVipSquarePictureCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
            fatalError()
        }
        cell.layout = layout
        return cell
    }
    
    override func didUpdate(to object: Any) {
        layout = (object as! XMVipLayout)
    }
}
