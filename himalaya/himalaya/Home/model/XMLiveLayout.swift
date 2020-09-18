//
//  XMLiveLayout.swift
//  himalaya
//
//  Created by Farben on 2020/9/1.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import IGListKit

class XMLiveLayout {
    
    enum XMLiveCellType {
        case live
        case hotChatRoom
        case focusImage
        case rank
    }
    
    var cellType: XMLiveCellType  = .live
    
    var cellSize: CGSize = .zero
    
    var hall: XMLiveHotModuleHallModel?
    var uniqueId: Int64 = 0
    init(hallModel: XMLiveHotModuleHallModel) {
        self.hall = hallModel
        let cellWH: CGFloat = UIDevice.isPad ? floor((content_view_width - 30) * 0.25) : floor((content_view_width - 10) * 0.5)
        cellType = .live
        uniqueId = hall!.roomId + hall!.id
        cellSize = CGSize(width: cellWH, height: cellWH)
    }

    var hotModuleModel: XMLiveHotModuleModel?
    init(hotModule: XMLiveHotModuleModel) {
        self.hotModuleModel = hotModule
        cellType = .hotChatRoom
        uniqueId = Int64(hotModule.rankListPosition + hotModule.cardRecommendPosition + hotModule.bannerPosition)
        cellSize = CGSize(width: content_view_width, height: 285)
    }
    
    var focusImageModels: [XMLiveFocusImageModel]?
    init(focusImages: [XMLiveFocusImageModel]) {
        self.focusImageModels = focusImages
        cellType = .focusImage
        uniqueId = 1599028559000
        cellSize = CGSize(width: content_view_width, height: ceil(content_view_width * 0.25))
    }
    
    
    var rankModel: XMLiveRankDataModel?
    init(rank: XMLiveRankDataModel) {
        self.rankModel = rank
        cellType = .rank
        uniqueId = rank.hpRankRollMillisecond + Int64( arc4random() % 10)
        cellSize = CGSize(width: content_view_width, height: UIDevice.isPad ? 80 : ceil(content_view_width * 0.2))
    }
}

extension XMLiveLayout: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return uniqueId as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let layout = object as? XMLiveLayout else {
            return false
        }
        return uniqueId == layout.uniqueId
    }
    
    
}

class XMLiveCategoryLayout {
    var categoryVoLists: [XMLiveCategoryVoListModel]?
    
    required init(lists: [XMLiveCategoryVoListModel]) {
        lists.first?.isSelected = true
        lists.last?.isHiddenLineRight = true
        self.categoryVoLists = lists
    }
}
