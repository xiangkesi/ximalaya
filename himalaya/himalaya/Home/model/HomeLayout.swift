//
//  HomeLayout.swift
//  himalaya
//
//  Created by Farben on 2020/8/7.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import UIKit
import IGListKit

class HomeLayout {
    //cell的size
    var cellSize: CGSize = CGSize.zero
    var cellType = XMCellType.unKnow
    
    /// 头部热点
    //标题
    var greetingsAttr: NSAttributedString?
    //标题宽度
    var greetingsWidth: CGFloat = 0
    
    
    /// 头部猜你喜欢标题
    var titleGuessAttr: NSAttributedString?
    
        
    
    /// album的标题
    var attrAlbumTitle: NSAttributedString?
    var attrAlbumTitleHeight: CGFloat = 0
    var albumIntroAttr: NSAttributedString?
    var albumIntroHeight: CGFloat = 0
    var albumRankAttr: NSAttributedString?
    var albumRankAttrWidth: CGFloat = 0
    var albumPlayCountStr: NSAttributedString?
    var albumBottomWidth: CGFloat = 0
    var albumBottomTop: CGFloat = 0
    
    
    //special
    var specialImageViewHeight: CGFloat = 0
    var speciallabelTitleHeight: CGFloat = 0
    var speciallabelDetailHeight: CGFloat = 0
    var speciallabelDetailAttr: NSAttributedString?
    var pecialBottomAttr: NSAttributedString?
    var pecialBottomHeight: CGFloat = 0
    
    
    
    //猜你在追, 私人FM两个cell子控件的Frame, 为了使用同一个cell
    var imageViewFrame: CGRect = CGRect.zero
    var labelTitleFrame: CGRect = CGRect.zero
    var labelDetailFrame: CGRect = CGRect.zero
    var topViewHidden: Bool = false
    var imageUrl: String?
    
    
    
    var albumImageName: String?
    
    
    var urlStrings: [String]?//轮播图url数组
    
    
    
    //广告
//    var ads: [XMAdModel]?
    
    var currentAd: XMAdModel?
    
    
    var track: HomeHotTrackModel?
    
    var headItems: [HomeHeaderItem]?
    
    var param: XMLinkParam?
    

    var heder: HomeModel
    init(model: HomeModel) {
        self.heder = model
        if heder.itemType == "MODULE" {
            
            switch heder.headerItem?.moduleType {
            case "focus":
                cellType = .module(.focus)
            case "square":
                cellType = .module(.square)
            case "topBuzz":
                cellType = .module(.topBuzz)
            case "guessYouLike":
                cellType = .module(.guessYouLike)
            case "ad":
                cellType = .module(.ad)
            case "hotSearchList":
                cellType = .module(.hotSearchList)
            case "cityCategory":
                cellType = .module(.cityCategory)
            case "hotPlayRank":
                cellType = .module(.hotPlayRank)
            case "voice_room_card":
                cellType = .module(.voice_room_card)
            case "paidCategory":
                cellType = .module(.paidCategory)
            case "live":
                cellType = .module(.live)
            case "specialList":
                cellType = .module(.specialList)
            case "anchor_card":
                cellType = .module(.anchor_card)
            case "fmList":
                cellType = .module(.fmList)
            case "categoryWord":
                cellType = .module(.categoryWord)
            default:
                cellType = .module(.unknow)
                break
            }
            _layoutMODULE()
        }else if heder.itemType == "ALBUM" {
            cellType = .album
            _layoutAlbumTrack()
        }else if heder.itemType == "TRACK" {
            cellType = .track
            _layoutAlbumTrack()
        }else if heder.itemType == "SPECIAL" {
            cellType = .special
            _layoutSpecial()
        }else if heder.itemType == "LIVE" {
            cellType = .live
             _layoutLive()
        }else if heder.itemType == "VIDEO" {
            cellType = .video
            _layoutVideo()
        }else if heder.itemType == "ONE_KEY_LISTEN_SCENE" {
            cellType = .one_key_listen_scene
            _layoutOnekeyListenSscene()
        }else if heder.itemType == "RECENT_LISTEN" {
            cellType = .recent_listen
            _layoutRecentListen()
        }else {
            cellSize = CGSize(width: content_view_width, height: 100)
        }
    }
}
//switch layout?.cellType {
//     case .module(.anchor_card):
//         return XMAnchorCardSectionController()
//     case .module(.fmList):
//         return XMFmListSectionController()
//     case .module(.specialList):
//         return XMSpecialListSectionController()
//     case .module(.paidCategory):
//         return XMPaidCategorySectionController()
//     case .module(.live):
//         return XMLiveSectionController()
//     case .module(.cityCategory):
//         return XMListenCitySectionController()
//     default:
//         return XMFuncSectionController()
//     }

extension HomeLayout {
    
