//
//  XMHomeCategoryWordSectionController.swift
//  himalaya
//
//  Created by Farben on 2020/9/9.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import IGListKit

class XMHomeCategoryWordSectionController: ListSectionController {
    
    
    private var layout: HomeLayout?
    override init() {
        super.init()
//        inset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: xm_padding)
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return layout?.cellSize ?? CGSize.zero
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell: XMHomeCatrgoryKeyWordCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
            fatalError()
        }
        cell.clickBtn = {[weak self] (item) in
            let searchResultVc = XMSearchResultPageController()
            self?.viewController?.navigationController?.pushViewController(searchResultVc, animated: true)
        }
        cell.layout = layout
        return cell
    }
    
    
    override func didUpdate(to object: Any) {
        layout = (object as! HomeLayout)
    }
    
    
}
