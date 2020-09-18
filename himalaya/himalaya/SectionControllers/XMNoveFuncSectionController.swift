//
//  XMNoveFuncSectionController.swift
//  himalaya
//
//  Created by Farben on 2020/8/27.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import IGListKit

class XMNoveFuncSectionController: ListSectionController {
    
    
    private var showKeyWordModels:[XMNoveCategoryContentList_listModel]?
    private var isDown: Bool = false
    private weak var adapter: ListAdapter?
    
    private var layout: XMNoveLayout? {
        didSet {
            showKeyWordModels = layout?.upkeyWordModels
        }
    }
    
    init(adapter: ListAdapter) {
        super.init()
        self.adapter = adapter
        inset = UIEdgeInsets(top: xm_padding, left: xm_padding, bottom: 0, right: xm_padding)
        minimumLineSpacing = 10
        minimumInteritemSpacing = 10
    }
    
    override func numberOfItems() -> Int {
        return showKeyWordModels?.count ?? 0
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: layout?.funcCellWidth ?? 0, height: layout?.cellHeight ?? 0)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell: XMNoveFuncCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                      fatalError()
        }
        if let titleModels = showKeyWordModels {
            let model = titleModels[index]
            cell.labelTitle.text = model.title
        }
        
        return cell
    }
    
    override func didSelectItem(at index: Int) {
        if index == showKeyWordModels!.count - 1 {
            if isDown == false && layout?.downkeyWordModels != nil {
                isDown = true
                showKeyWordModels = layout?.downkeyWordModels
            }else if isDown == true && layout?.upkeyWordModels != nil {
                isDown = false
                showKeyWordModels = layout?.upkeyWordModels
            }
            adapter?.reloadObjects([layout!])
        }else {
            
        }
        
    }
    
    override func didUpdate(to object: Any) {
        layout = (object as! XMNoveLayout)
    }
}
