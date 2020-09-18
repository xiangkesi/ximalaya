//
//  XMHQGLayout.swift
//  himalaya
//
//  Created by Farben on 2020/9/16.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import IGListKit

class XMHQGLayout {
    
    enum XMCellType {
        case square
        case recommend
        case focus
        case categoryWord
        case unKnow
    }
    var cellType: XMCellType = .unKnow
    var cellHeight: CGFloat = 0
    
    var banderUrls: [String]?
    
    var uniqueId: Int = 0
    
    var resultModule: XMHQGModulesModel?
    init?(_ module: XMHQGModulesModel) {
        uniqueId = module.moduleId
        resultModule = module
        
        switch resultModule?.moduleType {
        case "square":
            cellType = .square
            cellHeight = 100
        case "recommend":
            cellType = .recommend
            _layoutGuessLike()
        case "focus":
            cellType = .focus
            _layoutBander()
        default:
            break
        }
    }
    
    
    var words: [XMHQGTitleModel]?
    lazy var albumLayouts = [XMHQGAlbumLayout]()
    init(titleModels: [XMHQGTitleModel]?) {
        if titleModels == nil {
            return
        }
        cellType = .categoryWord
        uniqueId = 605
        words = titleModels
    }
}

extension XMHQGLayout {
    
    private func _layoutAlbum() {
        
    }
    
    private func _layoutGuessLike() {
        if let albums = resultModule?.albums, albums.count > 0 {
            let cellDetailWidth = UIDevice.isPad ? floor((content_view_width - 70) / 6) : floor((content_view_width - 40) / 3)
            let cell_height = ceil((cellDetailWidth + 60) * (UIDevice.isPad ? 1 : 2) + 76)
            let font = UIFont.systemFont(ofSize: 13)
            let color = UIColor.xm.dynamicRGB((40, 40, 40), (240, 240, 240))
            let maxHeight = font.lineHeight * 2 + 3
            for album in albums {
                let attr = getAttring(aString: album.title!, font: font, color: color, lineSpace: 3)
                var labelHeight = getStringRect(aString: attr, width: cellDetailWidth)
                if labelHeight > maxHeight {
                    labelHeight = maxHeight
                }
                album.titleAttr = attr
                album.titleAttrHeight = labelHeight
            }
            cellHeight = cell_height
        }
    }
    
    private func _layoutBander() {
        if let banders = resultModule?.focusPicture?.picModels, banders.count > 0 {
            var urlStrs = [String]()
            for bander in banders {
                urlStrs.append(bander.cover ?? "")
            }
            banderUrls = urlStrs
            cellHeight = ceil(content_view_width * 0.4)
        }
    }
}

extension XMHQGLayout: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return uniqueId as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        
        guard let model = object as? XMHQGLayout else {
            return false
        }
        return uniqueId == model.uniqueId
    }
    
    
}


class XMHQGAlbumLayout {
    var cellType: XMCellType = .unKnow
    
    
    var cellHeight: CGFloat = 150
    
    
    var albumTitleAttr: NSAttributedString?//标题
    var albumTitleAttrHeight: CGFloat = 0//高度
    var albunIntroAttr: NSAttributedString?//中间介绍的文字
    var albumIntroHeight: CGFloat = 0//中间介绍的高度
    var labelTingCountTop: CGFloat = 0//最后数量的y值
    var labelTingAttr: NSAttributedString?//最后一行文字
    var labelTingCountWidth: CGFloat = 0//最后一行的宽度
    
    var resultAlbum: XMHQGAlbumModel
    init(album: XMHQGAlbumModel) {
        resultAlbum = album
        _layout()
    }
}

extension XMHQGAlbumLayout {
    
    private func _layout() {
        
        if resultAlbum.itemType == "ALBUM" {
            cellType = .album
            _layoutAlbumAndTrack()
        }else if resultAlbum.itemType == "TRACK" {
            cellType = .track
            _layoutAlbumAndTrack()
        }else if resultAlbum.itemType == "MODULE" {
            if resultAlbum.albumData?.moduleType == "custom_album" {
                if resultAlbum.albumData?.cardClass == "PICTURE" {
                    cellType = .module(.picture)
                    cellHeight = ceil(content_view_width * 0.384)
                }
            }else if resultAlbum.albumData?.moduleType == "rank_list" {
                cellType = .module(.rank_list)
                cellHeight = 380
            }else if resultAlbum.albumData?.moduleType == "anchor_rank_list" {
                cellType = .module(.star)
                cellHeight = ceil(content_view_width / 3 + 30) * 2 + 50
            }
        }
    }
    
    
    private func _layoutAlbumAndTrack() {
        var albumHeight: CGFloat = 10
        let imageViewWidthHeight: CGFloat = UIDevice.isPad ? 140 : ceil(content_view_width * 0.3)
        let mutableTitleAttr = NSMutableAttributedString()
        if resultAlbum.serialState == 2 {//完结 56 32
            if let imageOver = NSAttributedString.addImage(UIImage(named: "album_novel_finish"), -3, CGSize(width: 0, height: 0)) {
                mutableTitleAttr.append(imageOver)
            }
        }
        if let title = resultAlbum.title {
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
        
        if let intro = resultAlbum.intro {
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
           if resultAlbum.playsCounts > 0 {
               if let tingImage = NSAttributedString.addImage(UIImage(named:"find_paid_hear_red"), -1.5, CGSize(width: 0, height: 0)) {
                   attrBottomStr.append(tingImage)
               }
            attrBottomStr.addString(aString: countOther(count: resultAlbum.playsCounts))
           }
           if resultAlbum.tracks > 0 {
               attrBottomStr.addString(aString: "     ")
               if let trackImage = NSAttributedString.addImage(UIImage(named: "find_sound_count"), -1.5, CGSize(width: 0, height: 0)) {
                   attrBottomStr.append(trackImage)
               }
               attrBottomStr.addString(aString: "\(resultAlbum.tracks)")
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
               
           if let subTitle = resultAlbum.albumTitle {
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
           
           if resultAlbum.playCount > 0 {
               attrBottomStr.addString(aString: "     ")
               if let tingImage = NSAttributedString.addImage(UIImage(named:"find_paid_hear_red"), -1.5, CGSize(width: 0, height: 0)) {
                   attrBottomStr.append(tingImage)
               }
               attrBottomStr.addString(aString: " \(resultAlbum.playCount)")
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
