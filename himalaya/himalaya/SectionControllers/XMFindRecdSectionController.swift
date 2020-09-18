//
//  XMFindRecdSectionController.swift
//  himalaya
//
//  Created by Farben on 2020/9/3.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import IGListKit

class XMFindRecdSectionController: ListSectionController {
    
    private var layout: XMFindRecdLayout?
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: xm_padding, left: 0, bottom: 0, right: 0)
    }
    
    override func numberOfItems() -> Int {
        return layout?.rows.count ?? 0
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let row = layout?.rows[index] else {
            fatalError()
        }
        return CGSize(width: collectionContext!.containerSize.width, height: row.cellHeight)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let row = layout?.rows[index] else {
            fatalError()
        }
        switch row.cellType {
        case .questionBigTitle:
            guard let cell: XMFindRecdQuestionHeadCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                       fatalError()
                   }
            cell.row = row
            return cell
        case .contentText:
            guard let cell: XMFindTextCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                       fatalError()
                   }
            cell.row = row
            return cell
        case .toolBarBottom:
            guard let cell: XMFindBottomViewCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                       fatalError()
            }
            return cell
        case .cycle:
            guard let cell: XMFindFromCycleCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                       fatalError()
            }
            cell.row = row
            return cell
        case .headerProfile:
            guard let cell: XMFindProfileCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                       fatalError()
            }
            cell.layout = layout
            return cell
        case .picture:
            guard let cell: XMFindPictureCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                       fatalError()
            }
            cell.row = row
            return cell
        case .video:
            guard let cell: XMFindVideoCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                       fatalError()
            }
            cell.row = row
            return cell
        case .track,
             .album:
            guard let cell: XMFindTrackCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                       fatalError()
            }
            cell.row = row
            return cell
        case .hotComment:
            
            guard let cell: XMFindHotCommentCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                       fatalError()
            }
            cell.row = row//XMFinRecdChooseHeadCell
            return cell
        case .questionnaireHeader:
            guard let cell: XMFinRecdChooseHeadCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                       fatalError()
            }
            cell.row = row//XMFindRecdChooseCell
            return cell
        case .questionnairecell:
            guard let cell: XMFindRecdChooseCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                       fatalError()
            }
            cell.row = row//XMFindRecdChooseCell
            return cell
        case .questionnaireFooter:
//            XMFinRecdVoteFooterCell
            guard let cell: XMFinRecdVoteFooterCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                       fatalError()
            }
//            cell.layout = layout
            return cell
        default:
            fatalError()
        }
    }
    override func didSelectItem(at index: Int) {
//        let row = layout!.rows[index]
//        if row.cellType == XMFindRecdLayout.XMFindRecdLayoutCellType.questionnaireFooter {
//            if layout!.voteCellLastIndex > 2 {
//                for row in layout!.voteRows {
//                    layout!.rows.insert(row, at: layout!.voteCellLastIndex)
//                    layout!.voteCellLastIndex += 1
//                }
//                layout!.voteCellLastIndex = 0
//                
//            }
//        }
        
    }
    
    
    override func didUpdate(to object: Any) {
        layout = (object as! XMFindRecdLayout)
    }
}
