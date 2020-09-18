//
//  XMVipLayout.swift
//  himalaya
//
//  Created by Farben on 2020/8/18.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import IGListKit

class XMVipLayout: NSObject {
    
    
    
//    case vip_new_status_V3
//    case vip_square
    var module: XMVipModuleModel?
    var cellType = XMCellType.unKnow
    var cellSize: CGSize = CGSize.zero
    var imageUrls: [String]? //vip页面广告图url
    
    var theOnlyId: Int = 0
    
    /// 上半部分
    /// - Parameter module: <#module description#>
    init(module: XMVipModuleModel) {
        super.init()
        self.module = module
        
        self.theOnlyId = self.module!.moduleId
        self._layout()
    }
    
    
    
    var categorieWords: [XMVipCategorieWordModel]?
        
    /// 下半部分的分类
    /// - Parameter categorieWords: <#categorieWords description#>
    init(categorieWords: [XMVipCategorieWordModel]) {
        super.init()
        self.theOnlyId = 10321
        self.categorieWords = categorieWords
        self._layoutVipcategoriewords()
    }
}

extension XMVipLayout {
    private func _layout() {
        
        switch module?.moduleType {
        case "VIP_NEW_STATUS_V3":
            cellType = .vip_new_status_V3
            cellSize = CGSize(width: xm_screen_width, height: 130)
        case "VIP_SQUARE":
            switch module?.squareType {
                case "PICTURE_AND_TEXT":
                    cellType = .vip_square(.picture_and_text)
                    cellSize = CGSize(width: floor(content_view_width * 0.2), height: floor(content_view_width * 0.2))
                case "PICTURE":
                    cellType = .vip_square(.picture)
                    let cellHeight = ceil((content_view_width - 20) * 0.218)
                    cellSize = CGSize(width: xm_screen_width, height: cellHeight)
                default:
                break
            }
        case "HISTORY":
            cellType = .history
            cellSize = CGSize(width: xm_screen_width, height: 110)
        case "RECOMMENDATION":
            cellType = .recommendation
           
            _layoutRecommendation()
        case "AUDITION":
            cellType = .audition
            _layoutAudition()
        default:
            break
        }
    }
    
    private func _layoutVipcategoriewords() {
        cellType = .vipcategoriewords
        if let words = categorieWords {
            for word in words {
                let attr = getAttring(aString: word.categoryName ?? "", font: UIFont.systemFont(ofSize: 15), color: UIColor.xm.dynamicRGB((50, 50, 50), (200, 200, 200)))
                word.titleWidth = getStringWidth(aString: attr, height: 50)
                word.titleAttr = attr
            }
        }
        cellSize = CGSize(width: xm_screen_width, height: 50)
    }
    
    private func _layoutAudition() {
        
        if let banders = module?.focusImageModel?.focusImages, banders.count > 0 {
            var urls = [String]()
            for bander in banders {
                urls.append(bander.cover ?? "")
                if let urlStr = bander.realLink {
                    if urlStr.hasPrefix("https://") || urlStr.hasPrefix("http://") {
                        bander.isWebVc = true
                    }else if urlStr.hasPrefix("iting://") {
                        bander.isWebVc = false
                    if let dic = urlStr.qmui_queryItems() {
                        bander.linkParam = XMLinkParam(JSON: dic)
                    }
                    }
                }
            }
            imageUrls = urls
        }
        cellSize = CGSize(width: xm_screen_width, height: ceil(content_view_width * 0.4))
    }
    
