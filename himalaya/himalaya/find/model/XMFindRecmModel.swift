//
//  XMFindRecmModel.swift
//  himalaya
//
//  Created by Farben on 2020/9/3.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import ObjectMapper

struct XMFindRecmModel: Mappable {
    
    var emptyTip: String?
    
    var hasMore: Bool = true
    
    var pullTip: String?
    
    var endScore: Int64 = 0
    
    var startScore: Int64 = 0
    
    
    
    var streamLists: [XMFindRecmListModel]?
    
    var noticeLines: [XMFindRecmListModel]?
    
    
    
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        emptyTip          <- map["emptyTip"]
        hasMore          <- map["hasMore"]
        pullTip          <- map["pullTip"]
        streamLists          <- map["streamList"]
        endScore          <- map["endScore"]
        startScore          <- map["startScore"]
        noticeLines          <- map["lines"]
    }
    
    
}

class XMFindRecmListModel: Mappable {
    
    var type: String?
    
    var item: XMFindRecmListItemModel?
    
    var cycles: [XMFindRecmCycleModel]?
    
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        type          <- map["type"]
        item          <- map["item"]
        cycles          <- map["item"]
    }
    
}

class XMFindRecmCycleModel: Mappable {
    
    var icon: String?
    
    var logo: String?
    var memberCount: Int = 0
    
    var name: String?
    
    var attrTitle: NSAttributedString?
    
    
    
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        icon          <- map["icon"]
        logo          <- map["logo"]
        memberCount          <- map["memberCount"]
        name          <- map["name"]
    }
    
    
}

struct XMFindRecmListItemModel: Mappable {
    
    var userInfo: XMFindRecmListItemUser?
    var bizSource: String?
    var bizType: String?
    var contextModel: XMFindcommunityContextModel?
    
    var contentModel: XMFindRecmListItemContentModel?
    
    var statCount: XMFindRecmListItemStatCount?
    
    var hotComment: XMFindRecmListItemHotCommentModel?
    
    var advertiseContent: XMFindAdvertiseContentModel?
    
    var isFollowed: Bool = false
    
    
    
    var dispatchLevel: Int8 = 0
        
    var id: Int64 = 0
    
    var recReason: String?
    
    var sourceTitle: String?
    
    var createdTs: Int64 = 0
    
    var type: String?
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        userInfo          <- map["authorInfo"]
        contextModel          <- map["communityContext"]
        contentModel          <- map["content"]
        statCount          <- map["statCount"]
        bizSource          <- map["bizSource"]
        bizType          <- map["bizType"]
        id          <- map["id"]
        recReason          <- map["recReason"]
        sourceTitle          <- map["sourceTitle"]
        createdTs          <- map["createdTs"]
        dispatchLevel          <- map["dispatchLevel"]
        hotComment          <- map["hotComment"]
        type          <- map["type"]
        advertiseContent          <- map["advertiseContent"]
        isFollowed          <- map["isFollowed"]
    }
}

struct XMFindAdvertiseContentModel: Mappable {
    
    var moreUrl: String?
    var roomType: String?
    
    var rooms: [XMFindAdvertiseContentRoomModel]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        moreUrl          <- map["moreUrl"]
        roomType          <- map["roomType"]
        rooms          <- map["rooms"]
    }
    
    
}

class XMFindAdvertiseContentRoomModel: Mappable {
    
    var anchorName: String?
    var coverUrl: String?
    var roomName: String?
    var url: String?
    
    var viewerNum: Int = 0
    
    
    var titleAttr: NSAttributedString?
    var titleAttrHeight: CGFloat = 0
    
    var countAttr: NSAttributedString?
    
    
    
    
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        anchorName          <- map["anchorName"]
        coverUrl          <- map["coverUrl"]
        roomName          <- map["roomName"]
        url          <- map["url"]
        viewerNum          <- map["viewerNum"]
    }
    
    
}

struct XMFindRecmListItemHotCommentModel: Mappable {
    
    var userInfo: XMFindRecmListItemUser?
    var content: String?
    var praiseCount: Int = 0
    
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        userInfo          <- map["authorInfo"]
        content          <- map["content"]
        praiseCount          <- map["praiseCount"]
    }
    
    
}

struct XMFindRecmListItemStatCount: Mappable {
    
    var commentCount: Int = 0
    
    var feedPraiseCount: Int = 0
    
    var readCount: Int = 0
    
    var shareCount: Int = 0
    
    
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        commentCount          <- map["commentCount"]
        feedPraiseCount          <- map["feedPraiseCount"]
        readCount          <- map["readCount"]
        shareCount          <- map["shareCount"]
    }
    
    
}

struct XMFindRecmListItemContentModel: Mappable {
    
    var title: String?
    var titleAndTextBothEmpty: Bool = false
    
    var nodes: [XMFindRecmListItemContentNodeModel]?
    
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        title          <- map["title"]
        titleAndTextBothEmpty          <- map["titleAndTextBothEmpty"]
        nodes          <- map["nodes"]
    }
    
    
}

struct XMFindRecmListItemContentNodeModel: Mappable {
    
    var data: String?
    var type: String?
    
    var nodeDetail: XMFindRecmListItemContentNodeDetailModel?
    
    var pictureModels: [XMFindRecmListItemContentNodeDetailModel]?
    
    var content: String?
    
    
    
    
    
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        data          <- map["data"]
        type          <- map["type"]
        
