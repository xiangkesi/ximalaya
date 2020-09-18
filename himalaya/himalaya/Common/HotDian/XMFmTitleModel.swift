//
//  XMFmModel.swift
//  himalaya
//
//  Created by cocoazhang on 2020/9/11.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import ObjectMapper
import IGListKit

struct XMFmModel: Mappable {
    
    var titleModels: [XMFmTitleModel]?
//    XMFmDetailListModel
    
    var listModels: [XMFmDetailListModel]?
    
    var channelName: String?
    
    var detailInfoModels: [XMDetailTtemInfoModel]?
    
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        titleModels          <- map["channelInfos"]
        listModels          <- map["list"]
        channelName          <- map["channelName"]
        detailInfoModels          <- map["itemInfos"]
    }
}

struct XMDetailTtemInfoModel: Mappable {
    
    
    var detailModel: XMFmDetailListModel?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        detailModel          <- map["trackResult"]
    }
    
    
}

class XMFmTitleModel: Mappable {
    
    var index: Int = 0
    
    var channelName: String?
    
    var driveColor: String?
    
    var bgPic: String?
    
    var cover: String?
        
    var title: String?
    
    var albumId: Int = 0
    
    var channelId: Int = 0
    
    var currentTrack: XMFmDetailListModel?
    
    var nextTrack: XMFmDetailListModel?
    
    private var currentPlayIndex: Int = 0
    
    
    func nextPlayer() {
        
        if index == 0 {
            guard let lists = listModels, lists.count > 0 else {
                return
            }
            nextTrack = lists[currentPlayIndex]
            currentTrack = nextTrack
            currentPlayIndex += 1
            if currentPlayIndex > lists.count - 1 {
                currentPlayIndex = 0
            }
            nextTrack = lists[currentPlayIndex]
        }else {
            guard let lists = listInfoModels, lists.count > 0 else {
                return
            }
            nextTrack = lists[currentPlayIndex].detailModel
            currentTrack = nextTrack
            currentPlayIndex += 1
            if currentPlayIndex > lists.count - 1 {
                currentPlayIndex = 0
            }
            nextTrack = lists[currentPlayIndex].detailModel
        }
        
    }
    
    
    var listModels: [XMFmDetailListModel]? {
        didSet {
            nextPlayer()
        }
    }
    
    var listInfoModels: [XMDetailTtemInfoModel]? {
        didSet {
            nextPlayer()
        }
    }
    
    
    
        
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        channelName          <- map["channelName"]
        driveColor          <- map["driveColor"]
        bgPic          <- map["bgPic"]
        title          <- map["title"]
        albumId          <- map["albumId"]
        channelId          <- map["channelId"]
        cover          <- map["cover"]
    }
}

extension XMFmTitleModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return channelId as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let model = object as? XMFmTitleModel else {
            return false
        }
        return channelId == model.channelId
    }
}

struct XMFmDetailListModel: Mappable {
    
    var trackId: Int = 0
    
    var title: String?
    
    var playPathAacv224: String?
    
    var playPathAacv164: String?
    
    
    var attrTitle: NSAttributedString?
    
    var nextTitle: String?
    
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        trackId          <- map["trackId"]
        title          <- map["title"]
        playPathAacv224          <- map["playPathAacv224"]
        playPathAacv164          <- map["playPathAacv164"]
        
        if let title_attr = title {
            attrTitle = getAttring(aString: title_attr, font: UIFont.boldSystemFont(ofSize: 20), color: UIColor.white, lineSpace: 5)
            nextTitle = "即将播放: " + title_attr
        }
        
        
    }
    
    
}

struct XMFmCurrentTrackModel: Mappable {
    
    var albumTitle: String?
    
    var categoryName: String?
    
    var playPathAacv164: String?
    
    var playPathAacv224: String?
    
    var playUrl32: String?
    
    var playUrl64: String?
    
    var title: String?
    
    var trackId: Int = 0
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        albumTitle          <- map["albumTitle"]
        categoryName          <- map["categoryName"]
        playPathAacv164          <- map["playPathAacv164"]
        playPathAacv224          <- map["playPathAacv224"]
        playUrl32          <- map["playUrl32"]
        playUrl64          <- map["playUrl64"]
        title          <- map["title"]
        trackId          <- map["trackId"]
    }
    
    
}
