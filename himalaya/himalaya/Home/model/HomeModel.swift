//
//  HomeModel.swift
//  himalaya
//
//  Created by Farben on 2020/8/6.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import ObjectMapper
import IGListKit

class HomeModel: Mappable {
    
    var headerItem: HomeHeaderItem?
    
    var itemType: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        headerItem          <- map["item"]
        itemType          <- map["itemType"]
    }
    
    
}

class HomeHeaderItem: Mappable {
    
    
    var lists: [HomeHeaderItemData]?
    
    
    var titles: [String]? //今日热点的关键字词
    
    
    var albumId: Int64 = 0
    
    
    var moduleType: String?
    
    var greetings: String? //今日热点
    
    var greeting: String?
    
    
    var title: String? //猜你喜欢 
    
    var coverPath: String?
    var coverPathBig: String?
    var coverMiddle: String?
    
    var paidType: Int = 100
    
    
    
    var intro: String?
    
    var recInfo: HomeAlbumRecInfo?
    
    var playsCounts: Int64 = 0
    
    var albumScore: CGFloat = 0
    
    var albumTitle: String?
    
    var subtitle: String?
    
    var viewCount: Int = 0
    
    var countSet: Int = 0
    
    var vipFreeType: Bool = false
    
    var serialState: Int = 0
    
    var preferredType: Bool = false//是不是优选
    
    
    var liveName: String? //直播标题
    var nickname: String? //直播人的昵称
    var playCount: Int = 0 //直播播放次数
    
    var videoCover: String?//视频封面
    
    var videoDuration: Int = 0
    
    var iting: String?
    
    var specialId: Int = 0
    
    
   
    var unique: String = "unique"//主要用来标识的
    
    
    
    required init?(map: Map) {
            
    }
        
    func mapping(map: Map) {
        lists          <- map["list"]
        moduleType     <- map["moduleType"]
        greetings      <- map["greetings"]
        title          <- map["title"]
        coverPath      <- map["coverPath"]
        intro          <- map["intro"]
        recInfo        <- map["recInfo"]
        playsCounts    <- map["playsCounts"]
        albumScore     <- map["albumScore"]
        albumTitle     <- map["albumTitle"]
        subtitle     <- map["subtitle"]
        viewCount     <- map["viewCount"]
        countSet     <- map["count"]
        coverPathBig     <- map["coverPathBig"]
        vipFreeType     <- map["vipFreeType"]
        serialState     <- map["serialState"]
        liveName     <- map["name"]
        nickname     <- map["nickname"]
        playCount     <- map["playCount"]
        preferredType     <- map["preferredType"]
        videoCover     <- map["videoCover"]
        videoDuration     <- map["duration"]
        albumId     <- map["albumId"]
        greeting     <- map["greeting"]
        coverMiddle     <- map["coverMiddle"]
        paidType     <- map["paidType"]
        iting     <- map["iting"]
        specialId     <- map["specialId"]



    }
}

extension HomeHeaderItem: ListDiffable {

    func diffIdentifier() -> NSObjectProtocol {
        return unique as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
         guard let item = object as? HomeHeaderItem else {
            return false
        }
        return item.unique == unique
    }


}

class HomeHeaderItemData: Mappable {
    
    
    var banders: [HomeHeaderItemBander]?
    
    var tracks: [HomeHeaderItemTrack]?
    
    var track: HomeHotTrackModel?
    
    
    var recentListen: HomeRecentListenModel?
    
    
    var albumId: Int64 = 0
    var fmId: Int64 = 0
    var uid: Int64 = 0
    var channelId: Int64 = 0
    var specialId: Int64 = 0
    var roomId: Int64 = 0
    
    
    
    var url: String?
    
    
    
    var coverPath: String?
    
    var darkCoverPath: String?
    
    
    var title: String?
    
    var coverUrl: String?
    var presidentName: String?
    
    var coverMiddle: String?
    
    
    var pic: String?
    var subtitle: String?
    
    var playsCount: Int64 = 0
    
    var playCount: Int = 0
    
    
    var popularity: String?
    
    var name: String?
    
    var nickname: String?
    
    var coverPathBig: String?
    
    var attrTitle: NSAttributedString?
    var attrTitleTop: CGFloat = 10
    var attrTitleHeight: CGFloat = 0
    var attrTitleWidth: CGFloat = 0
    var imageViewHeight: CGFloat = 0
    var attrPlayerCount: NSAttributedString?
    
    
    
    var logoPic: String?
    var personDescribe: String?
    
    //关键词宽度
    var itemWidth: CGFloat = 0
    
    
    var hotNum: Int = 0
    var categoryName: String?
    
    var isFinished: Int8 = 0// 是否完结1 未完结, 2已经完结
    
    
    var preferredType: Int = 0//是不是优选
    var isPaid: Bool = false //是不是需要vip
    var topImageName: String? //图片上面的角标,优选,vip什么的

    var colorTule: (CGFloat, CGFloat, CGFloat)?
    
