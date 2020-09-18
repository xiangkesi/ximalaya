//
//  XMBanderSectionController.swift
//  himalaya
//
//  Created by Farben on 2020/8/21.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import IGListKit

class XMBanderSectionController: ListSectionController {
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: xm_padding, left: 0, bottom: 0, right: 0)
    }
    
    private var layout: XMVipLayout?
    override func numberOfItems() -> Int {
           return 1
       }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return layout?.cellSize ?? CGSize(width: 0, height: 0)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell: HomeBanderCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                       fatalError()
         }
        cell.imageUrls = layout?.imageUrls
         return cell
    }
    
    
    override func didUpdate(to object: Any) {
        layout = (object as! XMVipLayout)
    }
}


