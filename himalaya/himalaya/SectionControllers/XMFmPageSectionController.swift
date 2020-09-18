//
//  XMFmPageSectionController.swift
//  himalaya
//
//  Created by cocoazhang on 2020/9/11.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import IGListKit


@objc protocol XMFmPageSectionControllerDelegate {
    func pageSectionController(_ sectionController: XMFmPageSectionController, currentIndex index: Int)
}

class XMFmPageSectionController: ListSectionController {
    
    weak var delegate: XMFmPageSectionControllerDelegate?
    
    
    private var titleModel: XMFmTitleModel?
    override init() {
        super.init()
       scrollDelegate = self
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return collectionContext!.containerSize
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell: XMFmCollectionCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
            fatalError()
        }
//        if let currentFm = titleModel?.currentTrack {
//            cell.labelTitle?.attributedText = currentFm.attrTitle
//        }
//        
        return cell
    }
    
    override func didUpdate(to object: Any) {
        if let model = object as? XMFmTitleModel {
            titleModel = model
        }
    }
    
}
//- (void)listAdapter:(IGListAdapter *)listAdapter didEndDraggingSectionController:(IGListSectionController *)sectionController willDecelerate:(BOOL)decelerate;
extension XMFmPageSectionController: ListScrollDelegate {
    func listAdapter(_ listAdapter: ListAdapter, didScroll sectionController: ListSectionController) {
//        print("正在滚动")
    }
    
    func listAdapter(_ listAdapter: ListAdapter, willBeginDragging sectionController: ListSectionController) {
    }
    
    func listAdapter(_ listAdapter: ListAdapter, didEndDragging sectionController: ListSectionController, willDecelerate decelerate: Bool) {
        if decelerate == false {
            if delegate != nil {
                delegate?.pageSectionController(self, currentIndex: section)
            }
        }
        
    }
    
    func listAdapter(_ listAdapter: ListAdapter, didEndDeceleratingSectionController sectionController: ListSectionController) {
        if delegate != nil {
            delegate?.pageSectionController(self, currentIndex: section)
        }
    }
    
    
}
