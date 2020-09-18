//
//  XMVipFuncSectionController.swift
//  himalaya
//
//  Created by Farben on 2020/8/19.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import IGListKit

class XMVipFuncSectionController: ListSectionController {
    
    private var layout: XMVipLayout?
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 20, left: xm_padding, bottom: 0, right: xm_padding)
        minimumLineSpacing = 0
    }
    
    override func numberOfItems() -> Int {
        return layout?.module?.lists?.count ?? 0
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return layout!.cellSize
    }
//    var list: XMVipModuleListModel? {
//        didSet {
//            imageView?.setWebpImage(urlString: list?.icon, placeHolderName: "find_albumcell_cover_bg")
//            labelTitle?.text = list?.title
//        }
//    }
    override func cellForItem(at index: Int) -> UICollectionViewCell {
         guard let cell: XMVipFuncCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                   fatalError()
               }
        if let lists = layout?.module?.lists {
            let list = lists[index]
            cell.imageView?.setWebpImage(urlString: list.icon, placeHolderName: "find_albumcell_cover_bg")
            cell.labelTitle?.text = list.title
            
        }
        
         return cell
        
    }
    
    override func didUpdate(to object: Any) {
        layout = (object as! XMVipLayout)
    }
}
