//
//  XMFindRecdLayout.swift
//  himalaya
//
//  Created by Farben on 2020/9/3.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import IGListKit
import YYText



class XMFindRecdLayout {
    
    enum XMFindRecdLayoutCellType {
        case questionBigTitle
        case track
        case album
        case contentText
        case cycle
        case toolBarBottom
        case picture
        case video
        case headerProfile
        case card
        case hotComment
        case questionnaireHeader
        case questionnairecell
        case questionnaireFooter
        
        case room
        case unKonw
    }
    
    var uniqueId: Int64 = 0
    
    lazy var rows = [XMFindRecdSectionRow]()
    
    
    var cellHeight: CGFloat = 0
    var leverTitle: String?
    

    var noticeHeadModel: XMCycleModel?    
    
    
    
    
    var findItem: XMFindRecmListModel?
    init(model: XMFindRecmListModel) {
        self.findItem = model
        uniqueId = findItem?.item?.id ?? 100
        if findItem?.item?.bizSource == "ANSWER" ||
            findItem?.item?.bizSource == "QUESTION" {
            _layoutQuestion()
        }else if findItem?.type == "ADVERTISE" {
            _layoutAdvertist()
        }else if findItem?.type == "CommunityRecommendation" {
            _layoutCommunityRecommendation()
        }else {
            _layoutNormalItem()
        }
    }
    
    init() {
        uniqueId = 1234566
    }
}

extension XMFindRecdLayout {
    
    private func _layoutCommunityRecommendation() {
        if let cycles = findItem?.cycles {
            uniqueId = getTimeStamp() + Int64(arc4random() % 100 + 1)
            leverTitle = "可能感兴趣的圈子"
            cellHeight = 180
            for cycle in cycles {
                let attrMutable = NSMutableAttributedString()
                var name = cycle.name ?? ""
                if name.count > 6 {
                    name = name.subString(to: 6)
                }
                attrMutable.addString(aString: name)
                attrMutable.yy_font = UIFont.boldSystemFont(ofSize: 14)
                attrMutable.yy_color = UIColor.xm.dynamicRGB((50, 50, 50), (200, 200, 200))
                attrMutable.addString(aString: "\n")
                
                let length = attrMutable.length
                let countStr = "成员: \(countOther(count: Int64(cycle.memberCount)))"
                attrMutable.addString(aString: countStr)
                attrMutable.yy_setFont(UIFont.systemFont(ofSize: 12), range: NSRange(location: length, length: countStr.count))
                attrMutable.yy_setColor(UIColor.colorWithrgba(131, 131, 131), range: NSRange(location: length, length: countStr.count))
                
                attrMutable.yy_lineSpacing = 10
                attrMutable.yy_alignment = .center
                cycle.attrTitle = attrMutable
            }
        }
    }
    
    private func _layoutAdvertist() {
//        print(findItem.item?.type)
//        print(findItem.item?.advertiseContent?.roomType)
        if findItem?.item?.type == "LIVE_ROOM" &&
            findItem?.item?.advertiseContent?.roomType == "VOICE_ROOM" {
            uniqueId = getTimeStamp() + Int64(arc4random() % 100 + 1)
            leverTitle = "语音房"
            if let rooms = findItem?.item?.advertiseContent?.rooms {
                let detailCellWidth: CGFloat = 100
                let detailCellHeight: CGFloat = 155
                cellHeight = detailCellHeight
                for room in rooms {
                    var roomName = room.roomName ?? ""
                    if roomName.count > 5 {
                        roomName = roomName.subString(to: 5) + "..."
                    }
                    let titleAttr = NSMutableAttributedString(string: roomName)
                    titleAttr.addAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.xm.dynamicRGB((50, 50, 50), (200, 200, 200))], range: NSRange(location: 0, length: titleAttr.length))
                    titleAttr.addString(aString: "\n")
                    
                    let nickName = room.anchorName ?? ""
                    let nameAttr = NSMutableAttributedString(string: nickName)
                    nameAttr.addAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 10), NSAttributedString.Key.foregroundColor: UIColor.xm.dynamicRGB((150, 150, 150), (130, 130, 130))], range: NSRange(location: 0, length: nameAttr.length))
                    titleAttr.append(nameAttr)
                    
                    let paragraphStyle = NSMutableParagraphStyle()
                    paragraphStyle.lineSpacing = 5
                    titleAttr.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: titleAttr.length))
                    
                    let labelHeight = getStringRect(aString: titleAttr, width: detailCellWidth - 20)
                    room.titleAttr = titleAttr
                    room.titleAttrHeight = labelHeight
                    
                    let countAttr = NSMutableAttributedString(string: "  ")
                    if let imageAttr = NSAttributedString.addImage(UIImage(named: "live_wave0"), -2, CGSize(width: 14, height: 14)) {
                        countAttr.append(imageAttr)
                    }
                    var titleCount = " \(room.viewerNum)"
                    if room.viewerNum > 1000 {
                        titleCount = String(format: " %.1f千", CGFloat(room.viewerNum) / 1000)
                    }else if room.viewerNum > 10000 {
                        titleCount = String(format: " %.1f万", CGFloat(room.viewerNum) / 10000)
                    }
                    countAttr.addString(aString: titleCount)
                    countAttr.yy_font = UIFont.systemFont(ofSize: 10)
                    countAttr.yy_color = UIColor.white
                    room.countAttr = countAttr
                }
            }
        }
    }
    