    private func _layoutRecentListen() {
        topViewHidden = false
        let cellHeight: CGFloat = 140
        imageViewFrame = CGRect(x: content_view_width - 115, y: cellHeight - 115, width: 100, height: 100)
        labelTitleFrame = CGRect(x: xm_padding, y: imageViewFrame.minY + 30, width: content_view_width - 120, height: 30)
        labelDetailFrame = CGRect(x: xm_padding, y: labelTitleFrame.maxY, width: labelTitleFrame.size.width, height: labelTitleFrame.size.height)
        cellSize = CGSize(width: content_view_width, height: cellHeight)
        imageUrl = heder.headerItem?.lists?.first?.recentListen?.coverPath
        if let title = heder.headerItem?.lists?.first?.recentListen?.title {
            let attr = getAttring(aString: title, font: UIFont.boldSystemFont(ofSize: 15), color: UIColor.xm.dynamicRGB((0, 0, 0), (220, 220, 220)))
           speciallabelDetailAttr = attr
        }
        if let title = heder.headerItem?.lists?.first?.recentListen?.lastUptrackTitle {
            let attr = getAttring(aString: title, font: UIFont.systemFont(ofSize: 12), color: UIColor.xm.dynamicRGB((120, 120, 120), (140, 140, 140)))
           pecialBottomAttr = attr
        }
    }
    
    private func _layoutOnekeyListenSscene() {
        topViewHidden = true
        let cellHeight: CGFloat = ceil(content_view_width * 0.312)
        imageViewFrame = CGRect(x: 0, y: 0, width: content_view_width, height: cellHeight)
        labelTitleFrame = CGRect(x: xm_padding, y: 20, width: content_view_width - 2 * xm_padding, height: 20)
        labelDetailFrame = CGRect(x: xm_padding, y: 40, width: labelTitleFrame.size.width, height: 30)
//        先用这两个吧
//        var speciallabelDetailAttr: NSAttributedString?
//           var pecialBottomAttr: NSAttributedString?
        if let title = heder.headerItem?.title {
            let attr = getAttring(aString: title, font: UIFont.systemFont(ofSize: 13), color: UIColor.white)
            speciallabelDetailAttr = attr
        }
        
        if let geeAttr = heder.headerItem?.greeting {
            let attr = getAttring(aString: geeAttr, font: UIFont.boldSystemFont(ofSize: 18), color: UIColor.white)
            pecialBottomAttr = attr
        }
        if let ting = heder.headerItem?.iting {
            if let dic = ting.qmui_queryItems() {
                param = XMLinkParam(JSON: dic)
            }
        }
        
        cellSize = CGSize(width: content_view_width, height: cellHeight)
    }
    
