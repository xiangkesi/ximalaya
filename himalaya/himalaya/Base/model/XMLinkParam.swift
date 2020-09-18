//
//  XMLinkParam.swift
//  himalaya
//
//  Created by Farben on 2020/8/19.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import ObjectMapper
struct XMLinkParam: Mappable {
    
    var msg_type: String?
    
    var album_id: String?
    
    var track_id: String?
    
    var scene: String?
    
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        msg_type          <- map["msg_type"]
        album_id          <- map["album_id"]
        track_id          <- map["track_id"]
        scene          <- map["scene"]
    }
    
    
}
