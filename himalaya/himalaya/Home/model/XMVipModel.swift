//
//  XMVipModel.swift
//  himalaya
//
//  Created by Farben on 2020/8/18.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import ObjectMapper
import IGListKit

struct XMVipModel: Mappable {
    
    var nickName: String?
    var vipStatus: Int = 0
    var lifeStatus: Int = 0
    var channelLifeStatus: Int = 0
    
    var modules: [XMVipModuleModel]?
    
    var categorieWords: [XMVipCategorieWordModel]?
    
    var albumItems: [XMVipBodyAlbumListModel]?
    
    var offset: Int = 0
    
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        nickName          <- map["nickName"]
        vipStatus          <- map["vipStatus"]
        lifeStatus          <- map["lifeStatus"]
        channelLifeStatus          <- map["channelLifeStatus"]
        modules          <- map["modules"]
        categorieWords          <- map["categories"]
        albumItems          <- map["items"]
        offset          <- map["offset"]
    }
    
}
class XMVipCategorieWordModel: Mappable {
    
    var categoryId: Int = 0
    var categoryName: String?
    
    var titleWidth: CGFloat = 0
    var titleAttr: NSAttributedString?
    
    var currentLayous: [XMVipAlbumLayout]?
    
        
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        categoryId          <- map["categoryId"]
        categoryName          <- map["categoryName"]
    }
    
    
}

extension XMVipCategorieWordModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return categoryId as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let word = object as? XMVipCategorieWordModel else {
            return false
        }
        return word.categoryId == categoryId
    }
    
    
}

class XMVipModuleModel: Mappable {
    
    var moduleType: String?
    
    var squareType: String?
    
    
    var moduleId: Int = 0
    
    var moduleName: String?
    
    var nickName: String?
    
    var logoPic: String?
    
    var levelUrl: String?
    
    var propertieModel: XMVipPropertieModel?
    
    var lists: [XMVipModuleListModel]?
    
    var recordLists: [XMVipRecordListModel]?
    
    var albums: [XMVipAlbumModel]?
    
    var focusImageModel: XMVipFocusImageModel?
        
    init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        moduleType          <- map["moduleType"]
        squareType          <- map["squareType"]
        moduleId          <- map["moduleId"]
        moduleName          <- map["moduleName"]
        nickName          <- map["nickName"]
        logoPic          <- map["logoPic"]
        levelUrl          <- map["levelUrl"]
        propertieModel          <- map["properties"]
        lists          <- map["list"]
        recordLists          <- map["records"]
        albums          <- map["albums"]
        focusImageModel          <- map["focusImages"]
    }
    
    
}

struct XMVipFocusImageModel: Mappable {
    
    var focusImages: [XMVipFocusImageDataModel]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        focusImages          <- map["data"]
    }
    
    
}

class XMVipFocusImageDataModel: Mappable {
    
    var cover: String?
    
    var link: String?
    
    var adId: Int64 = 0
    
    var realLink: String?
    
    var isWebVc: Bool = false
    
    
    var linkParam: XMLinkParam?
    
    
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        cover          <- map["cover"]
        link          <- map["link"]
        adId          <- map["adId"]
        realLink          <- map["realLink"]
    }
    
    
}

class XMVipAlbumModel: Mappable {
    var albumId: Int64 = 0
    
    var coverPath: String?
    
    var title: String?
    
    var titleAttr: NSAttributedString?
    var titleAttrHeight: CGFloat = 0
    var titleAttrWidth: CGFloat = 0
    var imageViewSize: CGSize = CGSize.zero
    
    
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        albumId          <- map["albumId"]
        coverPath          <- map["coverPath"]
        title          <- map["title"]
    }
    
    
}

extension XMVipAlbumModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return albumId as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let album = object as? XMVipAlbumModel else {
            return false
        }
        return album.albumId == albumId
    }
    
    
}

class XMVipModuleListModel: Mappable {
    
    var title: String = ""
    
    var icon: String?
    
    var type: Int = 0
    
    var value: String?
    
    var iconForNight: String?
    
    var name: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        title          <- map["title"]
        icon          <- map["icon"]
        type          <- map["type"]
        value          <- map["value"]
        iconForNight          <- map["iconForNight"]
        name          <- map["name"]
    }
}

extension XMVipModuleListModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return title as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let list = object as? XMVipModuleListModel else {
            return false
        }
        return list.title == title
    }
    
    
}

class XMVipRecordListModel: Mappable {
    
    var albumCoverPath: String?
    
    var trackTitle: String?
    
    var albumTitle: String?
    
    var albumId: Int64 = 0
    
    var finished: Int = 0
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        albumCoverPath          <- map["albumCoverPath"]
        trackTitle          <- map["trackTitle"]
        albumTitle          <- map["albumTitle"]
        albumId          <- map["albumId"]
        finished          <- map["finished"]
    }
}