    private func _layoutMODULE() {//hotSearchList
        
        switch cellType {
        case .module(.focus):
            if let banders = heder.headerItem?.lists?.first?.banders, banders.count > 0 {
                var banderImages = [String]()
                for bander in banders {
                    banderImages.append(bander.cover ?? "")
                    if let urlStr = bander.realLink {
                        if urlStr.hasPrefix("https://") ||
                        urlStr.hasPrefix("http://") {
                            bander.isWebVc = true
                        }else if urlStr.hasPrefix("iting://") {
                            bander.isWebVc = false
                            if let dic = urlStr.qmui_queryItems() {
                                bander.linkParam = XMLinkParam(JSON: dic)
                            }
                        }
                    }
                }
                urlStrings = banderImages
            }
            cellSize = CGSize(width: xm_screen_width, height: ceil(content_view_width * 0.4))
        case .module(.square):
            if let items = heder.headerItem?.lists {
                for item in items {
                    if item.coverPath?.hasSuffix("gif") == true {
                        item.coverPath = item.darkCoverPath
                    }
                }
            }
            cellSize = CGSize(width: xm_screen_width, height: ceil(content_view_width * 0.2))
        case .module(.topBuzz):
            
            if let items = heder.headerItem?.lists {
                var titles = [String]()
                for item in items {
                    if let title = item.track?.title {
                        titles.append(title)
                    }
                }
                track = items.first?.track
                heder.headerItem?.titles = titles
            }
            let attstr = NSMutableAttributedString(string: heder.headerItem?.greetings ?? "")
            attstr.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.xm.dynamicRGB((30, 30, 30), (210, 210, 210)), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)], range: NSRange(location: 0, length: attstr.length))
            greetingsWidth = getStringWidth(aString: attstr, height: 14)
            greetingsAttr = attstr
            cellSize = CGSize(width: xm_screen_width, height: 60)
        case .module(.guessYouLike):
            
            let attrStr = NSAttributedString(string: heder.headerItem?.title ?? "")
            let strString = attrStr.zs_attributedString(UIImage(named: "find_guess_you_like_icon"), UIFont.boldSystemFont(ofSize: 14), UIColor.xm.dynamicRGB((50, 50, 50), (210, 210, 210)), -4, 0, 5, 5)
            titleGuessAttr = strString
            let cellWidth = UIDevice.isPad ? floor((content_view_width - 70) / 6) : floor((content_view_width - 40) / 3)
            let cellDetailHeight = cellWidth + 60
            let cellHeight = UIDevice.isPad ? (cellDetailHeight + 76) : (cellDetailHeight * 2 + 76)
            cellSize = CGSize(width: xm_screen_width, height: cellHeight)
            if let items = heder.headerItem?.lists {
                for item in items {
                    item.picIsWebp = false
                    let font = UIFont.systemFont(ofSize: 13)
                    let mutableAttr = getAttring(aString: item.title ?? "", font: font, color: UIColor.xm.dynamicRGB((10, 10, 10), (210, 210, 210)), lineSpace: 3)
                    
                    var labelHeight = getStringRect(aString: mutableAttr, width: cellWidth)
                    item.attrTitleWidth = cellWidth
                    let fetailHeight: CGFloat = font.lineHeight * 2 + 3
                    if labelHeight > fetailHeight {
                        labelHeight = ceil(fetailHeight)
                    }
                    item.attrTitleHeight = labelHeight
                    item.attrTitle = mutableAttr
                    item.imageViewHeight = cellWidth
                    
                    let playerCountAttr = NSMutableAttributedString(string: " ")
                    if let imageAttr = NSAttributedString.addImage(UIImage(named: "common_palyer"), -1, CGSize(width: 10, height: 10)) {
                        playerCountAttr.append(imageAttr)
                    }
                    let countStr = countOther(count: item.playsCount)
                    playerCountAttr.addString(aString: "\(countStr)")
                    playerCountAttr.addAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 10), NSAttributedString.Key.foregroundColor: UIColor.colorWidthHexString(hex: "FAFAFA")], range: NSRange(location: 0, length: playerCountAttr.length))
                    item.attrPlayerCount = playerCountAttr
                }
            }
        case .module(.ad):
            specialImageViewHeight = ceil(content_view_width * 0.4)
            speciallabelTitleHeight = 35
            speciallabelDetailHeight = 20
            let height = specialImageViewHeight + speciallabelTitleHeight + speciallabelDetailHeight + 10
            cellSize = CGSize(width: content_view_width, height: height)
            
        case .module(.hotSearchList):
            if let items = heder.headerItem?.lists {
                var index = 0
                for item in items {
                    if index < 3 {
                        let str = NSAttributedString.addImage(UIImage(named: "find_hot_search_\(index + 1)"), 0, CGSize(width: 22, height: 22))
                        item.workRank = str
//                        item.colorString = ("FFFFFF", "1E1E1E")
                        item.isShowSearchHotLayer = false
                    }else {
                        let str = NSMutableAttributedString(string: "\(index + 1)")
                        str.addAttributes([NSAttributedString.Key.font : UIFont(name: "Helvetica-Bold", size: 12) ?? UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.white], range: NSRange(location: 0, length: str.length))
                        item.workRank = str
//                        item.colorString = ("E8D1C0", "E8D1C0")
                        item.isShowSearchHotLayer = true
                    }
                    index += 1
                }
            }
            cellSize = CGSize(width: xm_screen_width, height: 210)
        case .module(.cityCategory):
            let detailcellWidth: CGFloat = 100
            let detailCellHeight: CGFloat = 155
            let detailcellLabelWidth = detailcellWidth - 10
                       
            if let items = heder.headerItem?.lists {//                    HomeHeaderItemData
                headItems = [heder.headerItem!]
                for item in items {
                    if item.preferredType == 1 && item.isPaid == true {
                        item.topImageName = "albumTagYouxuan_Paid"
                    }else if item.preferredType == 1 {
                        item.topImageName = "albumTagYouxuan"
                    }else if item.isPaid == true {
                        item.topImageName = "albumTagVIP"
                    }

                    
                    if let attr = item.title {
                        let font = UIFont.systemFont(ofSize: 13)
                        
                        let mutableAttr = getAttring(aString: attr, font: font, color: UIColor.xm.dynamicRGB((20, 20, 20), (210, 210, 210)), lineSpace: 3)
                        var labelHeight = getStringRect(aString: mutableAttr, width: detailcellLabelWidth)
                        if labelHeight > font.lineHeight * 2 + 3 {
                            labelHeight = ceil(font.lineHeight * 2 + 3)
                        }
                        item.attrTitleTop = 10
                        item.attrTitleWidth = detailcellLabelWidth
                        item.attrTitleHeight = labelHeight
                        item.attrTitle = mutableAttr
                        item.imageViewHeight = detailcellWidth
                        
                        
                        let playerCountAttr = NSMutableAttributedString(string: " ")
                        if let imageAttr = NSAttributedString.addImage(UIImage(named: "common_palyer"), -1, CGSize(width: 10, height: 10)) {
                            playerCountAttr.append(imageAttr)
                        }
                        let countStr = countOther(count: item.playsCount)
                        playerCountAttr.addString(aString: "\(countStr)")
                        playerCountAttr.addAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 10), NSAttributedString.Key.foregroundColor: UIColor.colorWidthHexString(hex: "FAFAFA")], range: NSRange(location: 0, length: playerCountAttr.length))
                        item.attrPlayerCount = playerCountAttr
                    }
                }
            }
            cellSize = CGSize(width: xm_screen_width, height: detailCellHeight)
        case .module(.hotPlayRank):
              
            if let items = heder.headerItem?.lists {
                var index = 0
                for item in items {
                    if index < 3 {
                        if let imageRank = NSAttributedString.addImage(UIImage(named: String(format: "find_classia_top_%ld", index + 1)), 0, CGSize(width: 0, height: 0)) {
                            item.workRank = imageRank
                        }
                    }else {
                        let attr = getAttring(aString: "\(index + 1)", font: UIFont(name: "Helvetica-Bold", size: 19), color: UIColor.colorWithrgba(200, 200, 200))
                        item.workRank = attr
                    }
                    if let title = item.title {
                        let font = UIFont.systemFont(ofSize: 13)
                        
                        let attr = getAttring(aString: title, font: font, color: UIColor.xm.dynamicRGB((5, 5, 5), (200, 200, 200)), lineSpace: 3)
                        let labelWidth: CGFloat = 160
                        var labelHeight = getStringRect(aString: attr, width: labelWidth)
                        let detailFontHeight: CGFloat = font.lineHeight * 2 + 3
                        if labelHeight > detailFontHeight {
                            labelHeight = detailFontHeight
                        }
                        item.attrTitle = attr
                        item.attrTitleHeight = labelHeight
                    }
                    
                    index += 1
                }
            }
            cellSize = CGSize(width: xm_screen_width, height: 280)
        case .module(.voice_room_card):
            let detailcellWidth: CGFloat = 100
            let detailCellHeight: CGFloat = 155
            let detailcellLabelWidth = detailcellWidth - 10
            if let items = heder.headerItem?.lists {
                headItems = [heder.headerItem!]
                for item in items {
                    item.pic = item.coverUrl
                    item.albumId = item.fmId
                    var title = item.title ?? ""
                    if title.count > 5 {
                        title = title.subString(to: 5) + "..."
                    }
                    var titleAttr = NSMutableAttributedString(string: title)
                    titleAttr.addAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.xm.dynamicRGB((35, 35, 35), (210, 210, 210))], range: NSRange(location: 0, length: titleAttr.length))
                    
                    titleAttr = titleAttr.addString(aString: "\n")
                    
                    let nickName = item.presidentName ?? ""
                    let nameAttr = NSMutableAttributedString(string: nickName)
                    nameAttr.addAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 10), NSAttributedString.Key.foregroundColor: UIColor.xm.dynamicRGB((160, 160, 160), (130, 130, 130))], range: NSRange(location: 0, length: nameAttr.length))
                    titleAttr.append(nameAttr)
                    
                    let paragraphStyle = NSMutableParagraphStyle()
                    paragraphStyle.lineSpacing = 3
                    titleAttr.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: titleAttr.length))
                    
                    let labelHeight = getStringRect(aString: titleAttr, width: detailcellLabelWidth)
                    item.attrTitleWidth = detailcellLabelWidth
                    item.attrTitleHeight = labelHeight
                    item.attrTitle = titleAttr
                    item.imageViewHeight = detailcellWidth
                    let imageBottomAttr = NSMutableAttributedString(string: " ")
                    if let imageAttr = NSAttributedString.addImage(UIImage(named: "live_wave0"), -1, CGSize(width: 12, height: 12)) {
                        imageBottomAttr.append(imageAttr)
                        imageBottomAttr.addString(aString: " ")
                    }
                    imageBottomAttr.addString(aString: "\(item.hotNum)")
                    imageBottomAttr.addAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 10), NSAttributedString.Key.foregroundColor: UIColor.colorWidthHexString(hex: "FAFAFA")], range: NSRange(location: 0, length: imageBottomAttr.length))
                    item.attrPlayerCount = imageBottomAttr
                    item.topImageName = "rec_flow_ent_tag"
                }
            }
            cellSize = CGSize(width: xm_screen_width, height: detailCellHeight)
        case .module(.paidCategory):
            let detailcellWidth: CGFloat = 100
            let detailCellHeight: CGFloat = 155
            let detailcellLabelWidth = detailcellWidth - 10
            if let items = heder.headerItem?.lists, items.count > 0 {
                
                headItems = [heder.headerItem!]
                
                let colors:[(CGFloat, CGFloat, CGFloat)] = [(121, 91, 90), (122, 92, 108), (125, 115, 93), (45, 45, 45), (92, 109, 127), (87, 90, 124), (103, 91, 125), (128, 128, 93), (96, 127, 128)]
                let font = UIFont.systemFont(ofSize: 12)
                let color = UIColor.colorWithrgba(250, 250, 250)
                let labelMaxHeight = ceil(font.lineHeight * 2 + 3)
                for item in items {
                    item.colorTule = colors[Int(arc4random() % 8)]
                    if item.preferredType == 1 && item.isPaid == true {
                        item.topImageName = "albumTagYouxuan_Paid"
                    }else if item.preferredType == 1 {
                        item.topImageName = "albumTagYouxuan"
                    }else if item.isPaid == true {
                        item.topImageName = "albumTagVIP"
                    }
                    if let title = item.title {
                        let titleAttr = NSMutableAttributedString()
                        
                        if item.isFinished == 2 {
                            if let finisedImage = NSAttributedString.addImage(UIImage(named: "album_novel_finish"), 0, CGSize(width: 0, height: 0)) {
                                titleAttr.append(finisedImage)
                            }
                        }
                        titleAttr.addString(aString: " \(title)")
                        titleAttr.xm_addAttributes(font, color: color, lineSpace: 3)
                        var titleHeight = getStringRect(aString: titleAttr, width: detailcellLabelWidth)
                        if titleHeight > labelMaxHeight {
                            titleHeight = labelMaxHeight
                        }
                        item.attrTitleWidth = detailcellLabelWidth
                        item.attrTitleHeight = titleHeight
                        item.attrTitle = titleAttr
                        item.imageViewHeight = detailcellWidth
                    }
                }
            }
            cellSize = CGSize(width: xm_screen_width, height: detailCellHeight)
        case .module(.live):
            let detailcellWidth: CGFloat = 100
            let detailCellHeight: CGFloat = 155
            let detailcellLabelWidth = detailcellWidth - 10
            
            if let items = heder.headerItem?.lists, items.count > 0 {
                
                headItems = [heder.headerItem!]
                
                for item in items {
                    item.albumId = item.roomId
                    item.pic = item.coverMiddle
                    var title = item.name ?? ""
                    if title.count > 6 {
                        title = title.subString(to: 6) + "..."
                    }
                    let titleAttr = NSMutableAttributedString(string: title)
                    titleAttr.addAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.xm.dynamicRGB((50, 50, 50), (200, 200, 200))], range: NSRange(location: 0, length: titleAttr.length))
                    titleAttr.addString(aString: "\n")
                    
                    let nickName = item.nickname ?? ""
                    let nameAttr = NSMutableAttributedString(string: nickName)
                    nameAttr.addAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 10), NSAttributedString.Key.foregroundColor: UIColor.xm.dynamicRGB((150, 150, 150), (130, 130, 130))], range: NSRange(location: 0, length: nameAttr.length))
                    titleAttr.append(nameAttr)
                    
                    let paragraphStyle = NSMutableParagraphStyle()
                    paragraphStyle.lineSpacing = 3
                    titleAttr.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: titleAttr.length))
                    
                    let labelHeight = getStringRect(aString: titleAttr, width: detailcellLabelWidth)
                    item.attrTitleWidth = detailcellLabelWidth
                    item.attrTitleHeight = labelHeight
                    item.attrTitle = titleAttr
                    item.imageViewHeight = detailcellWidth
                    
                    let playerAttr = NSMutableAttributedString()
                    if let imageAttr = NSAttributedString.addImage(UIImage(named: "live_wave0"), -1.5, CGSize(width: 0, height: 0)) {
                        playerAttr.append(imageAttr)
                        playerAttr.addString(aString: " ")
                    }
                    playerAttr.addString(aString: "\(item.playCount)")
                    playerAttr.addAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 10), NSAttributedString.Key.foregroundColor: UIColor.colorWidthHexString(hex: "FAFAFA")], range: NSRange(location: 0, length: playerAttr.length))
                    item.attrPlayerCount = playerAttr
