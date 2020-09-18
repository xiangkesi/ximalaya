//
//  XMMineLayout.swift
//  himalaya
//
//  Created by Farben on 2020/8/28.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import IGListKit

class XMMineLayout {
    
    
    var uniqueId: String = ""
    
    var section: MineSectionModel?
            
    var viewBgHeight: CGFloat = 0
    var cellSize: CGSize = .zero
    
    
    init(sectionModel: MineSectionModel) {
        
        self.section = sectionModel
        uniqueId = "\(sectionModel.moduleId)" + (sectionModel.moduleName ?? "")
        let cellWH = floor((content_view_width) * 0.25)
        cellSize = CGSize(width:  cellWH, height:  cellWH)
        
        if let models = sectionModel.models {
            let lines = CGFloat(((models.count - 1) / 4) + 1)
            viewBgHeight = lines * cellWH + 40
        }
    }
}

extension XMMineLayout: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return uniqueId as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let layout = object as? XMMineLayout else {
            return false
        }
        return uniqueId == layout.uniqueId
    }
    
    
}
