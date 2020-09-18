//
//  XMAnchorCardSectionController.swift
//  himalaya
//
//  Created by Farben on 2020/8/17.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import IGListKit

class XMAnchorCardSectionController: ListSectionController {
    
//    private var item: HomeHeaderItemData?
       
    var item: HomeHeaderItem?
       override init() {
           super.init()
           inset = UIEdgeInsets(top: 0, left: xm_padding, bottom: 0, right: xm_padding)
           minimumLineSpacing = 10
       }
    
    override func numberOfItems() -> Int {
        return item?.lists?.count ?? 0
     }
       override func sizeForItem(at index: Int) -> CGSize {
           return CGSize(width: 120, height: 140)
       }
       
       override func cellForItem(at index: Int) -> UICollectionViewCell {
           guard let cell: HomeAnchorCardCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                fatalError()
           }
            if let items = item?.lists {
                cell.item = items[index]
            }
           return cell
           
       }
    
    override func didSelectItem(at index: Int) {
        let userCenterVc = XMUserDetailViewController()
        viewController?.navigationController?.pushViewController(userCenterVc, animated: true)
        
    }
       
       override func didUpdate(to object: Any) {
           if let item = object as? HomeHeaderItem {
               self.item = item
           }
       }
    
}
