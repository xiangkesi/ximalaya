//
//  XMHQGGuessLikeSectionController.swift
//  himalaya
//
//  Created by Farben on 2020/9/16.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import IGListKit

class XMHQGGuessLikeSectionController: ListSectionController {
    
    
    private var layout: XMHQGLayout?
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        minimumLineSpacing = 0
    }
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: layout?.cellHeight ?? 0)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell: XMCommonLikeTitleCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
           fatalError()
        }
        cell.qhgLayout = layout
        return cell
    }
    
    
    override func didUpdate(to object: Any) {
        layout = (object as! XMHQGLayout)
    }
    
    
}
