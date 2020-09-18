//
//  XMLiveModel.swift
//  himalaya
//
//  Created by Farben on 2020/9/1.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import ObjectMapper

struct XMLiveModel: Mappable {
    
    var categoryVoLists: [XMLiveCategoryVoListModel]?
    var hotModule: XMLiveHotModuleModel?
    var lives: [XMLiveHotModuleHallModel]?
    
    var pageSize: Int = 0
    var pageId: Int = 0
    var lastPage: Bool = false
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        categoryVoLists          <- map["categoryVoList"]
        hotModule          <- map["hotModule"]
        pageSize          <- map["pageSize"]
        pageId          <- map["pageId"]
        lives          <- map["lives"]
        lastPage          <- map["lastPage"]
    }
}

struct XMLiveFocusImageModel: Mappable {
    
    var realLink: String?
    
    var cover: String?
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        realLink          <- map["realLink"]
        cover          <- map["cover"]
    }
}

struct XMLiveRankDataModel: Mappable {
    
    var hpRankRollMillisecond: Int64 = 0
    var rankSection: [XMLiveRankModel]?
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        hpRankRollMillisecond          <- map["hpRankRollMillisecond"]
        rankSection          <- map["multidimensionalRankVos"]
    }
    
    
}

struct XMLiveRankModel: Mappable {
    
    var dimensionName: String?
    var htmlUrl: String?
    
    var ranks: [XMLiveRankUserMsgModel]?
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        dimensionName          <- map["dimensionName"]
        htmlUrl          <- map["htmlUrl"]
        ranks          <- map["ranks"]
    }
}

struct XMLiveRankUserMsgModel: Mappable {
    var coverSmall: String?
    var nickname: String?
    var uid: String?
    
    
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        coverSmall          <- map["coverSmall"]
        nickname          <- map["nickname"]
        uid          <- map["uid"]
    }
    
    
}

class XMLiveCategoryVoListModel: Mappable {
    
    var darkFirstIcon: String?
    var darkSecondIcon: String?
    var firstIcon: String?
    var secondIcon: String?
    var name: String?
    var id: Int = 0
    var isSelected: Bool = false
    var isHiddenLineRight: Bool = false
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        darkFirstIcon          <- map["darkFirstIcon"]
        darkSecondIcon          <- map["darkSecondIcon"]
        firstIcon          <- map["firstIcon"]
        secondIcon          <- map["secondIcon"]
        name          <- map["name"]
        id          <- map["id"]
    }
    
    
}

struct XMLiveHotModuleModel: Mappable {
    
    var cardName: String?
    
    var halls: [XMLiveHotModuleHallModel]?
    
    var rankListPosition: Int = 0
    var cardRecommendPosition: Int = 0
    var bannerPosition: Int = 0
    
    
    
    
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        cardName          <- map["cardName"]
        halls          <- map["halls"]
        rankListPosition          <- map["rankListPosition"]
        cardRecommendPosition          <- map["cardRecommendPosition"]
        bannerPosition          <- map["bannerPosition"]
        
        
    }
    
}

struct XMLiveHotModuleHallModel: Mappable {
    
    var avatar: String?
    
    var categoryName: String?
    
    var coverSmall: String?
    
    var coverPath: String?
    
    var coverMiddle: String?
    
    var nickname: String?
    
    var name: String?
    
    var itingUrl: String?
    
    var presideId: Int64 = 0
    var roomId: Int64 = 0
    var id: Int64 = 0
    
    var categoryId: Int = 0
    var onlineCnt: Int = 0
    
    
    
    
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        avatar          <- map["avatar"]
        categoryName          <- map["categoryName"]
        coverSmall          <- map["coverSmall"]
        coverPath          <- map["coverPath"]
        coverMiddle          <- map["coverMiddle"]
        nickname          <- map["nickname"]
        name          <- map["name"]
        itingUrl          <- map["itingUrl"]
        presideId          <- map["presideId"]
        roomId          <- map["roomId"]
        id          <- map["id"]
        categoryId          <- map["categoryId"]
        onlineCnt          <- map["onlineCnt"]
    }
    
    
}