    private func _layoutRecommendation() {
        
        let cellDetailWidth = UIDevice.isPad ? floor((content_view_width - 70) / 6) : floor((content_view_width - 40) / 3)
        let cellHeight = ceil((cellDetailWidth + 60) * (UIDevice.isPad ? 1 : 2) + 76)
        cellSize = CGSize(width: xm_screen_width, height: cellHeight)
        let font = UIFont.systemFont(ofSize: 13)
        let color = UIColor.xm.dynamicRGB((40, 40, 40), (240, 240, 240))
        let maxHeight = font.lineHeight * 2 + 3
        
        if let albums = module?.albums {
            for album in albums {
                let attr = getAttring(aString: album.title!, font: font, color: color, lineSpace: 3)
                var labelHeight = getStringRect(aString: attr, width: cellDetailWidth)
                if labelHeight > maxHeight {
                    labelHeight = maxHeight
                }
                album.titleAttr = attr
                album.titleAttrHeight = labelHeight                
            }
        }
    }
}

extension XMVipLayout: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return theOnlyId as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let layout = object as? XMVipLayout else {
            return false
        }
        return layout.theOnlyId == theOnlyId
    }
}


class XMVipAlbumLayout {
    
    var album: XMVipBodyAlbumListModel
    
    var cellType: XMCellType = .unKnow
    
    var cellHeight: CGFloat = 150
    
    var albumTitleAttr: NSAttributedString?//标题
    var albumTitleAttrHeight: CGFloat = 0//高度
    var albunIntroAttr: NSAttributedString?//中间介绍的文字
    var albumIntroHeight: CGFloat = 0//中间介绍的高度
    var labelTingCountTop: CGFloat = 0//最后数量的y值
    var labelTingAttr: NSAttributedString?//最后一行文字
    var labelTingCountWidth: CGFloat = 0//最后一行的宽度
    
    
    
    
    
    
    
    
    
    init(album: XMVipBodyAlbumListModel) {
        self.album = album
        _layout()
    }
}

//"itemType": "MODULE",
//           "data": {
//               "moduleType": "CUSTOM_ALBUM",
//               "properties": {
//                   "cardClass": "AGGREGATE_PICTURE",
//                   "hasMore": true,
//                   "moreUrl": "https://m.ximalaya.com/explore/subject_detail?id=8908&use_lottie=false",
//                   "aggregatePictures": "http://fdfs.xmcdn.com/group82/M0A/D1/E5/wKg5Il85_EvR0Gh2AAFzDeSCA0M579.jpg"
//               },
//               "sortEnable": true,
//               "moduleId": 1590,
//               "moduleName": "200817-精选专辑-群星好好读书-18",
//               "albums": []
//           }
extension XMVipAlbumLayout {
    
    private func _layout() {
        
        if album.itemType == "ALBUM" {
            cellType = .album
            _layoutAlbumAndTrack()
        }else if album.itemType == "TRACK" {
            cellType = .track
            _layoutAlbumAndTrack()
        }else if album.itemType == "MODULE" {
            switch album.adModel?.moduleType {
            case "CUSTOM_ALBUM"://AGGREGATE_PICTURE  AGGREGATE_CARD
                if album.adModel?.propertieModel?.cardClass == "AGGREGATE_PICTURE" {
                    cellType = .module(.custom_album_aggregate_picture)
                    _layoutCustomAlbumAggregatePicture()
                }else if album.adModel?.propertieModel?.cardClass == "AGGREGATE_CARD" {
                    cellType = .module(.custom_album_aggregate_card)
                    _layoutCustomAlbumAggregateCard()
                }
            case "INTEREST_AND_HOT_WORD":
                cellType = .module(.interest_and_hot_word)
                _layoutInsterAndHotWord()
            case "RANK_LIST":
                cellType = .module(.rank_list)
                _layoutRankList()
            default:
                break
            }
        }
    }
    
    
    private func _layoutRankList() {
        
        if let rankTables = album.adModel?.rankTables {
            let images = ["find_vip_rank_bg_0",
                          "find_vip_rank_bg_1",
                          "find_vip_rank_bg_2"]
            for (index, rankTable) in rankTables.enumerated() {
                rankTable.imageName = images[index % 3]
                
            }
        }
        cellHeight = 290
    }
    private func _layoutInsterAndHotWord() {
        cellHeight = ceil(((content_view_width - 10) * 0.5) * 1.2)
    }
    
