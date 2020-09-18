//
//  XMItingLayout.swift
//  himalaya
//
//  Created by Farben on 2020/9/18.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import IGListKit

class XMItingLayout {
    
    var resultTitles: [XMMeTingTitleModel]?
    
    var uniqueId: Int8 = 0
    
//    XMItingDataModel
    
    var isGrid: Bool = false
    
    
    var resultModel: XMItingDataModel?
    
    init(titleModels: [XMMeTingTitleModel]) {
        resultTitles = titleModels
    }
}

extension XMItingLayout: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return uniqueId as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let model = object as? XMItingLayout else {
            return false
        }
        return uniqueId == model.uniqueId
    }
    
    
}
