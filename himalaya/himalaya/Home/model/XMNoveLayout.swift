//
//  XMNoveLayout.swift
//  himalaya
//
//  Created by Farben on 2020/8/26.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import IGListKit



class XMNoveLayout {
    
    
    enum XMNoveLayoutType {
        case focusImage
        case album
        case keyword
        case movie
        case adCard
        case week
        case live
        case project
        case tonight
        case recommended
        case albumTrack
        case manWomenLove//男生女生最爱
        case unKnow
    }
    
    var uniqueId: Int64 = 0
    var cellHeight: CGFloat = 0
    var cellType: XMNoveLayoutType = .unKnow
    
    
    var fousImage: XMNoveFocusImageModel?
    var fourceImageUrls: [String]?
    init(fousImage: XMNoveFocusImageModel) {
        self.fousImage = fousImage
        uniqueId = fousImage.responseId
        cellType = .focusImage
        _layoutFousImage()
    }
    
    
    
    
    var categoryContent: XMNoveCategoryContentListModel?
    
    var funcCellWidth: CGFloat = 0
    var upkeyWordModels:[XMNoveCategoryContentList_listModel]?//非展开的
    var downkeyWordModels: [XMNoveCategoryContentList_listModel]?//展开的
    
    var hotFilmAttr: NSAttributedString?
    
    init(categoryContents: XMNoveCategoryContentListModel) {
        guard let category_contents = categoryContents.lists, category_contents.count > 0 else {
            return
        }
        self.categoryContent = categoryContents
        if categoryContent?.contentType == "album" || categoryContents.moduleType == 48 {
            cellType = .album
            uniqueId = Int64(categoryContents.moduleType) + categoryContents.keywordId
            _layoutAlbums()
        }else {
            if categoryContent?.moduleType == 30 {
                cellType = .keyword
                uniqueId = Int64(categoryContents.moduleType + categoryContents.categoryId)
                 _layoutKeyWordContent()
            }else if categoryContent?.moduleType == 43 {
                cellType = .movie
                uniqueId = Int64(categoryContents.moduleType + categoryContents.categoryId)
                _layoutHotFilm()
            }else if categoryContent?.moduleType == 17 {
                uniqueId = Int64(categoryContent!.moduleType + categoryContent!.categoryId)
                cellType = .adCard
                cellHeight = ceil(content_view_width * 0.4)
            }else if categoryContents.moduleType == 51 {
                uniqueId = Int64(categoryContent!.moduleType + categoryContent!.categoryId)
                cellType = .week
                _layoutWeek()
            }else if categoryContents.moduleType == 16 {
                uniqueId = Int64(categoryContent!.moduleType + categoryContent!.categoryId)
                cellType = .live
                cellHeight = 200
                _layoutLive()
            }else if categoryContents.moduleType == 38 {
                uniqueId = Int64(categoryContent!.moduleType + categoryContent!.categoryId)
                cellType = .project
                cellHeight = 200
                _layoutProject()
            }else if categoryContents.moduleType == 19 {
                uniqueId = Int64(categoryContent!.moduleType + categoryContent!.categoryId)
                cellType = .tonight
                cellHeight = 320
            }else if categoryContents.moduleType == 35 {
                uniqueId = Int64(categoryContent!.moduleType + categoryContent!.categoryId)
                cellType = .recommended
                cellHeight = 40
            }else if categoryContents.moduleType == 22{
                uniqueId = Int64(categoryContents.moduleType + categoryContents.categoryId)
                cellType = .manWomenLove
                cellHeight = 355
                _layoutManWomenLove()
            }else {
                uniqueId = Int64(categoryContents.moduleType + categoryContents.categoryId)
                cellHeight = ceil(content_view_width * 0.4)
            }
        }
       
    }
    
    
    
    
    
    
    var albumTitleAttr: NSAttributedString?//标题
    var albumTitleAttrHeight: CGFloat = 0//高度
    var albunIntroAttr: NSAttributedString?//中间介绍的文字
    var albumIntroHeight: CGFloat = 0//中间介绍的高度
    var labelTingCountTop: CGFloat = 0//最后数量的y值
    var labelTingAttr: NSAttributedString?//最后一行文字
    var labelTingCountWidth: CGFloat = 0//最后一行的宽度
    