    private func _layoutCustomAlbumAggregatePicture() {
        cellHeight = ceil(content_view_width * 0.385)
    }
    private func _layoutCustomAlbumAggregateCard() {
        let albumAttr = NSMutableAttributedString()
        if let albumTitle = album.adModel?.propertieModel?.title {
            albumAttr.addString(aString: albumTitle)
            albumAttr.addAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15), NSAttributedString.Key.foregroundColor: UIColor.colorWithrgba(255, 255, 255)], range: NSRange(location: 0, length: albumTitle.count))
        }
        if let subTitle = album.adModel?.propertieModel?.subTitle {
            albumAttr.addString(aString: "\n")
            let startLength = albumAttr.length
            albumAttr.addString(aString: subTitle)
            albumAttr.addAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.colorWithrgba(200, 200, 200)], range: NSRange(location: startLength, length: subTitle.count))
        }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        albumAttr.addAttributes([NSAttributedString.Key.paragraphStyle : paragraphStyle], range: NSRange(location: 0, length: albumAttr.length))
        albumTitleAttr = albumAttr
        
        
//        var titleAttr: NSAttributedString?
//           var titleAttrHeight: CGFloat = 0
//           var titleAttrWidth: CGFloat = 0
//           var imageViewSize: CGSize = CGSize.zero
        let cell_detail_width = ceil((content_view_width - 40) / 3)
        
        if let albums = album.adModel?.albums {
            let font = UIFont.systemFont(ofSize: 13)
            let color = UIColor.colorWithrgba(255, 255, 255)
            let labelMaxHeight: CGFloat = ceil(font.lineHeight * 2 + 3)
            for album in albums {
                if let albumTitle = album.title {
                    let titleAttr = NSMutableAttributedString(string: albumTitle)
                    titleAttr.xm_addAttributes(UIFont.systemFont(ofSize: 13), color: color, lineSpace: 3)
                    var titleHeight = getStringRect(aString: titleAttr, width: cell_detail_width)
                    if titleHeight > labelMaxHeight {
                        titleHeight = labelMaxHeight
                    }
                    album.titleAttr = titleAttr
                    album.titleAttrHeight = titleHeight
                }
            }
        }
