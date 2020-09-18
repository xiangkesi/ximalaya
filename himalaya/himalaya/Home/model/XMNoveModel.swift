//
//  XMNoveModel.swift
//  himalaya
//
//  Created by Farben on 2020/8/26.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import ObjectMapper
import IGListKit

struct XMNoveFocusImageModel: Mappable {
    
    var focusImageDatas: [XMNoveFocusImageDataModel]?
    
    var responseId: Int64 = 0
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        focusImageDatas          <- map["data"]
        responseId          <- map["responseId"]
    }
}

struct XMNoveFocusImageDataModel: Mappable {
    
    var cover: String?
    
    var link: String?
    
    var realLink: String?
    
    var adId: Int64 = 0
    
    
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        cover          <- map["cover"]
        link          <- map["link"]
        realLink          <- map["realLink"]
        adId          <- map["adId"]
    }
}


/// 暂时不知道啥用
struct XMNoveKeywordModel: Mappable {
    
    var categoryId: Int = 0
    
    var keywordId: Int = 0
    
    var keywordName: String?
    
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        categoryId          <- map["categoryId"]
        keywordId          <- map["keywordId"]
        keywordName          <- map["keywordName"]
    }
    
}

struct XMNoveCategoryContentModel: Mappable {
    
    var lists:[XMNoveCategoryContentListModel]?
    var title: String?
   
    
    
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        lists          <- map["list"]
        title          <- map["title"]
        
    }
    
    
}

struct XMNoveCategoryContentListModel: Mappable {
    
    var lists: [XMNoveCategoryContentList_listModel]?
    var title: String?
    var subtitle: String?
    
    var contentType: String?
    var moduleType: Int = 0
    var hasMore: Bool = false
    var keywordId: Int64 = 0
    var loopCount: Int = 0
    var specialId: Int = 0
    var categoryId: Int = 0
    
    var displayType: Int = 0
    var offset: Int = 0
    
    
    
    
    
    
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        lists          <- map["list"]
        contentType          <- map["contentType"]
        moduleType          <- map["moduleType"]
        hasMore          <- map["hasMore"]
        title          <- map["title"]
        keywordId          <- map["keywordId"]
        loopCount          <- map["loopCount"]
        specialId          <- map["specialId"]
        subtitle          <- map["subtitle"]
        categoryId          <- map["categoryId"]
        displayType          <- map["displayType"]
        offset          <- map["offset"]
    }
    
    
}

class XMNoveCategoryContentList_listModel: Mappable {
    
    var title: String?
    
    var id: Int64 = 0
    
    var coverMiddle: String?
    var coverPath: String?
    var coverPathBig: String?
    var coverSmall: String?
    
    
    
    var nickname: String?
    var name: String?
    
    var titleAttr: NSAttributedString?
    var titleAttrHeight: CGFloat = 0
    
    var albums: [XMNoveCategoryContentListAlbumFilmModel]?
    
    var sleepNights: [XMNoveCategoryContentListAlbumFilmModel]?
    
    var smallLogo: String?
    
    var itemType: String?
    
    var album: XMNoveAlbumItemModel?
    
    var subtitle: String?
    
    var nanNvLoveModels: [XMHomeNoveNanNvLoveModel]?
    
    var rankingListId: Int = 0
    
    
    
    
    init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        title          <- map["title"]
        id          <- map["id"]
        coverMiddle          <- map["coverMiddle"]
        albums          <- map["albums"]
        smallLogo          <- map["smallLogo"]
        coverPath          <- map["coverPath"]
        nickname          <- map["nickname"]
        name          <- map["name"]
        coverPathBig          <- map["coverPathBig"]
        sleepNights          <- map["list"]
        itemType          <- map["itemType"]
        album          <- map["item"]
        coverSmall          <- map["coverSmall"]
        subtitle          <- map["subtitle"]
        nanNvLoveModels          <- map["list"]
        rankingListId          <- map["rankingListId"]
    }
}

extension XMNoveCategoryContentList_listModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return rankingListId as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let content = object as? XMNoveCategoryContentList_listModel else {
            return false
        }
        return rankingListId == content.rankingListId
    }
}

class XMHomeNoveNanNvLoveModel: Mappable {
    
    var coverSmall: String?
    var title: String?
    var intro: String?
    var playsCounts: Int64 = 0
    
    var topAttr: NSAttributedString?
    var bottomAttr: NSAttributedString?
    
    
    
    
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        coverSmall          <- map["coverSmall"]
        title          <- map["title"]
        intro          <- map["intro"]
        playsCounts          <- map["playsCounts"]
    }
    
    
    
}

struct XMNoveAlbumItemModel: Mappable {
    
    var albumId: Int64 = 0
    
    var coverPath: String?
    
    var intro: String?
    
    var nickname: String?
    
    var title: String?
    
    var playsCounts: Int64 = 0
    
    var albumScore: CGFloat = 0
    
    var serialState: Int = 0
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        albumId          <- map["albumId"]
        coverPath          <- map["coverPath"]
        intro          <- map["intro"]
        nickname          <- map["nickname"]
        title          <- map["title"]
        playsCounts          <- map["playsCounts"]
        albumScore          <- map["albumScore"]
        serialState          <- map["serialState"]
    }
    
    
}


class XMNoveCategoryContentListAlbumFilmModel: Mappable {
    
    var albumCoverUrl290: String?
    var title: String?
    
    var titleAttr: NSAttributedString?
    var titleHeight: CGFloat = 0
    
    var model: XMNoveCategoryContentListAlbumFilmPicModel?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        albumCoverUrl290          <- map["albumCoverUrl290"]
        title          <- map["title"]
        model          <- map["origin"]
    }
    
    
    
}

struct XMNoveCategoryContentListAlbumFilmPicModel: Mappable {
    
    var albumCoverUrl290: String?
    var title: String?
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        albumCoverUrl290          <- map["albumCoverUrl290"]
        title          <- map["title"]
    }
    
    
}
