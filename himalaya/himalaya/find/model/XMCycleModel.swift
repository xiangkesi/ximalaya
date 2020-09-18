//
//  XMFindNoticeCycleModel.swift
//  himalaya
//
//  Created by Farben on 2020/9/10.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import ObjectMapper
import IGListKit


struct XMCycleModel: Mappable {
    
    var communitieModel: XMCyclejoinedCommunitieModel?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        communitieModel          <- map["joinedCommunities"]
    }
}

struct XMCyclejoinedCommunitieModel: Mappable {
    
    var hasMore: Bool = false
    
    var lists: [XMCycleListModel]?
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        hasMore          <- map["hasMore"]
        lists          <- map["list"]
    }
}

class XMCycleListModel: Mappable {
    
    var name: String?
    
    var articleCount: Int = 0
    
    var id: Int = 0
    
    var icon: String?
    
    var logo: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        name          <- map["name"]
        articleCount          <- map["articleCount"]
        id          <- map["id"]
        icon          <- map["icon"]
        logo          <- map["logo"]
        
    }
}

extension XMCycleListModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let model = object as? XMCycleListModel else {
            return false
        }
        return id == model.id
    }
    
    
}

//struct XMCycleModel: Mappable {
//
//    init?(map: Map) {
//
//    }
//
//    mutating func mapping(map: Map) {
//
//    }
//
//
//}
//
//struct XMCyclejoinedCommunitieModel: Mappable {
//
//}
