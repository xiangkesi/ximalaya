//
//  XMNoveOtherSectionController.swift
//  himalaya
//
//  Created by Farben on 2020/8/31.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import IGListKit

class XMNoveOtherSectionController: ListSectionController {
    override init() {
        super.init()
        inset = UIEdgeInsets(top: xm_padding, left: 0, bottom: 0, right: 0)
    }
    
    private var layout: XMNoveLayout?
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        CGSize(width: collectionContext?.containerSize.width ?? 0, height: layout?.cellHeight ?? 0)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell: XMNoceCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                       fatalError()
         }
//        cell.nove_layout = layout
         return cell
    }
    
    
    override func didUpdate(to object: Any) {
        layout = (object as! XMNoveLayout)
    }
    
    
//    override func sizeForItem(at index: Int) -> CGSize {
//        return
//    }
}

class XMNoceCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
