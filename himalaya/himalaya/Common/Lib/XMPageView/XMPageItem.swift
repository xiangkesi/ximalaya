//
//  XMPageItem.swift
//  himalaya
//
//  Created by Farben on 2020/8/24.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import IGListKit

class XMPageItem {
    
    var title: String?
    
    var imageName: String?
    
    var imageUrl: String?
    
    var theOnlyId: Int = 0
    
    var isFirstLoad: Bool = true
    
    var itemSize: CGSize = .zero
    
//    
//    var titleSelectedFont: UIFont?
//    
//    var titleNormalFont: UIFont?
//    
//    var titleSelectedColor: UIColor?
//    
//    var titleNormalColor: UIColor?

    weak var controller: UIViewController?
    
    weak var cell: XMPageCommonViewCell?
    
}

extension XMPageItem: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return theOnlyId as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let item = object as? XMPageItem else {
            return false
        }
        return theOnlyId == item.theOnlyId
    }
    
    
}
