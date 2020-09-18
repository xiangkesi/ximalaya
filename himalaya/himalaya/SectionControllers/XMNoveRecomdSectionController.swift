//
//  XMNoveRecomdSectionController.swift
//  himalaya
//
//  Created by Farben on 2020/8/31.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit
import IGListKit

class XMNoveRecomdSectionController: ListSectionController {
    override init() {
        super.init()
        inset = UIEdgeInsets(top: xm_padding, left: 0, bottom: 0, right: 0)
    }
    private var layout: XMNoveLayout?
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: layout?.cellHeight ?? 0)
    }
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell: XMCommonLevelListTopCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
            fatalError()
        }
        cell.labelTitle.text = layout?.categoryContent?.title
        return cell
    }
    
    override func didUpdate(to object: Any) {
        layout = (object as! XMNoveLayout)
    }
}
