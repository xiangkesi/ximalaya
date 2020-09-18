//
//  XMPageCommonSectionController.swift
//  himalaya
//
//  Created by Farben on 2020/8/24.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import IGListKit

class XMPageCommonSectionController: ListSectionController {
    
    private var cellHeight: CGFloat = 0
    
    private var item: XMPageItem?
    init(height: CGFloat) {
        super.init()
        self.cellHeight = height
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        
//        workingRangeDelegate = self
    }
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        CGSize(width: collectionContext!.containerSize.width, height: self.cellHeight)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell: XMPageCommonViewCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
            fatalError()
        }
        item?.controller = cell.conterollerView
        item?.cell = cell
        if cell.theOnlyId != item?.theOnlyId {
            cell.loadingView.isHidden = false
        }else {
            cell.loadingView.isHidden = true
        }
        
        if cell.isAddContentViewController == false {
            cell.isAddContentViewController = true
            viewController?.addChild(cell.conterollerView)
        }
        cell.labelTitle.text = "这是第\(index)个"
        return cell
    }
    
    override func didUpdate(to object: Any) {
        item = (object as! XMPageItem)
    }
}

//extension XMPageCommonSectionController: ListWorkingRangeDelegate{
//    func listAdapter(_ listAdapter: ListAdapter, sectionControllerWillEnterWorkingRange sectionController: ListSectionController) {
//        print("hell0")
//    }
//
//    func listAdapter(_ listAdapter: ListAdapter, sectionControllerDidExitWorkingRange sectionController: ListSectionController) {
//        print("咋回事呢")
//    }
//
//
//}
