//
//  ShortVideoLayout.swift
//  himalaya
//
//  Created by Farben on 2020/8/14.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import UIKit

class ShortVideoLayout {
    
    var video: ShortVideoItemsModel?
    
    var cellSize: CGSize = CGSize.zero
    
    var coverPath: String?
    
    var imageHeight: CGFloat = 0
    
    var attrTitle: NSAttributedString?
    var attrTitleHeight: CGFloat = 0
   
    private var bottomHeight: CGFloat = 44
    
    var labelTopMargin: CGFloat = 0
    
    init(video: ShortVideoItemsModel) {
        self.video = video
        let cellWidth = floor((xm_screen_width - 15) * 0.5)
        var cellHeight: CGFloat = 0
        
        if let modes = video.item?.contentModel?.nodes {
            if let node = modes.last {
                coverPath = node.contentDetailnode?.coverUrl
                var picW: CGFloat = cellWidth
                var picH: CGFloat = cellWidth
                if let w = node.contentDetailnode?.width, w > 0 {
                    picW = w
                }
                if let h = node.contentDetailnode?.height, h > 0 {
                    picH = h
                }
                imageHeight = ceil(cellWidth * picH / picW)
                cellHeight += imageHeight
            }
            let font = UIFont.boldSystemFont(ofSize: 14)
            let color = UIColor.xm.dynamicRGB((60, 60, 60), (210, 210, 210))
            let labelMaxHeight = font.lineHeight * 2 + 8
            
            if let node = modes.first, let attrString = node.contentDetailnode?.content {
                let attrStr = getAttring(aString: attrString, font: font, color: color, lineSpace: 8)
                var labelHeight = getStringRect(aString: attrStr, width: cellWidth - 20)
                if labelHeight > labelMaxHeight {
                    labelHeight = ceil(labelMaxHeight)
                }
                attrTitle = attrStr
                attrTitleHeight = labelHeight
                cellHeight += labelHeight
                labelTopMargin = 10
                
            }
            cellHeight += labelTopMargin
            cellHeight += bottomHeight
            cellSize = CGSize(width: cellWidth, height: cellHeight)
        }
        
    }
}
