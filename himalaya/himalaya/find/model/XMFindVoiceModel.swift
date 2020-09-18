//
//  ActiveModel.swift
//  himalaya
//
//  Created by Farben on 2020/8/4.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import ObjectMapper
import IGListKit

class XMFindVoiceModel: Mappable {
    
    var dubItemType: String?
    var item: XMFindVoiceItemModel?
     var title: String?
    required init?(map: Map) {
        
    }

    func mapping(map: Map) {
        dubItemType          <- map["dubItemType"]
        item                 <- map["item"]
        title                 <- map["title"]
    }
    
}

class XMFindVoiceItemModel: Mappable {
    
    var dubbingItem: XMFindVoiceDubbingItemModel?
    var contents: [XMFindVoiceContentModel]?
    var type: String?
    
    
    
    required init?(map: Map) {
           
    }
       
    func mapping(map: Map) {
        dubbingItem                 <- map["dubbingItem"]
        contents                 <- map["content"]
        type                 <- map["type"]
        
        
    }
}


class XMFindVoiceContentModel: Mappable {
    
    var coverPath: String?
    var contentId: Int64 = 0
    var name: String?
    var contentAttr: NSAttributedString?
    var contentAttrHeight: CGFloat = 0
    var uid: Int64 = 0
    
    var favorites: Int = 0
    var nickname: String?
    var logoPic: String?
    
    var productModels: [XMFindVoiceContentClassicProductModel]?
    
    
    required init?(map: Map) {
           
    }
       
    func mapping(map: Map) {
        coverPath                 <- map["coverPath"]
        contentId                 <- map["id"]
        name                 <- map["name"]
        uid                 <- map["uid"]
        
        favorites                 <- map["favorites"]
        nickname                 <- map["nickname"]
        logoPic                 <- map["logoPic"]
        
        productModels                 <- map["classicProducts"]
    }
}



extension XMFindVoiceContentModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return contentId as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let item = object as? XMFindVoiceContentModel else {
            return false
        }
        return item.contentId == contentId
    }
    
    
}

struct XMFindVoiceContentClassicProductModel: Mappable {
    
    var coverSmall: String?
    var nickname: String?
    var playTimes: Int = 0
    var title: String?
    
    
    
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        coverSmall                 <- map["coverSmall"]
        nickname                 <- map["nickname"]
        playTimes                 <- map["playTimes"]
        title                 <- map["title"]
    }
    
    
    
}

struct XMFindVoiceDubbingItemModel: Mappable {
    
    var coverPath: String?
    var coverSmall: String?
    
    var title: String?
    var nickname: String?
    var trackTotalCount: Int64 = 0
    var duration: Int64 = 0
    var playTimes: Int64 = 0
    var mediaType: String?
    var feedId: Int64 = 0
    var logoPic: String?
    
    var topicTitle: String?
    var topicId: Int = 0
    
    
    
    
    
    
    
    
    init?(map: Map) {
           
    }
       
    mutating func mapping(map: Map) {
        coverPath                 <- map["coverPath"]
        coverSmall                 <- map["coverSmall"]
        title                 <- map["title"]
        nickname                 <- map["nickname"]
        trackTotalCount                 <- map["trackTotalCount"]
        duration                 <- map["duration"]
        playTimes                 <- map["playTimes"]
        mediaType                 <- map["mediaType"]
        feedId                 <- map["feedId"]
        logoPic                 <- map["logoPic"]
        topicTitle                 <- map["topicTitle"]
        topicId                 <- map["topicId"]
    }
}