        if let dataString = data {
            
            if type == "pic" {
                pictureModels = Mapper<XMFindRecmListItemContentNodeDetailModel>().mapArray(JSONString: dataString)
            }else {
                nodeDetail = XMFindRecmListItemContentNodeDetailModel(JSONString: dataString)
            }
            
        }
        
    }
}

struct XMFindRecmListItemContentNodeDetailVoterModel: Mappable {
    
    var content: String?
    
    var id: Int = 0
    
    var selected: Bool = false
    
    var voteCount: Int = 0
    
    
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        content          <- map["content"]
        id          <- map["id"]
        selected          <- map["selected"]
        voteCount          <- map["voteCount"]
    }
    
    
}

struct XMFindRecmListItemContentNodeDetailModel: Mappable {
    
    var color: String?
    var content: String?
    var font: Int8 = 0
    var row: Int8 = 0
    
    var height: CGFloat = 0
    var width: CGFloat = 0
    var originUrl: String?
    var thumbnailUrl: String? //没用
    var thumbnailUrlOfRowContainOne: String? //缩略图
    var thumbnailUrlOfRowContainThree: String?
    var thumbnailUrlOfRowContainTwo: String?
    
    
    var coverUrl: String?
    var duration: Int = 0
    var playCount: Int64 = 0
    var uploadId: Int64 = 0
    
    var albumId: Int64 = 0
    var albumTitle: String?
    var intro: String?
    var title: String?
    
    var score: CGFloat = 0
    
    var trackCount: Int = 0
    
    var voterCount: Int = 0
    
    var voterModels: [XMFindRecmListItemContentNodeDetailVoterModel]?
    
    
    
//    http://imagev2.xmcdn.com/group83/M01/98/51/wKg5HV9Li8PwKlb9AAWAY3QS7Fw203.jpg!op_type=0&unlimited=1
//    http://imagev2.xmcdn.com/group83/M01/98/51/wKg5HV9Li8PwKlb9AAWAY3QS7Fw203.jpg!op_type=5&upload_type=discoverFeed&device_type=ios&name=small
//    http://imagev2.xmcdn.com/group83/M01/98/51/wKg5HV9Li8PwKlb9AAWAY3QS7Fw203.jpg!op_type=3&columns=1280&unlimited=1
//    http://imagev2.xmcdn.com/group83/M01/98/51/wKg5HV9Li8PwKlb9AAWAY3QS7Fw203.jpg!op_type=3&columns=400&unlimited=1
//    http://imagev2.xmcdn.com/group83/M01/98/51/wKg5HV9Li8PwKlb9AAWAY3QS7Fw203.jpg!op_type=3&columns=600&unlimited=1
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        color          <- map["color"]
        content          <- map["content"]
        font          <- map["font"]
        row          <- map["row"]
        
        
        height          <- map["height"]
        width          <- map["width"]
        originUrl          <- map["originUrl"]
        thumbnailUrl          <- map["thumbnailUrl"]
        thumbnailUrlOfRowContainOne          <- map["thumbnailUrlOfRowContainOne"]
        thumbnailUrlOfRowContainThree          <- map["thumbnailUrlOfRowContainThree"]
        thumbnailUrlOfRowContainTwo          <- map["thumbnailUrlOfRowContainTwo"]
        
        coverUrl          <- map["coverUrl"]
        duration          <- map["duration"]
        playCount          <- map["playCount"]
        uploadId          <- map["uploadId"]
        
        albumId          <- map["albumId"]
        albumTitle          <- map["albumTitle"]
        intro          <- map["intro"]
        title          <- map["title"]
        score          <- map["score"]
        
        trackCount          <- map["trackCount"]
        voterCount          <- map["voterCount"]
        
        voterModels          <- map["options"]
    }
    
    
}

struct XMFindRecmListItemUser: Mappable {
    
    var anchorGrade: Int = 0
    
    var avatar: String?
    var dispatchLevel: Int = 0
    
    var isVerified: Bool = false
    
    var nickname: String?
    
    var uid: Int64 = 0
    
    var vLogoType: Int = 0
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        anchorGrade          <- map["anchorGrade"]
        avatar          <- map["avatar"]
        dispatchLevel          <- map["dispatchLevel"]
        isVerified          <- map["isVerified"]
        nickname          <- map["nickname"]
        uid          <- map["uid"]
        vLogoType          <- map["vLogoType"]
    }
}

struct XMFindcommunityContextModel: Mappable {
    
    
    var hasJoin: Bool = false
    
    var community: XMFindcommunityContextCommunityModel?
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        hasJoin          <- map["hasJoin"]
        community          <- map["community"]
    }
    
    
}

struct XMFindcommunityContextCommunityModel: Mappable {
    
    var articleCount: Int = 0
    
    var defaultCategoryId: Int64 = 0
    
    var defaultSectionId: Int64 = 0
    
    var id: Int = 0
    
    var intro: String?
    
    var logo: String?
    
    var memberCount: Int = 0
    
    var name: String?
    
    var type: Int8 = 0
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        articleCount          <- map["articleCount"]
        defaultCategoryId          <- map["defaultCategoryId"]
        defaultSectionId          <- map["defaultSectionId"]
        id          <- map["id"]
        intro          <- map["intro"]
        logo          <- map["logo"]
        memberCount          <- map["memberCount"]
        name          <- map["name"]
        type          <- map["type"]
    }
    
}