//    private func _layoutVideo() {
//        _layoutHeaderProfile()
//
//        _layoutCommonBigText() //大标题
//
//        _layoutCommonContentText() //内容
//
//        _layoutCommonVideo()
//
//        _layoutCommonCycle()
//
//        _layoutCommonBottom()
//    }
    
    private func _layoutNormalItem() {
        
        _layoutHeaderProfile() //头部
        
        _layoutCommonBigText() //大标题
        
        _layoutCommonContentText() //内容
                
//        _layoutCommonPics() //图片
        
        _layoutCommonCycle() //圈子
        
        _layoutHotComment()
        
        _layoutCommonBottom() //toolBar
    }
    
    private func _layoutQuestion() {
       
        if let questionStr = findItem?.item?.contentModel?.title {
            var row = XMFindRecdSectionRow()
            let titleAttr = NSMutableAttributedString()
            if let image = UIImage(named: findItem?.item?.bizSource == "ANSWER" ? "anwser_question" : "tiwen_question") {
                let imageStr = NSAttributedString.xm_attachment(fontSize: 17, image: image, shrink: false)
                titleAttr.append(imageStr)
            }
            titleAttr.addString(aString: questionStr)
            titleAttr.yy_font = UIFont.boldSystemFont(ofSize: 17)
            titleAttr.yy_color = UIColor.xm.dynamicRGB((10, 10, 10), (245, 245, 245))
            titleAttr.yy_lineSpacing = 7
            
//            let titleAttrHeight = getStringRect(aString: titleAttr, width: content_view_width)
            
            row.contentLayout = YYTextLayout(containerSize: CGSize(width: content_view_width, height: CGFloat(HUGE)), text: titleAttr)
            if row.contentLayout == nil {
                return
            }
//            row.titleAttr = titleAttr
            row.contentHeight = row.contentLayout!.textBoundingSize.height
            
            if let userName = findItem?.item?.userInfo?.nickname {
                let leftStr = userName + "  "
                
                let timeStr = timeStampToInt64(timeStamp: findItem?.item?.createdTs ?? 0)
                let rightStr = timeStr + (findItem?.item?.bizSource == "ANSWER" ? " · 回答了问题" : " · 发布了提问")
                let attr = NSMutableAttributedString(string: leftStr + rightStr)
                attr.yy_color = UIColor.xm.dynamicRGB((160, 160, 160), (130, 130, 130))
                attr.yy_setFont(UIFont.systemFont(ofSize: 14), range: NSRange(location: 0, length: leftStr.count))
                attr.yy_setFont(UIFont.systemFont(ofSize: 12), range: NSRange(location: leftStr.count, length: rightStr.count))
                row.contentAttr = attr
            }
            
            row.avatar = findItem?.item?.userInfo?.avatar
            row.cellType = .questionBigTitle
            row.cellHeight = row.contentHeight + 50
            rows.append(row)
        }
        
        _layoutCommonContentText()
        
        _layoutCommonCycle()
        
        _layoutHotComment()
        
        _layoutCommonBottom()
       
    }
    
    
    private func _layoutHeaderProfile() {
        if let _ = findItem?.item?.userInfo {
            var row = XMFindRecdSectionRow()
            row.cellType = .headerProfile
            row.cellHeight = 70
            rows.append(row)
            if findItem?.item?.recReason == nil {
                if let timerInt = findItem?.item?.createdTs {
                    let str = Const.updateTimeToCurrennTime(timeStamp: timerInt)
                    findItem?.item?.recReason = str
                    
                }
            }
        }
    }
    
    private func _layoutCommonBigText() {
        if let bigTitle = findItem?.item?.contentModel?.title {
            var row = XMFindRecdSectionRow()
            let attr = NSMutableAttributedString(string: bigTitle)
            attr.yy_font = UIFont.boldSystemFont(ofSize: 17)
            attr.yy_color = UIColor.xm.dynamicRGB((10, 10, 10), (245, 245, 245))
            attr.yy_lineSpacing = 5
            row.contentLayout = YYTextLayout(containerSize: CGSize(width: content_view_width, height: CGFloat(HUGE)), text: attr)
            if row.contentLayout == nil {
                return
            }
            row.contentHeight = row.contentLayout!.textBoundingSize.height
            row.cellHeight = row.contentHeight + 10
            row.cellType = .contentText
            rows.append(row)
        }
    }
    
    private func _layoutCommonContentText() {
        
        if let nodes = findItem?.item?.contentModel?.nodes, nodes.count > 0 {
            let highlightBorder = YYTextBorder()
            highlightBorder.insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            highlightBorder.cornerRadius = 2
            highlightBorder.fillColor = UIColor.colorWidthHexString(hex: "bfdffe")
            for node in nodes {
                if node.type == "text" {
                    if let contentText = node.nodeDetail?.content {
                        var row = XMFindRecdSectionRow()
                        let attr = NSMutableAttributedString(string: contentText)
                         attr.yy_color = UIColor.xm.dynamicRGB((50, 50, 50), (200, 200, 200))
                        
                        let quotationMarkResults = regexQuotationMark.matches(in: attr.string, options: [], range: attr.yy_rangeOfAll())
                        for quotationMark in quotationMarkResults {
                            if quotationMark.range.location == NSNotFound && quotationMark.range.length <= 1 {
                                continue
                            }
                            if attr.yy_attribute(YYTextHighlightAttributeName, at: UInt(quotationMark.range.location)) == nil {
                                let newRange = NSRange(location: quotationMark.range.location + 1, length: quotationMark.range.length - 2)
                                attr.yy_setColor(UIColor.colorWidthHexString(hex: "527ead"), range: newRange)
                                let highlight = YYTextHighlight()
//                                highlight.setBorder(highlightBorder)
                                highlight.setBackgroundBorder(highlightBorder)
                                attr.yy_setTextHighlight(highlight, range: newRange)
                            }
                        }
                        
                        let topicResults = regexTopic.matches(in: attr.string, options: [], range: attr.yy_rangeOfAll())
                        for topic in topicResults {
                            if topic.range.location == NSNotFound && topic.range.length <= 1 {
                                continue
                            }
                            if attr.yy_attribute(YYTextHighlightAttributeName, at: UInt(topic.range.location)) == nil{
                                attr.yy_setColor(UIColor.colorWithrgba(97, 159, 210), range: topic.range)
                                let highlight = YYTextHighlight()
                                highlight.setBackgroundBorder(highlightBorder)
                                attr.yy_setTextHighlight(highlight, range: topic.range)
                            }
                        }
                        
                        
                        
                        
                        attr.yy_font = UIFont.boldSystemFont(ofSize: 15)
                        attr.yy_lineSpacing = 7
                        let container = YYTextContainer(size: CGSize(width: content_view_width, height: CGFloat(HUGE)))
                        container.maximumNumberOfRows = 3
                        container.truncationType = .end
                        let str = NSMutableAttributedString(string: "...全文")
                        str.yy_color = UIColor.colorWithrgba(97, 159, 210)
                            
                        str.yy_setColor(UIColor.xm.dynamicRGB((70, 70, 70), (190, 190, 190)), range: NSRange(location: 0, length: 3))
                        str.yy_font = UIFont.systemFont(ofSize: 15)
                        container.truncationToken = str
                        row.contentLayout = YYTextLayout(container: container, text: attr)
                        if row.contentLayout == nil {
                            return
                        }
                        row.contentHeight = row.contentLayout!.textBoundingSize.height
                        row.cellHeight = row.contentHeight + 10
                        row.cellType = .contentText
                        row.node = node
                        rows.append(row)
                    }
                }else if node.type == "track" {
                    var row = XMFindRecdSectionRow()
                    row.cellHeight = 95
                    row.cellType = .track
                    if let title = node.nodeDetail?.albumTitle {
                        let mutableAttr = NSMutableAttributedString()
                        if let attrImage = NSAttributedString.addImage(UIImage(named: "find_sound_album"), -1, CGSize(width: 10, height: 10)) {
                            mutableAttr.append(attrImage)//需要带圆圈的图片
                        }
                        mutableAttr.addString(aString: " \(title)")
                        mutableAttr.addAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.xm.dynamicRGB((160, 160, 160), (165, 165, 165))], range: NSRange(location: 0, length: mutableAttr.length))
                        row.contentAttr = mutableAttr
                    }
//                    find_play_count
                    let bottomAttr = NSMutableAttributedString()
                    if let playCount = node.nodeDetail?.playCount, playCount > 0 {
                        if let attrImage = NSAttributedString.addImage(UIImage(named: "find_play_count"), -1.5, CGSize(width: 12, height: 12)) {
                            bottomAttr.append(attrImage)//需要带圆圈的图片
                        }
                        bottomAttr.addString(aString: countOther(count: playCount))
                    }
                    
                    if let time = node.nodeDetail?.duration {
                        bottomAttr.addString(aString: "      ")
//                        Const find_video_time
                        if let attrImage = NSAttributedString.addImage(UIImage(named: "find_video_time"), -1.5, CGSize(width: 12, height: 12)) {
                            bottomAttr.append(attrImage)//需要带圆圈的图片
                        }
                        bottomAttr.addString(aString: " " + Const.getMMSSFromSS(totalTime: time))
                    }
                    bottomAttr.yy_font = UIFont.systemFont(ofSize: 12)
                    bottomAttr.yy_color = UIColor.xm.dynamicRGB((160, 160, 160), (200, 200, 200))
                    row.titleAttr = bottomAttr
                    
                    row.node = node
                    rows.append(row)
                }else if node.type == "video" {
                    if let videoModel = node.nodeDetail {
                        var row = XMFindRecdSectionRow()
                        row.cellType = .video
                        if videoModel.width <= 0 || videoModel.height <= 0 {
                            row.contentHeight = ceil(content_view_width * 0.5)
                        }else {
                            if videoModel.width > videoModel.height {
                                row.contentHeight = ceil((content_view_width * videoModel.height / videoModel.width))
                            }else {
                                row.contentHeight = ceil(content_view_width * 0.6)
                            }
                        }
                        row.cellHeight = row.contentHeight + 10
                        row.node = node
                        rows.append(row)
                    }
                }else if node.type == "album" {
                    var row = XMFindRecdSectionRow()
                    if let score = node.nodeDetail?.score, score > 0 {
                        let mutableAttr = NSMutableAttributedString()
                        
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
                        }
                        
                        mutableAttr.addString(aString: " \(score)分")
                        mutableAttr.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.xm.dynamicRGB((100, 100, 100), (126, 126, 126)), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)], range: NSRange(location: 0, length: mutableAttr.length))
                        row.contentAttr = mutableAttr
                        
                        let bottomAttr = NSMutableAttributedString()
                        if let playCount = node.nodeDetail?.playCount, playCount > 0 {
                            if let attrImage = NSAttributedString.addImage(UIImage(named: "find_play_count"), -1.5, CGSize(width: 12, height: 12)) {
                                bottomAttr.append(attrImage)//需要带圆圈的图片
                            }
                            bottomAttr.addString(aString: countOther(count: playCount))
                        }
                        
                        if let listionCount = node.nodeDetail?.trackCount {
                            bottomAttr.addString(aString: "      ")
                            if let attrImage = NSAttributedString.addImage(UIImage(named: "newer_rec_album_tracks"), -2, CGSize(width: 12, height: 12)) {
                                bottomAttr.append(attrImage)//需要带圆圈的图片
                            }
                            bottomAttr.addString(aString: " \(listionCount)")
                        }
                        bottomAttr.yy_font = UIFont.systemFont(ofSize: 11)
                        bottomAttr.yy_color = UIColor.xm.dynamicRGB((160, 160, 160), (200, 200, 200))
                        row.titleAttr = bottomAttr
                    }
                    row.cellHeight = 95
                    row.cellType = .album
                    row.node = node
                    rows.append(row)
                }else if node.type == "pic" {
                    if let pics = node.pictureModels, pics.count > 0 {
                        var row = XMFindRecdSectionRow()
                        row.cellType = .picture
                        row.node = node
                        let margin: CGFloat = 3
                        
                        switch pics.count {
                                 case 1:
                                     let picModel = pics[0]
                                     if picModel.width == 0 || picModel.height == 0 {
                                        row.picFrames.append(CGRect(x: xm_padding, y: 10, width: 120, height: 120))
                                         return
                                     }
                                     var v_width: CGFloat = 0
                                     var v_height: CGFloat = 0
                                     
                                     if picModel.width > picModel.height {
                                        let maxWidth: CGFloat = content_view_width * 0.7
                                         v_width = picModel.width > maxWidth ? maxWidth : picModel.width
                                        if picModel.width > picModel.height * 3 {//横长图
                                            v_height = content_view_width * 0.3
                                        }else {
                                            v_height = v_width * picModel.height / picModel.width
                                        }
                                     }else {
                                        let picMaxHeight: CGFloat = content_view_width * 0.8
                                         v_height = picModel.height > picMaxHeight ? picMaxHeight : picModel.height
                                        if picModel.height > (picModel.width * 3) { //竖长图
                                            v_width = ceil(content_view_width * 0.3)
                                        }else {
                                            v_width = v_height * picModel.width / picModel.height
                                        }
                                     }
                                     row.picFrames.append(CGRect(x: xm_padding, y: 10, width: ceil(v_width), height: ceil(v_height)))
                                     row.cellHeight = v_height + 10
                                     break
                                 case 2, 3:
                                    let picWH = ceil((content_view_width - margin * CGFloat((pics.count - 1))) / CGFloat(pics.count))
                                    for index in 0..<pics.count {
                                        let x = xm_padding + (picWH + margin) * CGFloat(index)
                                        row.picFrames.append(CGRect(x: x, y: 10, width: picWH, height: picWH))
                                    }
                                    row.cellHeight = picWH + 10
                                     break
                                 case 4:
                                    let firstPicH = ceil(content_view_width * 0.5)
                                    let otherPicWH = ceil((content_view_width - margin * 2) / 3)
                                    let y = firstPicH + 13
                                    row.cellHeight = y + otherPicWH
                                    for index in 0..<pics.count {
                                        if index == 0 {
                                            row.picFrames.append(CGRect(x: xm_padding, y: 10, width: content_view_width, height: firstPicH))
                                        }else {
                                            let x = xm_padding + (otherPicWH + margin) * CGFloat(index - 1)
                                            row.picFrames.append(CGRect(x: x, y: y, width: otherPicWH, height: otherPicWH))
                                        }
                                    }
                                     break
                                 case 5:
                                    let picFirstWH = ceil((content_view_width - margin) * 0.5)
                                    let otherPicWH = ceil((content_view_width - margin * 2) / 3)
                                    let y = picFirstWH + 13
                                    row.cellHeight = y + otherPicWH
                                    for index in 0..<pics.count {
                                        if index < 2 {
                                            let x = xm_padding + (picFirstWH + margin) * CGFloat(index)
                                            row.picFrames.append(CGRect(x: x, y: 10, width: picFirstWH, height: picFirstWH))
                                        }else {
                                            let x = xm_padding + (otherPicWH + margin) * CGFloat(index - 2)
                                            row.picFrames.append(CGRect(x: x, y: y, width: otherPicWH, height: otherPicWH))
                                        }
                                    }
                                     break
                                 default:
                                     let picWH = ceil((content_view_width - margin * 2) / 3)
                                     row.cellHeight = picWH * 2 + 13
                                     for index in 0..<6 {
                                        let _row = index / 3
                                        let col = index % 3
                                        let picX = xm_padding + (picWH + margin) * CGFloat(col)
                                        let picY = 10 + (picWH + margin) * CGFloat(_row)
                                        row.picFrames.append(CGRect(x: picX, y: picY, width: picWH, height: picWH))
                                     }
                                     break
                                 }
                                 rows.append(row)
                    }
                }else if node.type == "vote" {
                    if let title = node.nodeDetail?.title {
                        var row = XMFindRecdSectionRow()
                        row.cellType = .questionnaireHeader
                        row.contentAttr = getAttring(aString: title, font: UIFont.boldSystemFont(ofSize: 14), color: UIColor.xm.dynamicRGB((50, 50, 50), (200, 200, 200)))
                        row.titleAttr = getAttring(aString: "\(node.nodeDetail?.voterCount ?? 0)人参与·最多选择3项", font: UIFont.systemFont(ofSize: 12), color: UIColor.xm.dynamicRGB((160, 160, 160), (180, 180, 180)))
                        row.cellHeight = 80
                        rows.append(row)                    
                    }
                    
                    
                    if let voters = node.nodeDetail?.voterModels {
                        for (index, voter) in voters.enumerated() {
                            if index < 4 {
                                var row = XMFindRecdSectionRow()
                                row.text = voter.content
                                
                                row.cellType = .questionnairecell
                                row.cellHeight = 45
                                rows.append(row)
                            }else {
//                                var row = XMFindRecdSectionRow()
//                                row.text = voter.content
//                                row.cellType = .questionnairecell
//                                row.cellHeight = 45
//                                voteRows.append(row)
                            }
                        }
//                        if voters.count > 4 {
//                            voteCellLastIndex = rows.count
//                        }
                    }
                    
                    var row = XMFindRecdSectionRow()
                    row.cellType = .questionnaireFooter
                    row.cellHeight = 65
                    rows.append(row)
                    
                    
                }
                
            }
        }
        
     
    }
    
    private func _layoutHotComment() {
        if let content = findItem?.item?.hotComment?.content {
            var row = XMFindRecdSectionRow()
            row.cellType = .hotComment
            row.avatar = findItem?.item?.hotComment?.userInfo?.avatar
            row.contentAttr = getAttring(aString: findItem?.item?.userInfo?.nickname ?? "喜马拉雅", font: UIFont.boldSystemFont(ofSize: 14), color: UIColor.xm.dynamicRGB((30, 30, 30), (200, 200, 200)))
            if let praiseCount = findItem?.item?.hotComment?.praiseCount {
                row.titleAttr = getAttring(aString: "\(praiseCount)", font: UIFont.systemFont(ofSize: 12), color: UIColor.xm.dynamicRGB((160, 160, 160), (125, 125, 125)))
            }
            
            let attrContent = NSMutableAttributedString(string: content)
//            attrContent.yy_font = UIFont(name: "STHeitiSC-Light", size: 14)
            attrContent.yy_font = UIFont.systemFont(ofSize: 14)
            attrContent.yy_color = UIColor.xm.dynamicRGB((0, 0, 0), (130, 130, 130))
            attrContent.yy_lineSpacing = 5
            
            
            
            
//            attrContent.yy_maximumLineHeight
            
            
           let container = YYTextContainer(size: CGSize(width: content_view_width - 70, height: CGFloat(HUGE)))
           container.maximumNumberOfRows = 2
           container.truncationType = .end
            
            let str = NSMutableAttributedString(string: "...")
            str.yy_color = UIColor.xm.dynamicRGB((0, 0, 0), (130, 130, 130))
            str.yy_font = UIFont.systemFont(ofSize: 14)
            container.truncationToken = str
            
            row.contentLayout = YYTextLayout(container: container, text: attrContent)
            if row.contentLayout == nil {
                return
            }
            row.contentHeight = ceil(row.contentLayout!.textBoundingSize.height)
            row.cellHeight = row.contentHeight + 70
            rows.append(row)
            
        }
    }
    
