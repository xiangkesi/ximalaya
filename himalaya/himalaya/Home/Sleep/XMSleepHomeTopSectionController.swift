//
//  XMSleepHomeTopSectionController.swift
//  himalaya
//
//  Created by cocoazhang on 2020/9/13.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import IGListKit

class XMSleepHomeTopSectionController: ListSectionController {
    
    override init() {
        super.init()
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 350)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell: XMHomeTopCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
            fatalError()
        }
        return cell
    }
}
