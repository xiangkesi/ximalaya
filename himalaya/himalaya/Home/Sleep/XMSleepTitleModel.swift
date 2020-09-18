//
//  XMSleepTitleModel.swift
//  himalaya
//
//  Created by cocoazhang on 2020/9/13.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import ObjectMapper

struct XMSleepTitleModel: Mappable {
    
    var baseCover: String?
    
    var baseCoverPad: String?
    
    var playCover: String?
    
    var title: String?
    
    var position: Int8 = 0
    
    var sceneId: Int8 = 0
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        baseCover          <- map["baseCover"]
        baseCoverPad          <- map["baseCoverPad"]
        playCover          <- map["playCover"]
        title          <- map["title"]
        position          <- map["position"]
        sceneId          <- map["sceneId"]
    }
    

    
}
