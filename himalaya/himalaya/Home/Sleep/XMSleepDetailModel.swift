//
//  XMSleepDetailModel.swift
//  himalaya
//
//  Created by Farben on 2020/9/14.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import ObjectMapper
import IGListKit

class XMSleepDetailModel: Mappable {
    
    
    var detailData: XMSleepDetailDataModel?
    
    var position: Int16 = 0
    
    var sectionId: Int16 = 0
    
    var sectionType: Int16 = 0
    
    var sectionTitle: String?
    var sectionTitleAttr: NSAttributedString?
    var sectionTitleWidth: CGFloat = 0
    
    var cellHeight: CGFloat = 0
    
    
    
    
    
    
    var uniqueId: Int16 = 0
    
    init(_ id: Int16) {
        uniqueId = id
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        detailData          <- map["data"]
        position          <- map["position"]
        sectionId          <- map["sectionId"]
        sectionType          <- map["sectionType"]
        sectionTitle          <- map["sectionTitle"]
        uniqueId = sectionId + position
        
        if sectionId == 17 {
            cellHeight = ceil((content_view_width - 30) * 0.3)
        }else {
            cellHeight = 140
        }
    
        if let title = sectionTitle {
            var imageIcon: UIImage?
            imageIcon = sectionId == 17 ? UIImage(named: "xm_sleep_diy") : UIImage(named: "xm_sleep_moon")
            let attr = NSMutableAttributedString(string: "   ")
            if let imageAttr = NSAttributedString.addImage(imageIcon, -2, CGSize(width: 0, height: 0)) {
                attr.append(imageAttr)
                attr.addString(aString: " ")
            }
            let a = getAttring(aString: title, font: UIFont.boldSystemFont(ofSize: 15), color: UIColor.white)
            attr.append(a)
            sectionTitleAttr = attr
            sectionTitleWidth = getStringWidth(aString: sectionTitleAttr!, height: 50) + 10
        }
    }
    
}

extension XMSleepDetailModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return uniqueId as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let model = object as? XMSleepDetailModel else {
            return false
        }
        return uniqueId == model.uniqueId
    }
    
    
}

struct XMSleepDetailDataModel: Mappable {
    
    init?(map: Map) {
        
    }
    
    var listModels: [XMSleepDetailDataListModel]?
    
    mutating func mapping(map: Map) {
        listModels          <- map["list"]
    }
}

class XMSleepDetailDataListModel: Mappable {
    
    var cover: String?
    
    var playCounts: Int64 = 0
    
    var customTitle: String?
    
    var albumId: Int = 0
    
    var cardCover: String?
    var title: String?
    var attrTitle: NSAttributedString?
    var attrWidth: CGFloat = 0
    var id: Int = 0
    var position: Int = 0
    
    var top3TrackTitle: [String]?
    var top3TrackTitleStr: String = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        cover          <- map["cover"]
        playCounts          <- map["playCounts"]
        customTitle          <- map["customTitle"]
        albumId          <- map["albumId"]
        cardCover          <- map["cardCover"]
        title          <- map["title"]
        top3TrackTitle          <- map["top3TrackTitle"]
        id          <- map["id"]
        position          <- map["position"]
        
        albumId += position
        
        if customTitle == nil {
            customTitle = title
        }
//        if sceneId == 4 {
//            customTitle = title
//        }
        
        if id == 6 {
            if let attr_title = title {
                let attr = getAttring(aString: attr_title, font: UIFont.systemFont(ofSize: 14), color: UIColor.white)
                attrTitle = attr
                attrWidth = getStringWidth(aString: attrTitle!, height: 30)
            }
            
            if let titles = top3TrackTitle {
                for text in titles {
                    top3TrackTitleStr += (text + "|")
                }
                top3TrackTitleStr.removeLast()
            }
        }
       
    }
    
    
}

extension XMSleepDetailDataListModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return albumId as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let model = object as? XMSleepDetailDataListModel else {
            return false
        }
        return albumId == model.albumId
    }
    
    
}
