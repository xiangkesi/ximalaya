//
//  XMMeTingTitleModel.swift
//  himalaya
//
//  Created by Farben on 2020/9/18.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import ObjectMapper

struct XMMeTingTitleModel: Mappable {
    
    var coverPath: String?
    
    var title: String?
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        coverPath          <- map["coverPath"]
        title          <- map["title"]
    }
    
}

struct XMItingDataModel: Mappable {
    
    var hasMore: Bool = true
    
    var totalSize: Int = 0
//    albumResults
    var resultModels: [XMItingAlbumResultModel]?
    
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        hasMore          <- map["hasMore"]
        totalSize          <- map["totalSize"]
        resultModels          <- map["albumResults"]
    }
    
    
}

struct XMItingAlbumResultModel: Mappable {
    
    var albumCover: String?
    
    var albumId: Int = 0
    
    var albumTitle: String?
    
    var trackTitle: String?
    
    var lastUpdateAt: Int64 = 0
    
    var unreadNum: Int = 0
    
    var timeStr: String?
    

    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        albumCover          <- map["albumCover"]
        albumId          <- map["albumId"]
        albumTitle          <- map["albumTitle"]
        trackTitle          <- map["trackTitle"]
        lastUpdateAt          <- map["lastUpdateAt"]
        unreadNum          <- map["unreadNum"]
        
        timeStr = Const.updateTimeToCurrennTime(timeStamp: lastUpdateAt)
        
        
    }
    
    
}
