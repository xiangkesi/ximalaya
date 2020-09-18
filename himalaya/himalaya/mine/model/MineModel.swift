//
//  MineModel.swift
//  himalaya
//
//  Created by Farben on 2020/8/3.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import ObjectMapper

class MineModel: Mappable {
        
    var id: Int = 0
    
    var icon: String?
    
    var name: String?
    
    var linkUrl: String?
                
    required init?(map: Map) {
        
    }
    
    init() {
        
    }
    
    func mapping(map: Map) {
        id               <- map["id"]
        icon             <- map["icon"]
        name             <- map["name"]
        linkUrl          <- map["linkUrl"]
    }
}

struct MineSectionModel: Mappable {
        
    var models: [MineModel]?
    
    var userMsg: MineMsgReponse<MineMsgScoreModel>?
    
    var moduleName: String?
    
    var moduleId: Int = 0
    
    init() {
        
    }
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        moduleName          <- map["moduleName"]
        models              <- map["entrances"]
        moduleId              <- map["moduleId"]
    }
    
}