    var picIsWebp: Bool = false
    
    
    
//    "logoPic": "http://imagev2.xmcdn.com/group52/M06/DA/6A/wKgLe1wKPqzBi8_BAACU6kcIaNA868.jpg!op_type=3&columns=190&rows=190",
//               "materialType": "anchor",
//               "nickname": "喜马音乐小编",
//               "personDescribe": "音乐频道月度优质主播",
//
    
    
    var word: String?
    var workRank: NSAttributedString?
    var isShowSearchHotLayer: Bool = false

    required init?(map: Map) {
            
    }
        
    func mapping(map: Map) {
        banders          <- map["data"]
        coverPath          <- map["coverPath"]
        title          <- map["title"]
        tracks          <- map["tracks"]
        pic          <- map["pic"]
        subtitle          <- map["subtitle"]
        playsCount          <- map["playsCount"]
        word          <- map["word"]
        popularity          <- map["popularity"]
        coverUrl          <- map["coverUrl"]
        presidentName          <- map["presidentName"]
        coverMiddle          <- map["coverMiddle"]
        name          <- map["name"]
        nickname          <- map["nickname"]
        coverPathBig          <- map["coverPathBig"]
        logoPic          <- map["logoPic"]
        personDescribe          <- map["personDescribe"]
        albumId          <- map["albumId"]
        fmId          <- map["fmId"]
        uid          <- map["uid"]
        channelId          <- map["channelId"]
        specialId          <- map["specialId"]
        roomId          <- map["roomId"]
        recentListen          <- map["album"]
        track          <- map["track"]
        url          <- map["url"]
        hotNum          <- map["hotNum"]
        categoryName          <- map["categoryName"]
        
        preferredType          <- map["preferredType"]
        isPaid          <- map["isPaid"]
        playCount          <- map["playCount"]
        darkCoverPath          <- map["darkCoverPath"]
        
    }
}

extension HomeHeaderItemData: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return albumId as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        
        guard let item = object as? HomeHeaderItemData else {
            return false
        }
        
        return item.albumId == albumId
    }
    
    
}

struct HomeHotTrackModel: Mappable {
    
    var albumId: Int64 = 0
    
    var title: String?
    
    var trackId: Int64 = 0
    
    var playPath32: String?
    
    var playPath64: String?
    
    var playPathAacv164: String?
    
    var playPathAacv224: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        albumId          <- map["albumId"]
        title          <- map["title"]
        trackId          <- map["trackId"]
        playPath32          <- map["playPath32"]
        playPath64          <- map["playPath64"]
        playPathAacv164          <- map["playPathAacv164"]
        playPathAacv224          <- map["playPathAacv224"]
    }
    
    
}

struct HomeRecentListenModel: Mappable {
    
    
    var title: String?
    var lastUptrackTitle: String?
    var coverPath: String?
    
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        title          <- map["title"]
        lastUptrackTitle          <- map["lastUptrackTitle"]
        coverPath          <- map["coverPath"]
    }
    
    
}


class HomeHeaderItemBander: Mappable {
    
    
//    var dicArray: Any?
    var cover: String?
    var realLink: String?
    
    var isWebVc: Bool = false
    
    
    var linkParam: XMLinkParam?
    
    
    
    init() {
        
    }
    required init?(map: Map) {
            
    }
        
    func mapping(map: Map) {
        cover          <- map["cover"]
        realLink       <- map["realLink"]
        
    }
}

struct HomeHeaderItemTrack: Mappable {
    
    var albumTitle: String?
    var coverSmall: String?
    var nickname: String?
    var title: String?
    var playPath32: String?
    var playPath64: String?
    var playPathAacv164: String?
    var playPathAacv224: String?
       
    init() {
           
    }
    init?(map: Map) {
               
    }
           
    mutating func mapping(map: Map) {
        albumTitle               <- map["albumTitle"]
        coverSmall               <- map["coverSmall"]
        nickname                 <- map["nickname"]
        title                    <- map["title"]
        playPath32               <- map["playPath32"]
        playPath64               <- map["playPath64"]
        playPathAacv164          <- map["playPathAacv164"]
        playPathAacv224          <- map["playPathAacv224"]
    }
}


struct HomeAlbumRecInfo: Mappable {
    init?(map: Map) {
        
    }
    
    var recReason: String?
    
    var recReasonType: String?
    
    var recSrc: String?
    
    var recTrack: String?
    
    
    
    
    
//    "recInfo": {
//                   "recReason": "NO.9 头条 口碑榜",
//                   "recReasonType": "RECSYS",
//                   "recSrc": "ABM_ABMULAR.DeepFM~231V5.CV",
//                   "recTrack": "FD.AMRB.1241.itfreq"
//               },
    mutating func mapping(map: Map) {
        recReason          <- map["recReason"]
        recReasonType          <- map["recReasonType"]
        recSrc          <- map["recSrc"]
        recTrack          <- map["recTrack"]
    }
    
    
}
