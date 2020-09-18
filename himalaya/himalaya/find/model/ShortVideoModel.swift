//
//  ShortVideoModel.swift
//  himalaya
//
//  Created by Farben on 2020/8/14.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import ObjectMapper

struct ShortVideoModel: Mappable {
    
    var items: [ShortVideoItemsModel]?
    var hasMore: Bool = false
    var pullTip: String?
    var emptyTip: String?
    
    var timestamp: Int64 = 0
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        items          <- map["items"]
        hasMore          <- map["hasMore"]
        pullTip          <- map["pullTip"]
        emptyTip          <- map["emptyTip"]
        timestamp          <- map["timestamp"]
    }
    
}

struct ShortVideoItemsModel: Mappable {
    
    var type: String?
    var item: ShortVideoItemModel?
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        type          <- map["type"]
        item          <- map["item"]
    }
}

struct ShortVideoItemModel: Mappable {
    
    
    var user: XMUserInfo?
//
    var contentModel: ShortVideoItemContentModel?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        user          <- map["authorInfo"]
        contentModel          <- map["content"]
    }
}

struct ShortVideoItemContentModel: Mappable {
    
    var nodes: [ShortVideoItemContentNodeModel]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        nodes          <- map["nodes"]
    }
    
    
}

struct ShortVideoItemContentNodeModel: Mappable {
    
    var type: String?
    var data: String?
    
    var contentDetailnode: ShortVideoItemContentNodeDetailModel?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        type          <- map["type"]
        data          <- map["data"]
        
        if let jsonString = data, let model = ShortVideoItemContentNodeDetailModel(JSONString: jsonString) {
            contentDetailnode = model
        }
    }
    
}

struct ShortVideoItemContentNodeDetailModel: Mappable {
    var color: String?
    
    var content: String?
    
    var font: Int = 0
    
    var coverUrl: String?
    
    var duration: Int64 = 0
    
    var height: CGFloat = 0
    
    var width: CGFloat = 0
    
    var playCount: Int = 0
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        color          <- map["color"]
        content          <- map["content"]
        font          <- map["font"]
        coverUrl          <- map["coverUrl"]
        duration          <- map["duration"]
        height          <- map["height"]
        width          <- map["width"]
        playCount          <- map["playCount"]
    }
    
    
}
