//
//  XMHighQualityGoodsModel.swift
//  himalaya
//
//  Created by Farben on 2020/9/16.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import ObjectMapper
import IGListDiffKit


struct XMHighQualityGoodsModel: Mappable {
    
    
    var moduleModels: [XMHQGModulesModel]?
    
    var titleModels: [XMHQGTitleModel]?
    
    var albums: [XMHQGAlbumModel]?
    
    var offset: Int = 0
    
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        moduleModels          <- map["modules"]
        titleModels          <- map["categories"]
        albums          <- map["items"]
        offset          <- map["offset"]
        
    }
}

struct XMHQGModulesModel: Mappable {
    
    
    var items: [XMHQGModuleItemModel]?
    
    var albums: [XMHQModulesRecdAlbumModel]?
    
    var focusPicture: XMHQModulesFocusPictureModel?
    
    
    var classType: String?
    
    var moduleId: Int = 0
    
    var moduleName: String?
    
    var title: String?
    
    
    var moduleType: String?
    

    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        focusPicture          <- map["focusPicture"]
        items          <- map["items"]
        albums          <- map["recommendationAlbums"]
        classType          <- map["classType"]
        moduleId          <- map["moduleId"]
        moduleName          <- map["moduleName"]
        title          <- map["title"]
        moduleType          <- map["moduleType"]
    }
    
}


struct XMHQGAlbumModel: Mappable {
    
    var albumId: Int = 0
    var coverPath: String?
    var title: String?
    var intro: String?
    var itemType: String?
    var serialState: Int8 = 0
    var albumTitle: String?
    var playCount: Int = 0
    var playsCounts: Int64 = 0
    var tracks: Int = 0
    
    var albumData: XMHQGAlbumDataModel?
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        albumId          <- map["albumId"]
        coverPath          <- map["coverPath"]
        title          <- map["title"]
        intro          <- map["intro"]
        itemType          <- map["itemType"]
        serialState          <- map["serialState"]
        albumTitle          <- map["albumTitle"]
        playCount          <- map["playCount"]
        playsCounts          <- map["playsCounts"]
        tracks          <- map["tracks"]
        albumData          <- map["data"]
    }
}

struct XMHQGAlbumDataModel: Mappable {
    
    var cardClass: String?
    var moduleId: Int = 0
    var moduleName: String?
    var moduleType: String?
    var moreUrl: String?
    var picture: String?
    
    var title: String?
    
    

    
    
    
    
    var rankTables: [XMHQGAlbumDataRankTableModel]?
    
    var starModels: [XMHQGAlbumDataStarModel]?
    
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        cardClass          <- map["cardClass"]
        moduleId          <- map["moduleId"]
        moduleName          <- map["moduleName"]
        moduleType          <- map["moduleType"]
        moreUrl          <- map["moreUrl"]
        picture          <- map["picture"]
        rankTables          <- map["rankTables"]
        starModels          <- map["anchors"]
        title          <- map["title"]

        
    }
}

struct XMHQGAlbumDataStarModel: Mappable {
    
    var nickName: String?

    var logoPic: String?

    var introduction: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        nickName          <- map["nickName"]
        logoPic          <- map["logoPic"]
        introduction          <- map["introduction"]
    }
    
    
}

struct XMHQGAlbumDataRankTableModel: Mappable {
    
    var name: String?
    
    var ruleId: Int = 0
    
    var updateTime: String?
    
    var items: [XMHQGModuleItemModel]?
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        name          <- map["name"]
        ruleId          <- map["ruleId"]
        updateTime          <- map["updateTime"]
        items          <- map["items"]
    }
}

//extension XMHQGAlbumDataRankTableModel: ListDiffable {
//    func diffIdentifier() -> NSObjectProtocol {
//        return ruleId as NSObjectProtocol
//    }
//
//    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
//
//        guard let model = object as? XMHQGAlbumDataRankTableModel else {
//            return false
//        }
//        return ruleId == model.ruleId
//    }
//
//
//}
class XMHQGModuleItemModel: Mappable {
    
    var icon: String?
    var name: String = ""
    var url: String?
    var category: String?
    
    var changeState: Int8 = 0
    var coverPath: String?
    var id: Int = 0
    var title: String?
    
    
    
    
    
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        icon          <- map["icon"]
        name          <- map["name"]
        url          <- map["url"]
        
        changeState          <- map["changeState"]
        coverPath          <- map["coverPath"]
        id          <- map["id"]
        title          <- map["title"]
    }
}

extension XMHQGModuleItemModel: ListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        return name as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        
        guard let model = object as? XMHQGModuleItemModel else {
            return false
        }
        return name == model.name
    }
}

class XMHQModulesRecdAlbumModel: Mappable {
    
    var albumId: Int = 0
    var coverPath: String?
    var title: String?
    var titleAttr: NSAttributedString?
    var titleAttrHeight: CGFloat = 0
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        albumId          <- map["albumId"]
        coverPath          <- map["coverPath"]
        title          <- map["title"]
    }
    
    
}




struct XMHQModulesFocusPictureModel: Mappable {
    
    
    var picModels: [XMHQModulesFocusPictureDataModel]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        picModels          <- map["data"]
    }
    
    
}

struct XMHQModulesFocusPictureDataModel: Mappable {
    var adId: Int = 0
    
    var cover: String?
    
    var link: String?
    
    var realLink: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        adId          <- map["adId"]
        cover          <- map["cover"]
        link          <- map["link"]
        realLink          <- map["realLink"]
    }
}

struct XMHQGTitleModel: Mappable {
    
    var categoryId: Int8 = 0
    var categoryName: String?
    
    var titeAttr: NSAttributedString?
    var titleWidth: CGFloat = 0
    
    
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        categoryId          <- map["categoryId"]
        categoryName          <- map["categoryName"]
        
        if let name = categoryName {
            let attr = getAttring(aString: name, font: UIFont.boldSystemFont(ofSize: 14), color: UIColor.xm.dynamicRGB((50, 50, 50), (200, 200, 200)))
            titeAttr = attr
            let width = getStringWidth(aString: attr, height: 9999)
            titleWidth = width + xm_padding
        }
    }
    
    
    
}