//                    attrPlayerCount  playCount
                }
            }
            cellSize = CGSize(width: content_view_width, height: detailCellHeight)
        case .module(.specialList):
            let detailcellWidth: CGFloat = 140
            let detailCellHeight: CGFloat = 120
            let detailcellLabelWidth = detailcellWidth - 20
            let imageHeight: CGFloat = 66
            if let items = heder.headerItem?.lists, items.count > 0 {
                headItems = [heder.headerItem!]
                
                let font = UIFont.systemFont(ofSize: 13)
                let color = UIColor.xm.dynamicRGB((35, 35, 35), (210, 210, 210))
                let labelMaxHeight = ceil(font.lineHeight * 2 + 3)
                
                for item in items {
                    item.albumId = item.specialId
                    item.pic = item.coverPathBig
                    item.imageViewHeight = imageHeight
                    if let title = item.title {
                        let mutableAttr = getAttring(aString: title, font: font, color: color, lineSpace: 3)
                        var labelHeight = getStringRect(aString: mutableAttr, width: detailcellLabelWidth)
                        if labelHeight > labelMaxHeight {
                            labelHeight = labelMaxHeight
                        }
                        item.attrTitleWidth = detailcellLabelWidth
                        item.attrTitleHeight = labelHeight
                        item.attrTitle = mutableAttr
                    }
                }
            }
            cellSize = CGSize(width: content_view_width, height: detailCellHeight)
        case .module(.anchor_card):
            let detailCellHeight: CGFloat = 140
            
            if let items = heder.headerItem?.lists, items.count > 0 {
                headItems = [heder.headerItem!]
                let colors:[(CGFloat, CGFloat, CGFloat)] = [(122, 91, 89), (88, 89, 124), (45, 45, 45), (92, 109, 127)]
                for item in items {
                    item.albumId = item.uid
                    item.colorTule = colors[Int(arc4random() % 3)]
                    let mutableAttr = NSMutableAttributedString()
                    if let nickName = item.nickname {
                        mutableAttr.addString(aString: nickName)
                        mutableAttr.addAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.xm.dynamicRGB((0, 0, 0), (210, 210, 210))], range: NSRange(location: 0, length: mutableAttr.length))
                        mutableAttr.addString(aString: "\n")
                    }
                    if let personDescribe = item.personDescribe {
                        let mutable = NSMutableAttributedString(string: personDescribe)
                        mutable.addAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 11), NSAttributedString.Key.foregroundColor: UIColor.xm.dynamicRGB((160, 160, 160), (130, 130, 130))], range: NSRange(location: 0, length: mutable.length))
                        mutableAttr.append(mutable)
                    }
                    
                    let paragraphStyle = NSMutableParagraphStyle()
                    paragraphStyle.lineSpacing = 3
                    paragraphStyle.alignment = .center
                    mutableAttr.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: mutableAttr.length))
                    item.attrTitle = mutableAttr
                }
            }
            cellSize = CGSize(width: content_view_width, height: detailCellHeight)
        case .module(.fmList):
            if let items = heder.headerItem?.lists {
                headItems = [heder.headerItem!]
                for item in items {
                    item.albumId = item.channelId
                    if let title = item.name {
                        let attr = getAttring(aString: title, font: UIFont.systemFont(ofSize: 12), color: UIColor.white)
                        item.attrTitle = attr
                    }
                }
            }
            cellSize = CGSize(width: content_view_width, height: 100)
        case .module(.categoryWord):
            if let items = heder.headerItem?.lists {
                for item in items {
                    if let title = item.title {
                        let attr = getAttring(aString: title, font: UIFont.systemFont(ofSize: 14), color: UIColor.xm.dynamicRGB((96, 96, 96), (150, 150, 150)))
                        item.attrTitle = attr
                        let itemWidth = getStringWidth(aString: attr, height: 30)
                        item.itemWidth = itemWidth + 40
                    }
                }
            }
            cellSize = CGSize(width: xm_screen_width, height: 110)
        default:
            cellSize = CGSize(width: content_view_width, height: 210)
            break
        }
    }
    
    private func _layoutLive() {
        var cellHeight: CGFloat = 0
        cellHeight += 10
        let imageViewWidthHeight = UIDevice.isPad ? 140 : ceil(content_view_width * 0.3)
        
        let width = content_view_width - (imageViewWidthHeight + 30)
        if let title = heder.headerItem?.liveName {
            /// 暂时先使用完结的图片
            let mutableAttr = NSMutableAttributedString()
            if let imageOver = NSAttributedString.addImage(UIImage(named: "album_novel_finish"), -3, CGSize(width: 0, height: 0)) {
                mutableAttr.append(imageOver)
            }
            let attStr = NSAttributedString(string: " \(title)")
            mutableAttr.append(attStr)
            
            let font = UIFont.boldSystemFont(ofSize: 15)
            let titleMaxHeight = ceil(font.lineHeight * 2 + 3)
            mutableAttr.xm_addAttributes(font, color:  UIColor.xm.dynamicRGB((20, 20, 20), (208, 208, 208)), lineSpace: 3)
            var height = getStringRect(aString: mutableAttr, width: width)
            if height > titleMaxHeight {
                height = titleMaxHeight
            }
            attrAlbumTitleHeight = height
            attrAlbumTitle = mutableAttr
            cellHeight += attrAlbumTitleHeight
        }
        
        
        if let recInfo = heder.headerItem?.recInfo,
            let recReason = recInfo.recReason {
            let recReasonAttr = getAttring(aString: recReason, font: UIFont.systemFont(ofSize: 13), color: UIColor.xm.dynamicRGB((110, 110, 110), (140, 140, 140)), lineSpace: 3)
            var newrRecReasonAttrHeight = getStringRect(aString: recReasonAttr, width: width - 20)
            
            newrRecReasonAttrHeight = newrRecReasonAttrHeight > 40 ? 38 : newrRecReasonAttrHeight
            albumIntroHeight = newrRecReasonAttrHeight + 10
            albumIntroAttr = recReasonAttr
            cellHeight += 5
            cellHeight += albumIntroHeight
        }
        
        
        if let nickName = heder.headerItem?.nickname {
//            cellHeight += 15
//            cellHeight += 14
            let mutableAttr = NSMutableAttributedString()
            if let imageAttr = NSAttributedString.addImage(UIImage(named: "find_live_icon"), -1.5, CGSize(width: 0, height: 0)) {
                mutableAttr.append(imageAttr)
            }
            mutableAttr.append(NSAttributedString(string: " \(nickName)"))
            
            if let playCount = heder.headerItem?.playCount, playCount > 0 {
                mutableAttr.append(NSAttributedString(string: "      "))
                if let imageAttr = NSAttributedString.addImage(UIImage(named: "find_sound_count"), -1.5, CGSize(width: 0, height: 0)) {
                    mutableAttr.append(imageAttr)
                }
                mutableAttr.append(NSAttributedString(string: " \(playCount)"))
            }
            
            mutableAttr.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.xm.dynamicRGB((100, 100, 100), (126, 126, 126)), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)], range: NSRange(location: 0, length: mutableAttr.length))
            albumBottomWidth = mutableAttr.size().width
            albumPlayCountStr = mutableAttr
            
            let imageViewHeight = imageViewWidthHeight + 10
            if imageViewHeight > cellHeight - 14 {
                albumBottomTop = imageViewHeight - 14
                cellHeight = imageViewHeight
            }else {
                albumBottomTop = cellHeight + xm_padding
                cellHeight += 15//距离上面边距
                cellHeight += 14 //自身高度
            }
        }
        albumImageName = "rec_flow_live_tag"
        heder.headerItem?.coverPath = heder.headerItem?.coverMiddle