    var albumModel: XMNoveCategoryContentList_listModel?
    init(album: XMNoveCategoryContentList_listModel) {
        self.albumModel = album
        guard let uniqId = self.albumModel?.album?.albumId else {
            return
        }
        uniqueId = uniqId
        cellType = .albumTrack
        _layoutNoveAlbum()        
    }
    
    
    
    
    
    
}

extension XMNoveLayout {
    
    
    
    private func _layoutManWomenLove() {
        
        if let items = categoryContent?.lists {
            let color = UIColor.xm.dynamicRGB((130, 130, 130), (120, 120, 120))
            
            for item in items {
                if let models = item.nanNvLoveModels {
                    for (index, model) in models.enumerated() {
                        if index < 3 {
                            if let imageRank = NSAttributedString.addImage(UIImage(named: String(format: "find_classia_top_%ld", index + 1)), 0, CGSize(width: 0, height: 0)) {
                                model.topAttr = imageRank
                            }
                        }
                        
                        let mutableAttr = NSMutableAttributedString()
                        if let strAttr = NSAttributedString.addImage(UIImage(named: "find_paid_hear_red"), -1.5) {
                            mutableAttr.append(strAttr)
                            mutableAttr.addString(aString: " ")
                        }
                        let str = countOther(count: model.playsCounts)
                        mutableAttr.addString(aString: str)
                        mutableAttr.addAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 11), NSAttributedString.Key.foregroundColor: color], range: NSRange(location: 0, length: mutableAttr.length))
                        model.bottomAttr = mutableAttr
                        
                    }
                }
            }
        }
    }
    private func _layoutWeek() {
        let cellWidth = floor((content_view_width - 40) * 0.5)
        let cellImageViewHeight = ceil(cellWidth * 0.56)
        
        if let items = categoryContent?.lists {
            let nameColor = UIColor.xm.dynamicRGB((40, 40, 40), (200, 200, 200))
            for item in items {
                item.titleAttrHeight = 20
                if let title = item.title {
                    item.titleAttr = getAttring(aString: title, font: UIFont.boldSystemFont(ofSize: 13), color: nameColor)
                }
                
            }
        }
        
        cellHeight = 156 + cellImageViewHeight
    }
    
    private func _layoutNoveAlbum() {
        var albumHeight: CGFloat = 10
        let imageViewWidthHeight: CGFloat = UIDevice.isPad ? 140 : ceil(content_view_width * 0.3)
        let mutableTitleAttr = NSMutableAttributedString()
        if albumModel?.album?.serialState == 2 {
            if let imageOver = NSAttributedString.addImage(UIImage(named: "album_novel_finish"), -3, CGSize(width: 0, height: 0)) {
                mutableTitleAttr.append(imageOver)
            }
        }
        if let title = albumModel?.album?.title {
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
        
        if let intro = albumModel?.album?.intro {
            let font = UIFont.systemFont(ofSize: 13)
            let introMaxHeight = ceil(font.lineHeight * 2 + 3)
            let attrIntro = getAttring(aString: intro, font: font, color: UIColor.xm.dynamicRGB((110, 110, 110), (140, 140, 140)), lineSpace: 3)
            var attrIntroHeight = getStringRect(aString: attrIntro, width: width - 20)
            if attrIntroHeight > introMaxHeight {
                attrIntroHeight = introMaxHeight
            }
             albunIntroAttr = attrIntro
             albumIntroHeight = attrIntroHeight + 10
            
            albumHeight += 5 //到上面的距离
            albumHeight += albumIntroHeight
        }
        
        let attrBottomStr = NSMutableAttributedString()
        if let playCount = albumModel?.album?.playsCounts, playCount > 0 {
            if let tingImage = NSAttributedString.addImage(UIImage(named:"find_paid_hear_red"), -1.5, CGSize(width: 0, height: 0)) {
                attrBottomStr.append(tingImage)
            }
            attrBottomStr.addString(aString: countOther(count: playCount))
        }
        
        if let score = albumModel?.album?.albumScore {
            attrBottomStr.addString(aString: "      ")
            let star = scoreStar(score: score)
            if star > 0 {
                var jndex: Int = 0
                for index in 0..<(star - 1) {//全星星的
                    if let attrScoreStar = NSAttributedString.addImage(UIImage(named: "album_comment_full_star_new_yellow-1"), -2, CGSize(width: 11, height: 11)) {
                        attrBottomStr.append(attrScoreStar)
                    }
                    jndex = index
                }
                for num in 0..<(4 - jndex) {
                    if let attrScoreStar = NSAttributedString.addImage(UIImage(named: num == 0 ? "album_comment_half_star_new_yellow-1" : "album_comment_empty_star_new_yellow"), -2, CGSize(width: 11, height: 11)) {
                        attrBottomStr.append(attrScoreStar)
                    }
                }
                let scoreStr = NSAttributedString(string: " \(score)")
                attrBottomStr.append(scoreStr)
            }
        }
        if attrBottomStr.length > 0 {
           attrBottomStr.xm_addAttributes(UIFont.systemFont(ofSize: 10), color: UIColor.xm.dynamicRGB((100, 100, 100), (126, 126, 126)))
            labelTingCountWidth = attrBottomStr.size().width
            labelTingAttr = attrBottomStr
        }
        
        
        let imageViewBottom = imageViewWidthHeight + 10
        if imageViewBottom > (albumHeight + 20) {
            labelTingCountTop = imageViewBottom - 14
            albumHeight = imageViewBottom + 10
        }else {
            labelTingCountTop = albumHeight + xm_padding
            albumHeight = labelTingCountTop + 24 //14 自身高度 + 10底边留白
        }
        
        cellHeight = albumHeight
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    private func _layoutProject() {
        if let items = categoryContent?.lists {
            let font = UIFont.boldSystemFont(ofSize: 13)
            let color = UIColor.xm.dynamicRGB((50, 50, 50), (200, 200, 200))
            let cellWidth: CGFloat = floor((content_view_width - 10) * 0.5) - 20
            let topViewHeight: CGFloat = ceil((content_view_width - 10) * 0.2)
            
            for item in items {
                if let title = item.title {
                    let attr = getAttring(aString: title, font: font, color: color, lineSpace: 3)
                    var titleHeight = getStringRect(aString: attr, width: cellWidth)
                    if titleHeight > 40 {
                        titleHeight = 40
                    }
                    item.titleAttr = attr
                    item.titleAttrHeight = titleHeight
                }
            }
            cellHeight = topViewHeight + 60
        }
    }
    
    private func _layoutLive() {
        if let items = categoryContent?.lists {
            let nameFont = UIFont.systemFont(ofSize: 12)
            let nameColor = UIColor.xm.dynamicRGB((40, 40, 40), (200, 200, 200))
            let nickNameFont = UIFont.systemFont(ofSize: 10)
            let nickNameColor = UIColor.xm.dynamicRGB((160, 160, 160), (120, 120, 120))
            for item in items {
                let attrMutable = NSMutableAttributedString()
                if var title = item.name {
                    if title.count > 5 {
                        title = title.subString(to: 5) + "..."
                    }
                    attrMutable.addString(aString: title)
                    attrMutable.addAttributes([NSAttributedString.Key.font : nameFont, NSAttributedString.Key.foregroundColor: nameColor], range: NSRange(location: 0, length: title.count))
                }
                if let nickName = item.nickname {
                    attrMutable.addString(aString: "\n")
                    let nickNameAttr = getAttring(aString: nickName, font: nickNameFont, color: nickNameColor)
                    attrMutable.append(nickNameAttr)
                }
                let paragraphStyle = NSMutableParagraphStyle()
                 paragraphStyle.lineSpacing = 5
                attrMutable.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attrMutable.length))
                item.titleAttr = attrMutable
                var titleHeight = getStringRect(aString: attrMutable, width: 70)
                if titleHeight > 40 {
                    titleHeight = 40
                }
                item.titleAttrHeight = getStringRect(aString: attrMutable, width: 80)
                item.titleAttrHeight = titleHeight
                
            }
        }
    }
    
    private func _layoutHotFilm() {
        let filmAttr = NSMutableAttributedString()
        if let title = categoryContent?.title {
            filmAttr.addString(aString: "\(title) ")
        }
        if let imageAttr = NSAttributedString.addImage(UIImage(named: "liveRadioCellPlay"), -3, CGSize(width: 18, height: 18)) {
            filmAttr.append(imageAttr)
        }
        filmAttr.xm_addAttributes(UIFont.boldSystemFont(ofSize: 15), color: UIColor.white, lineSpace: 0)
        
        filmAttr.addString(aString: "\n")
        if let subTitle = categoryContent?.subtitle {
            let attr = getAttring(aString: subTitle, font: UIFont.systemFont(ofSize: 13), color: UIColor.colorWithrgba(100, 100, 100))
            filmAttr.append(attr)
        }
        let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = 5
        filmAttr.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: filmAttr.length))
        hotFilmAttr = filmAttr
        
        cellHeight = 85
        
        if let models = categoryContent?.lists?.first?.albums, models.count > 0 {
            let font = UIFont.systemFont(ofSize: 13)
            let color = UIColor.xm.dynamicRGB((40, 40, 40), (240, 240, 240))
            
            let cellWidth = UIDevice.isPad ? floor((content_view_width - 80) / 6) : floor((content_view_width - 40) / 3)
            let maxHeight = ceil(font.lineHeight * 2 + 3)
            let cell_Height = cellWidth + 60
            cellHeight += cell_Height
//                   let leftPadding: CGFloat = 10
//                   let medilePading: CGFloat = ceil(((content_view_width - cellWidth * 3) - 20) * 0.5)
            for album in models {
                if let title = album.title {
                    let attr = getAttring(aString: title, font: font, color: color, lineSpace: 3)
                    var titleHeight = getStringRect(aString: attr, width: cellWidth)
                    if titleHeight > maxHeight {
                        titleHeight = maxHeight
                    }
                    album.titleAttr = attr
                    album.titleHeight = titleHeight
                }
            }
        }
    }
    
    private func _layoutKeyWordContent() {
        
        if let lists = categoryContent?.lists {
            
            if lists.count > 8 {
                var newKeyWords = [XMNoveCategoryContentList_listModel]()
                for index in 0..<7 {
                    newKeyWords.append(lists[index])
                }
                let lastKeyWord = XMNoveCategoryContentList_listModel()
                lastKeyWord.id = 00001
                lastKeyWord.title = "▼"
                newKeyWords.append(lastKeyWord)
                upkeyWordModels = newKeyWords
                
                newKeyWords = lists
                lastKeyWord.title = "▲"
                newKeyWords.append(lastKeyWord)
                downkeyWordModels = newKeyWords
            }else {
                upkeyWordModels = lists
            }
        }
        funcCellWidth = floor((content_view_width - 30) * 0.25)
        cellHeight = 30
    }

    private func _layoutAlbums() {
        let cellDetailWidth = UIDevice.isPad ? floor((content_view_width - 70) / 6) : floor((content_view_width - 40) / 3)
        let bottomHeight: CGFloat = (categoryContent?.loopCount == 2) ? 76 : 40
        let cell_Height = ceil((cellDetailWidth + 60) * (UIDevice.isPad ? 1 : 2) + bottomHeight)
        cellHeight = cell_Height
        let font = UIFont.systemFont(ofSize: 13)
        let color = UIColor.xm.dynamicRGB((40, 40, 40), (240, 240, 240))
        let maxHeight = ceil(font.lineHeight * 2 + 3)
        
        if let albums = categoryContent?.lists {
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
    
    private func _layoutFousImage() {
        cellHeight = ceil(content_view_width * 0.4)
        
        if let fourceImages = fousImage?.focusImageDatas {
            var urlStrings = [String]()
            for fource in fourceImages {
                if let cover = fource.cover {
                    urlStrings.append(cover)
                }
            }
            fourceImageUrls = urlStrings
        }
    }
}

extension XMNoveLayout: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        
        return uniqueId as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let layout = object as? XMNoveLayout else {
            return false
        }
        return uniqueId == layout.uniqueId
    }
    
    
}
