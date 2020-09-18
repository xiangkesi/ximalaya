//
//  ActiveLayout.swift
//  himalaya
//
//  Created by Farben on 2020/8/4.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import IGListDiffKit


class XMFindVoiceLayout {
    
    
    var active: XMFindVoiceModel
    var cellType = XMCellType.unKnow
    
    
    var cellHeight: CGFloat = 0
    
    var focusImages: [String]?
    
    
    lazy var rows = [ActiveSectionRow]()
    
    init(active: XMFindVoiceModel) {
        self.active = active
        
        switch active.dubItemType {
        case "DubFeedItem":
            cellType = .dubFeedItem
            _layoutDubFeedItem()
        case "Module":
            switch active.item?.type {
            case "dubFeedRecoDub":
                cellType = .module(.dubFeedRecoDub)
                cellHeight = 150
                _layoutDubFeedRecoDub()
            case "dubFeedAd":
                cellType = .module(.dubFeedAd)
                cellHeight = ceil(content_view_width * 0.313)
                _layoutFocusImages()
            case "dubFeedRecoAnchor":
                cellType = .module(.dubFeedRecoAnchor)
                cellHeight = 300
                _layoutDubFeedRecoAnchor()
            default:
                break
            }
        default:
            break
        }
    }
    
    
    
}


extension XMFindVoiceLayout {
    
    private func _layoutDubFeedRecoAnchor() {
        if let models = active.item?.contents {
            for (index, model) in models.enumerated() {
                model.contentId = model.uid + Int64(index)
            }
        }
    }
    
    private func _layoutFocusImages() {
        if let models = active.item?.contents, models.count > 0 {
            var urls = [String]()
            for model in models {
                if let url = model.coverPath {
                    urls.append(url)
                }
            }
            focusImages = urls
        }
    }
    
    private func _layoutDubFeedRecoDub() {
        if let items = active.item?.contents {
            let font = UIFont.systemFont(ofSize: 13)
            let color = UIColor.xm.dynamicRGB((60, 60, 60), (200, 200, 200))
            let labelMaxHeight = ceil(font.lineHeight * 2 + 3)
            
            for item in items {
                let attr = getAttring(aString: item.name ?? "", font: font, color: color, lineSpace: 3)
                var labelHeight = getStringRect(aString: attr, width: 150)
                if labelHeight > labelMaxHeight {
                    labelHeight = labelMaxHeight
                }
                item.contentAttrHeight = labelHeight
                item.contentAttr = attr
            }
        }
    }
    
    private func _layoutDubFeedItem() {
        if let picStr = active.item?.dubbingItem?.coverSmall {
            var row = ActiveSectionRow()
            row.cellType = .video
            row.cellHeight = ceil(content_view_width * 0.56) + xm_padding
            row.imageCover = picStr
            let mutableAttr = NSMutableAttributedString()
            if let imageAttr = NSAttributedString.addImage(UIImage(named: "videoicon"), -3, CGSize(width: 14, height: 14)) {
                mutableAttr.append(imageAttr)
                mutableAttr.addString(aString: " ")
            }
            if let time = active.item?.dubbingItem?.duration {
                mutableAttr.addString(aString: "00:\(time)  |  ")
            }
            if let count = active.item?.dubbingItem?.playTimes {
                mutableAttr.addString(aString: "\(count)次播放")
            }
            mutableAttr.addAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 11), NSAttributedString.Key.foregroundColor: UIColor.white], range: NSRange(location: 0, length: mutableAttr.length))
                row.videoTitle = mutableAttr
                
            rows.append(row)
        }
        
        if let content = active.item?.dubbingItem?.title {
            var row = ActiveSectionRow()
            row.cellType = .content
            let attr = getAttring(aString: content, font: UIFont.boldSystemFont(ofSize: 18), color: UIColor.xm.dynamicRGB((50, 50, 50), (210, 210, 210)), lineSpace: 5)
            let labelHeight = getStringRect(aString: attr, width: content_view_width)
            row.cellHeight = labelHeight + xm_padding
            row.attrTitleHeight = labelHeight
            row.attrTitle = attr
            rows.append(row)
        }
        
        var row = ActiveSectionRow()
        row.cellType = .bottom
        row.cellHeight = 50
        row.userName = active.item?.dubbingItem?.nickname
        row.userCover = active.item?.dubbingItem?.logoPic
        row.attrUserCount = " \(active.item?.dubbingItem?.trackTotalCount ?? 0)人都在配对"
        rows.append(row)
    }
    
}

extension XMFindVoiceLayout: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return active as! NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        
        guard let layout = object as? XMFindVoiceLayout else {
            return false
        }
        return active === layout.active
    }
    
}


struct ActiveSectionRow {
    
    
    enum ActiveSectionRowType {
        case topic
        case video
        case content
        case bottom
        case unknow
    }
    
    var cellHeight: CGFloat = 0
    var topicTitle: String?
    var topicId: Int = 0
    
    var imageCover: String?
    var videoTitle: NSAttributedString?
    
    
    var attrTitle: NSAttributedString?
    var attrTitleHeight: CGFloat = 0
    
    var userCover: String?
    var userName: String?
    var attrUserCount: String?
    
    
    var userCount: Int = 0
    
    var cellType: ActiveSectionRowType = .unknow
    
}
