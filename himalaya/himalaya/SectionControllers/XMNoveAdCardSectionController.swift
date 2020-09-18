//
//  XMNoveAdCardSectionController.swift
//  himalaya
//
//  Created by Farben on 2020/8/28.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import IGListKit

class XMNoveAdCardSectionController: ListSectionController {
    
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
        guard let cell: XMNoveAdCardCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
            fatalError()
         }
        if let model = layout?.categoryContent?.lists?.first {
            cell.leftImageView.setImage(urlString: model.coverPath, placeHolderName: "find_albumcell_cover_bg")
        }
        if let model = layout?.categoryContent?.lists?.last {
             cell.rightImageView.setImage(urlString: model.coverPath, placeHolderName: "find_albumcell_cover_bg")
        }
         return cell
    }
    
    override func didUpdate(to object: Any) {
           layout = (object as! XMNoveLayout)
       }
}
