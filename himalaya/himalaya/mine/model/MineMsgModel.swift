//
//  MineMsgModel.swift
//  himalaya
//
//  Created by Farben on 2020/8/4.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import ObjectMapper


struct MineMsgScoreModel: Mappable {
    
    
    var iconPath: String?
    
    var checkInReminder: String?
    
    var checkInReward: String?
    
    var signature: String?
    
    var urlString: String?

    
    init?(map: Map) {
        
    }
    
    init() {
        
    }
    
    mutating func mapping(map: Map) {
        
        iconPath               <- map["iconPath"]
        checkInReminder               <- map["checkInReminder"]
        checkInReward               <- map["checkInReward"]
        signature               <- map["signature"]
        urlString               <- map["url"]
        
    }
}

struct MineVipResourceInfo: Mappable {
    
    var type: Int = 0
    
    var positionId: Int = 0
    
    var url: String?
    
    var resource: String?
    
    
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        type               <- map["type"]
        positionId               <- map["positionId"]
        url               <- map["url"]
        resource               <- map["resource"]
        
    }
    
}

struct BannerActivityResult: Mappable {
    
    var linkUrl: String?
    
    var imgUrl: String?
    
    var activities: [[String: String]]?
    
    var text: String?
    
        
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        linkUrl               <- map["linkUrl"]
        imgUrl               <- map["imgUrl"]
        activities            <- map["activities"]
        
        if let array = activities, let dic = array.first, let t = dic["name"] {
            text = t
        }
    }
    
    
}