//        100
        let cell_height = cell_detail_width + 160
        cellHeight = ceil(cell_height)
    }
    
    private func _layoutAlbumAndTrack() {
        
        var albumHeight: CGFloat = 10
        
//        cellHeight += 10
        
        let imageViewWidthHeight: CGFloat = UIDevice.isPad ? 140 : ceil(content_view_width * 0.3)
        
        let mutableTitleAttr = NSMutableAttributedString()
        if album.serialState == 2 {//完结 56 32
            if let imageOver = NSAttributedString.addImage(UIImage(named: "album_novel_finish"), -3, CGSize(width: 0, height: 0)) {
                mutableTitleAttr.append(imageOver)
            }
        }
        
        if let title = album.title {
            mutableTitleAttr.addString(aString: " \(title)")
        }
        let font = UIFont.boldSystemFont(ofSize: 15)
        let titleMaxHeight = ceil(font.lineHeight * 2 + 3)
        mutableTitleAttr.xm_addAttributes(font, color: UIColor.xm.dynamicRGB((20, 20, 20), (208, 208, 208)), lineSpace: 3)
        
        let width = content_view_width - (imageViewWidthHeight + 30)
        var height = getStringRect(aString: mutableTitleAttr, width: width)
        if height > titleMaxHeight {
            height = titleMaxHeight
        }
        albumTitleAttr = mutableTitleAttr
        albumTitleAttrHeight = height
        albumHeight += albumTitleAttrHeight
        
        if let intro = album.intro {
            let font = UIFont.systemFont(ofSize: 13)
            let introMaxHeight = ceil(font.lineHeight * 2 + 3)
            
            let attrIntro = getAttring(aString: intro, font: font, color: UIColor.xm.dynamicRGB((110, 110, 110), (140, 140, 140)), lineSpace: 2)
            var attrIntroHeight = getStringRect(aString: attrIntro, width: width - 20)
            if attrIntroHeight > introMaxHeight {
                attrIntroHeight = introMaxHeight
            }
            albunIntroAttr = attrIntro
            albumIntroHeight = attrIntroHeight + 10
            
            albumHeight += 5 //到上面的距离
            albumHeight += albumIntroHeight
        }
        
        
        let isHaveBottom = (cellType == .album) ? _layoutBottomAlbum() : _layoutBottomTrack()
        let imageHeight = imageViewWidthHeight + 10
        if isHaveBottom {
            if imageHeight > (albumHeight + 18) {
                labelTingCountTop = imageHeight - 14 //此时底边就是imageView的底边
                albumHeight = imageHeight
            }else {
                labelTingCountTop = albumHeight + xm_padding
                albumHeight = labelTingCountTop + 14 //加上自身的高度
            }
        }else {
            if albumHeight < imageHeight {
                albumHeight = imageHeight
            }
        }
        albumHeight += 10
        cellHeight = albumHeight
    }
    
    
    private func _layoutBottomAlbum() -> Bool{
        let attrBottomStr = NSMutableAttributedString()
        if album.playsCounts > 0 {
            if let tingImage = NSAttributedString.addImage(UIImage(named:"find_paid_hear_red"), -1.5, CGSize(width: 0, height: 0)) {
                attrBottomStr.append(tingImage)
            }
            attrBottomStr.addString(aString: countOther(count: album.playsCounts))
        }
        if album.tracks > 0 {
            attrBottomStr.addString(aString: "     ")
            if let trackImage = NSAttributedString.addImage(UIImage(named: "find_sound_count"), -1.5, CGSize(width: 0, height: 0)) {
                attrBottomStr.append(trackImage)
            }
            attrBottomStr.addString(aString: "\(album.tracks)")
        }
        
        if attrBottomStr.length > 0 {
            attrBottomStr.xm_addAttributes(UIFont.systemFont(ofSize: 10), color: UIColor.xm.dynamicRGB((100, 100, 100), (126, 126, 126)))
                   labelTingCountWidth = attrBottomStr.size().width
                   labelTingAttr = attrBottomStr
            return true
        }
        return false
       
    }
    
    private func _layoutBottomTrack() -> Bool {
        let attrBottomStr = NSMutableAttributedString()
            
        if let subTitle = album.albumTitle {
            if let tingImage = NSAttributedString.addImage(UIImage(named: "find_sound_album"), -1.5, CGSize(width: 0, height: 0)) {
                attrBottomStr.append(tingImage)
                attrBottomStr.addString(aString: " ")
            }
            var title = subTitle
            if subTitle.count > 7 {
                title = subTitle.subString(to: 8) + "..."
            }
            attrBottomStr.addString(aString: title)
        }
        
        if album.playCount > 0 {
            attrBottomStr.addString(aString: "     ")
            if let tingImage = NSAttributedString.addImage(UIImage(named:"find_paid_hear_red"), -1.5, CGSize(width: 0, height: 0)) {
                attrBottomStr.append(tingImage)
            }
            attrBottomStr.addString(aString: " \(album.playCount)")
        }
       
       
        if attrBottomStr.length > 0 {
            attrBottomStr.xm_addAttributes(UIFont.systemFont(ofSize: 10), color: UIColor.xm.dynamicRGB((100, 100, 100), (126, 126, 126)))
            labelTingCountWidth = attrBottomStr.size().width
            labelTingAttr = attrBottomStr
            return true
        }
        
        
        return false
    }
    
}

extension XMVipAlbumLayout: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return album as! NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let layout = object as? XMVipAlbumLayout else {
            return false
        }
        return layout.album === album
    }
    
    
}
