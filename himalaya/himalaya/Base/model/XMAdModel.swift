//
//  XMAdModel.swift
//  himalaya
//
//  Created by Farben on 2020/8/10.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import ObjectMapper

struct XMAdModel: Mappable{
    
    var realLink: String?
    var name: String?
    var description: String?
    var cover: String?
    var videoCover: String?
    
    var videoUrls: [String]?
    
    var adId: Int64 = 0
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        realLink          <- map["realLink"]
        name          <- map["name"]
        description          <- map["description"]
        cover          <- map["cover"]
        videoCover          <- map["videoCover"]
        videoUrls          <- map["videoUrls"]
        adId          <- map["adId"]
        
    }
    
    
    
}
