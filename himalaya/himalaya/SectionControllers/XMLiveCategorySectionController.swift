//
//  XMLiveCategorySectionController.swift
//  himalaya
//
//  Created by cocoazhang on 2020/8/29.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import IGListKit
import RxSwift

class XMLiveCategorySectionController: ListSectionController {
    
    var currentModel: XMLiveCategoryVoListModel? = nil
    
    let clickCell = PublishSubject<Bool>()
    let disposeBag = DisposeBag()
    
    
    override init() {
        super.init()
        minimumLineSpacing = 10
        inset = UIEdgeInsets(top: 0, left: xm_padding, bottom: 0, right: xm_padding)
    }
    
    var layout: XMLiveCategoryLayout? {
        didSet {
            currentModel = layout?.categoryVoLists?.first
        }
    }
    
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: 60, height: 50)
    }
    
    override func numberOfItems() -> Int {
        return layout?.categoryVoLists?.count ?? 0
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell: XMLiveCategoryCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
            fatalError()
        }
        if let models = layout?.categoryVoLists {
            let model = models[index]
            cell.labelTitle.text = model.name
            cell.imageView.setImage(urlString: model.isSelected ? model.darkSecondIcon : model.darkFirstIcon, placeHolderName: nil)
            cell.isClickSelected = model.isSelected
        }
        return cell
    }
    
    override func didSelectItem(at index: Int) {
        let model = layout!.categoryVoLists![index]
        if model.isSelected == true {
            return
        }
        currentModel?.isSelected = false
        model.isSelected = true
        currentModel = model
        
        clickCell.onNext(true)
    }
    
    override func didUpdate(to object: Any) {
        layout = (object as! XMLiveCategoryLayout)
    }
    
}