//        let imageViewHeight = ceil(content_view_width * 0.3) + 10
        cellHeight = cellHeight + 10
        cellSize = CGSize(width: xm_screen_width, height: cellHeight)
        
        
    }
    
    private func _layoutAlbumTrack() {
        
        var cellHeight: CGFloat = 10
        
        let imageViewWidthHeight = UIDevice.isPad ? 140 : ceil(content_view_width * 0.3)
        
        
        let mutableAttr = NSMutableAttributedString()
        if  heder.headerItem?.serialState == 2 {//完结
            if let imageOver = NSAttributedString.addImage(UIImage(named: "album_novel_finish"), -3, CGSize(width: 0, height: 0)) {
                mutableAttr.append(imageOver)
            }
        }
        
        let attStr = NSAttributedString(string: " \(heder.headerItem?.title ?? "")")
        mutableAttr.append(attStr)
        let font = UIFont.boldSystemFont(ofSize: 15)
        let titleMaxHeight = ceil(font.lineHeight * 2 + 3)
        mutableAttr.xm_addAttributes(font, color: UIColor.xm.dynamicRGB((20, 20, 20), (208, 208, 208)), lineSpace: 3)
        let width = content_view_width - (imageViewWidthHeight + 30)
        var height = getStringRect(aString: mutableAttr, width: width)
        if height > titleMaxHeight {
            height = titleMaxHeight
        }
        attrAlbumTitleHeight = height
        attrAlbumTitle = mutableAttr
        
        cellHeight += attrAlbumTitleHeight
        
        if let attrIntro = heder.headerItem?.intro {
            let font = UIFont.systemFont(ofSize: 13)
            let introMaxHeight: CGFloat = ceil(font.lineHeight * 2 + 3)
            
            let attrintroStr = getAttring(aString: attrIntro, font: font , color: UIColor.xm.dynamicRGB((110, 110, 110), (140, 140, 140)), lineSpace: 3)
            var attrIntroHeight = getStringRect(aString: attrintroStr, width: width - 20)
            if attrIntroHeight > introMaxHeight {
                attrIntroHeight = introMaxHeight
            }
            albumIntroHeight = attrIntroHeight + 10
            albumIntroAttr = attrintroStr
            cellHeight += 5
            cellHeight += albumIntroHeight
        }
        
        
        if heder.headerItem?.preferredType == true && heder.headerItem?.vipFreeType == true {
            albumImageName = "albumTagYouxuan_VIP"
        }else if heder.headerItem?.preferredType == true {
            albumImageName = "albumTagYouxuan"
        }else if heder.headerItem?.vipFreeType == true {
            albumImageName = "albumTagVIP"
        }
        
        if let recInfo = heder.headerItem?.recInfo,
            let recReason = recInfo.recReason {
            let recReasonAttr = NSAttributedString(string: recReason)
            let recReasonWidth = getStringWidth(aString: recReasonAttr, height: 14)
            albumRankAttrWidth = recReasonWidth
            albumRankAttr = recReasonAttr
            cellHeight += 15
            cellHeight += 14
        }
     
        let isHaveBottom: Bool = (cellType == .album) ? _layoutAlbum() : _layoutTrack()
        if isHaveBottom == true {
            let imageViewHeight = imageViewWidthHeight + 10
            if imageViewHeight > (cellHeight + 20) {
                albumBottomTop = imageViewHeight - 14
                cellHeight = imageViewHeight
            }else {
                albumBottomTop = cellHeight + xm_padding
                cellHeight += 15//距离上边高度
                cellHeight += 14//自身高度
            }
        }
        cellHeight += 10//加最后面边框
        cellSize = CGSize(width: xm_screen_width, height: cellHeight)
    }
    
    private func _layoutTrack() -> Bool {
       
        if let albumTitle = heder.headerItem?.albumTitle {
            
            let mutableAttr = NSMutableAttributedString()
            if let attrImage = NSAttributedString.addImage(UIImage(named: "find_sound_album"), -1, CGSize(width: 10, height: 10)) {
                mutableAttr.append(attrImage)//需要带圆圈的图片
            }
            
            var newStr = " \(albumTitle)"
            if newStr.count > 7 {
                newStr = newStr.subString(to: 8) + "..."
            }
            let albumTitleAttr = NSAttributedString(string: newStr)
            mutableAttr.append(albumTitleAttr)
            
            if let playCount = heder.headerItem?.playsCounts {
                if let strAttr = NSAttributedString.addImage(UIImage(named: "find_paid_hear_red"), -1.5) {
                    mutableAttr.append(NSAttributedString(string: "      "))
                    mutableAttr.append(strAttr)
                }
                let playerCountAttr = NSAttributedString(string: countOther(count: playCount))
                mutableAttr.append(playerCountAttr)
                
            }
            mutableAttr.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.xm.dynamicRGB((100, 100, 100), (126, 126, 126)), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)], range: NSRange(location: 0, length: mutableAttr.length))
            albumBottomWidth = mutableAttr.size().width
            albumPlayCountStr = mutableAttr
            return true
        }
        return false
    }
    private func _layoutAlbum() -> Bool {
        
        if let playCount = heder.headerItem?.playsCounts {
            let playerCountStr = countOther(count: playCount)
            let mutableAttr = NSMutableAttributedString()
            if let strAttr = NSAttributedString.addImage(UIImage(named: "find_paid_hear_red"), -1.5) {
                mutableAttr.append(strAttr)
            }
            mutableAttr.append(NSAttributedString(string: playerCountStr))
            
            if let score = heder.headerItem?.albumScore {
                mutableAttr.append(NSAttributedString(string: "      "))
                let star = scoreStar(score: score)
                if star > 0 {
                    var jndex: Int = 0
                    for index in 0..<(star - 1) {//全星星的
                        if let attrScoreStar = NSAttributedString.addImage(UIImage(named: "album_comment_full_star_new_yellow-1"), -2, CGSize(width: 11, height: 11)) {
                            mutableAttr.append(attrScoreStar)
                        }
                        jndex = index
                    }
                    for num in 0..<(4 - jndex) {
                        if let attrScoreStar = NSAttributedString.addImage(UIImage(named: num == 0 ? "album_comment_half_star_new_yellow-1" : "album_comment_empty_star_new_yellow"), -2, CGSize(width: 11, height: 11)) {
                            mutableAttr.append(attrScoreStar)
                        }
                    }
                    let scoreStr = NSAttributedString(string: " \(score)")
                    mutableAttr.append(scoreStr)
                }
            }
            mutableAttr.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.xm.dynamicRGB((100, 100, 100), (126, 126, 126)), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)], range: NSRange(location: 0, length: mutableAttr.length))
            albumBottomWidth = mutableAttr.size().width
            albumPlayCountStr = mutableAttr
            return true
        }
        return false
    }
    
    private func _layoutVideo() {
        specialImageViewHeight = ceil(content_view_width * 0.55)
        speciallabelTitleHeight = 35
        let mutableAttr = NSMutableAttributedString()
        if let playsCounts = heder.headerItem?.playsCounts {
            if let imageVideo = NSAttributedString.addImage(UIImage(named: "find_paid_hear_red"), -1.5, CGSize(width: 0, height: 0)) {
                mutableAttr.append(imageVideo)
            }
            let str = countOther(count: playsCounts) + "次播放"
            mutableAttr.append(NSAttributedString(string: " \(str)"))
        }
        
        if let timeImage = NSAttributedString.addImage(UIImage(named: "find_sound_duration"), -1.5, CGSize(width: 0, height: 0)) {
            mutableAttr.append(NSAttributedString(string: "      "))
            mutableAttr.append(timeImage)
        }
        if let timerAttr = heder.headerItem?.videoDuration {
            mutableAttr.append(NSAttributedString(string: " \(timerAttr)"))
        }
        mutableAttr.xm_addAttributes(UIFont.systemFont(ofSize: 11), color: UIColor.xm.dynamicRGB((150, 150, 150), (135, 135, 135)), lineSpace: 0)
        speciallabelDetailHeight = 20
        speciallabelDetailAttr = mutableAttr
        let videoHeight = specialImageViewHeight + speciallabelTitleHeight + speciallabelDetailHeight + 10
        cellSize = CGSize(width: content_view_width, height: videoHeight)
    }
    
    private func _layoutSpecial() {
        if let item = heder.headerItem {
            specialImageViewHeight = ceil(content_view_width * 0.465)
            speciallabelTitleHeight = 35
            if let detailStr = item.subtitle {
                let attr = getAttring(aString: detailStr, font: UIFont.systemFont(ofSize: 13), color: UIColor.xm.dynamicRGB((150, 150, 150), (135, 135, 135)), lineSpace: 3)
                let attrHeight = getStringRect(aString: attr, width: content_view_width - 20)
                speciallabelDetailHeight = attrHeight
                speciallabelDetailAttr = attr

            }
            
            let mutableAttr = NSMutableAttributedString()
            
            if let imageTingAttr = NSAttributedString.addImage(UIImage(named: "find_paid_hear_red"), 0, CGSize(width: 0, height: 0)) {
                mutableAttr.append(imageTingAttr)
            }
            mutableAttr.append(NSAttributedString(string: " \(item.viewCount)      "))
            
            if let imageCountAttr = NSAttributedString.addImage(UIImage(named: "find_sound_count"), 0, CGSize(width: 0, height: 0)) {
                mutableAttr.append(imageCountAttr)
            }
            mutableAttr.append(NSAttributedString(string: " \(item.countSet)集"))
            mutableAttr.addAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 11), NSAttributedString.Key.foregroundColor: UIColor.xm.dynamicRGB((110, 110, 110), (130, 130, 130))], range: NSRange(location: 0, length: mutableAttr.length))
            pecialBottomAttr = mutableAttr
            pecialBottomHeight = 45
        }
        let cellHeight: CGFloat = specialImageViewHeight + speciallabelTitleHeight + speciallabelDetailHeight + pecialBottomHeight
        cellSize = CGSize(width: content_view_width, height: cellHeight)        
    }
    

    
    
 
}

extension HomeLayout: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return heder as! NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let layout = object as? HomeLayout else {
            return false
        }
        return heder === layout.heder
    }
    
    
    
}
