//
//  XMLiveCellSectionController.swift
//  himalaya
//
//  Created by cocoazhang on 2020/8/29.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import IGListKit

class XMLiveCellSectionController: ListSectionController {
    
    
    private var layout: XMLiveLayout?
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        minimumInteritemSpacing = 10
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return layout?.cellSize ?? CGSize.zero
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell: XMLiveCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
            fatalError()
        }
        cell.layout = layout
        return cell
    }
    
    override func didUpdate(to object: Any) {
        layout = (object as! XMLiveLayout)
    }
    
}

class XMLiveChatRoomSectionController: ListSectionController {
    private var layout: XMLiveLayout?
    override init() {
        super.init()
        inset = UIEdgeInsets(top: xm_padding, left: 0, bottom: 0, right: 0)
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return layout?.cellSize ?? CGSize.zero
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell: XMLiveChatRoomCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                   fatalError()
        }
        cell.layout = layout
        return cell
    }
    
    override func didUpdate(to object: Any) {
        layout = (object as! XMLiveLayout)
    }
    
}
//XMLiveFocusImageCell
class XMLiveFocusImageSectionController: ListSectionController {
    private var layout: XMLiveLayout?
    override init() {
        super.init()
        inset = UIEdgeInsets(top: xm_padding, left: 0, bottom: 0, right: 0)
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return layout?.cellSize ?? CGSize.zero
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell: XMLiveFocusImageCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                   fatalError()
        }
        cell.layout = layout
        return cell
    }
    
    override func didUpdate(to object: Any) {
        layout = (object as! XMLiveLayout)
    }
}
