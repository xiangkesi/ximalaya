//
//  XMPageHomeSectionController.swift
//  himalaya
//
//  Created by Farben on 2020/8/24.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import IGListKit

class XMPageHomeSectionController: ListSectionController {
    
    private var cellHeight: CGFloat = 0
    override init() {
        super.init()
       
    }
    private var item: XMPageItem?
    init(height: CGFloat) {
        super.init()
        self.cellHeight = height
        minimumLineSpacing = 0
        minimumLineSpacing = 0
    }
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: self.cellHeight)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell: XMPageViewCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
            fatalError()
        }
        item?.controller = cell.controller
        if cell.isAddContentViewController == false {
            cell.isAddContentViewController = true
            viewController?.addChild(cell.controller)
        }
        return cell
    }
    
    override func didUpdate(to object: Any) {
        item = (object as! XMPageItem)
    }
}