//    private func _layoutCommonVideo() {
//        if let videoModel = findItem.item?.contentModel?.nodes?.last?.nodeDetail {
//            var row = XMFindRecdSectionRow()
//            row.cellType = .video
//            if videoModel.width <= 0 || videoModel.height <= 0 {
//                row.contentHeight = ceil(content_view_width * 0.5)
//            }else {
//                if videoModel.width > videoModel.height {
//                    row.contentHeight = ceil((content_view_width * videoModel.height / videoModel.width))
//                }else {
//                    row.contentHeight = content_view_width
//                }
//            }
//            row.cellHeight = row.contentHeight + 10
//            rows.append(row)
//            
//        }
//    }

    
//    private func _layoutCommonPics() {
//        if let picModels = findItem.item?.contentModel?.nodes?.last?.pictureModels, picModels.count > 0 {
//            var row = XMFindRecdSectionRow()
//            row.cellType = .picture
//
//            switch picModels.count {
//            case 1:
//                let picModel = picModels[0]
//                if picModel.width == 0 || picModel.height == 0 {
//                    picFrames.append(CGRect(x: xm_padding, y: 10, width: 120, height: 120))
//                    return
//                }
//                var v_width: CGFloat = 0
//                var v_height: CGFloat = 0
//                let maxWidth: CGFloat = content_view_width * 0.7
//                if picModel.width > picModel.height {
//                    v_width = picModel.width > maxWidth ? maxWidth : picModel.width
//                    v_height = v_width * picModel.height / picModel.width
//                }else {
//                    v_height = picModel.height > maxWidth ? maxWidth : picModel.height
//                    v_width = v_height * picModel.width / picModel.height
//                }
//                picFrames.append(CGRect(x: xm_padding, y: 10, width: ceil(v_width), height: ceil(v_height)))
//                row.cellHeight = v_height + 10
//                break
//            case 2:
//                break
//            case 3:
//                break
//            case 4:
//                break
//            case 5:
//                break
//            default:
//
//                break
//            }
//            rows.append(row)
//        }
//    }
    
    private func _layoutCommonCycle() {
        if let cycleTitle = findItem?.item?.contextModel?.community?.name {
            var row = XMFindRecdSectionRow()
            let strLeft = "来自圈子: "
            let strRight = cycleTitle
            let attrCycle = NSMutableAttributedString(string: strLeft + strRight)
            attrCycle.yy_font = UIFont.systemFont(ofSize: 13)
            attrCycle.yy_setColor(UIColor.xm.dynamicRGB((130, 130, 130), (130, 130, 130)), range: NSRange(location: 0, length: strLeft.count))
            attrCycle.yy_setColor(UIColor.colorWithrgba(126, 185, 248), range: NSRange(location: strLeft.count, length: strRight.count))
            let highlight = YYTextHighlight()
            attrCycle.yy_setTextHighlight(highlight, range: NSRange(location: strLeft.count, length: strRight.count))
            let container = YYTextContainer(size: CGSize(width: content_view_width, height: 9999))
            container.maximumNumberOfRows = 1
            row.contentLayout = YYTextLayout(container: container, text: attrCycle)
            if row.contentLayout == nil {
                return
            }
            row.cellType = .cycle
            row.cellHeight = 30
            rows.append(row)
        }
    }
    
    private func _layoutCommonBottom() {
        var row = XMFindRecdSectionRow()
        row.cellType = .toolBarBottom
        row.cellHeight = 50
        rows.append(row)
    }
}

extension XMFindRecdLayout: ListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        
        return uniqueId as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let layout = object as? XMFindRecdLayout else {
            return false
        }
        return uniqueId == layout.uniqueId && findItem === layout.findItem
    }
}

struct XMFindRecdSectionRow {
    
    var contentHeight: CGFloat = 0
    var cellHeight: CGFloat = 0
    var contentLayout: YYTextLayout?
    var contentAttr: NSAttributedString?
    var titleAttr: NSAttributedString?
    
    lazy var picFrames = [CGRect]()
    
    var node: XMFindRecmListItemContentNodeModel?
    
    var avatar: String?
    var cellType = XMFindRecdLayout.XMFindRecdLayoutCellType.unKonw
    
    var text: String?
    
    
}