extension XMVipRecordListModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        albumId as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let list = object as? XMVipRecordListModel else {
            return false
        }
        return list.albumId == albumId
    }
    
    
}

struct XMVipPropertieModel: Mappable {
    var greetText: String?
    
    var guideText: String?
    
    var buttonText: String?
    
    var rightDetailsText: String?
    
    
    
    
    var entrances: [XMVipEntranceModel]?
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        greetText          <- map["greetText"]
        guideText          <- map["guideText"]
        buttonText          <- map["buttonText"]
        entrances          <- map["entrances"]
        rightDetailsText          <- map["rightDetailsText"]
    }
    
    
}
//entrances
struct XMVipEntranceModel: Mappable {
    
    var icon: String?
    
    var title: String?
    
    var url: String?
    
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        icon          <- map["icon"]
        title          <- map["title"]
        url          <- map["url"]
    }
    
    
}


class XMVipBodyAlbumListModel: Mappable {
    
    var itemType: String?
    
    var albumId: String?
    
    var title: String?
    
    var coverPath: String?
    
    var intro: String?
    
    var isVipFree: Bool = false
    
    var tracks: Int = 0
    
    var playsCounts: Int64 = 0
    var playCount: Int64 = 0
    
    
    var albumTitle: String?
    
    
    var vipFreeType: Int = 0
    
    var serialState: Int = 0
    
    var adModel: XMVipBodyAlbumListAdModel?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        itemType          <- map["itemType"]
        albumId          <- map["albumId"]
        title          <- map["title"]
        coverPath          <- map["coverPath"]
        intro          <- map["intro"]
        isVipFree          <- map["isVipFree"]
        tracks          <- map["tracks"]
        playsCounts          <- map["playsCounts"]
        vipFreeType          <- map["vipFreeType"]
        serialState          <- map["serialState"]
        adModel          <- map["data"]
        albumTitle          <- map["albumTitle"]
        playCount          <- map["playCount"]
    }
    
    
}

struct XMVipBodyAlbumListAdModel: Mappable {
    
    var moduleType: String?
    
    var moduleId: Int64 = 0
    
    var moduleName: String?
    
    var propertieModel: XMVipBodyAlbumListAdPropertiesModel?
    
    var interestModuleModel: XMVipInterestModuleModel?
    
    var hotWordModuleModel: XMVipInterestModuleModel?
    
    var albums: [XMVipAlbumModel]?
    
    var rankTables: [XMVipModuleRankTableModel]?
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        moduleType          <- map["moduleType"]
        moduleId          <- map["moduleId"]
        moduleName          <- map["moduleName"]
        propertieModel          <- map["properties"]
        interestModuleModel          <- map["interestModule"]
        hotWordModuleModel          <- map["hotWordModule"]
        albums          <- map["albums"]
        rankTables          <- map["rankTables"]
    }
}

class XMVipModuleRankTableModel: Mappable {
    
    var name: String?
    var updateTime: String?
    var items: [XMVipModuleRankTableItemsModel]?
    
    var ruleId: Int = 0
    
    var imageName: String?
    
    
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        name          <- map["name"]
        updateTime          <- map["updateTime"]
        items          <- map["items"]
        ruleId          <- map["ruleId"]
        
    }
}



struct XMVipModuleRankTableItemsModel: Mappable {
    
    var id: Int64 = 0
    var category: String?
    
    var coverPath: String?
    
    var title: String?
    var changeState: Int = 0
    
    
    
    
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id          <- map["id"]
        category          <- map["category"]
        coverPath          <- map["coverPath"]
        title          <- map["title"]
        changeState          <- map["changeState"]
    }
    
    
}

struct XMVipBodyAlbumListAdPropertiesModel: Mappable {
    
    
    var title: String?
    
    var subTitle: String?
    
    
    var cardClass: String?
    
    var moreUrl: String?
    
    var aggregatePictures: String?
    
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        cardClass          <- map["cardClass"]
        moreUrl          <- map["moreUrl"]
        aggregatePictures          <- map["aggregatePictures"]
        title          <- map["title"]
        subTitle          <- map["subTitle"]
    }
    
    
}

struct XMVipInterestModuleModel: Mappable {
    
    var moduleTitle: String?
    var moduleId: Int = 0
    
    var interestModuleDetailModel: [XMVipInterestModuleDetailModel]?
    var hotWordModuleModels: [XMVipInterestModuleDetailModel]?
    
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        moduleTitle          <- map["moduleTitle"]
        moduleId          <- map["moduleId"]
        interestModuleDetailModel          <- map["categories"]
        hotWordModuleModels          <- map["hotWords"]
    }
    
    
}

struct XMVipInterestModuleDetailModel: Mappable {
    
    var categoryId: Int = 0
    
    var categoryType: String?
    
    var name: String?
    
    var url: String?
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        categoryId          <- map["categoryId"]
        categoryType          <- map["categoryType"]
        name          <- map["name"]
        url          <- map["url"]
    }
    
    
}
