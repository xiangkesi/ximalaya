//
//  XMSleepingVerticalSectionController.swift
//  himalaya
//
//  Created by Farben on 2020/8/31.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import IGListKit

class XMSleepingVerticalSectionController: ListSectionController {
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: xm_padding, left: xm_padding, bottom: 0, right: xm_padding)
    }
    
    private var layout: XMNoveLayout?
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: content_view_width, height: layout?.cellHeight ?? 0)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell: XMCommonVerticalListCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
            fatalError()
        }
        cell.headView.labelTitle.text = layout?.categoryContent?.title
        cell.layout = layout
        return cell
    }
    
    override func didUpdate(to object: Any) {
        layout = (object as! XMNoveLayout)
    }
}
