//
//  XMItingSectionController.swift
//  himalaya
//
//  Created by Farben on 2020/9/18.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import IGListKit
import RxSwift

class XMItingSectionController: ListSectionController {
    
    
    private var layout: XMItingLayout?
    
    override init() {
        super.init()
        supplementaryViewSource = self
    }
    
    override func numberOfItems() -> Int {
        return layout?.resultModel?.resultModels?.count ?? 0
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 100)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        
        guard let cell: XMItingSubscribeCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
            fatalError()
        }
        
        if let models = layout?.resultModel?.resultModels {
            let model = models[index]
            cell.resultModel = model
        }
        
        return cell
    }
    
    override func didUpdate(to object: Any) {
        layout = (object as! XMItingLayout)
    }
    
    private lazy var headView: XMMeTingHeadView = {
        guard let headView = collectionContext?.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: self, class: XMMeTingHeadView.self, at: 0) as? XMMeTingHeadView else {
              fatalError()
        }
//        headView.bottomView.btnExchange.rx.tap.subscribe {[weak self] in
//
//        }.disposed(by: headView.disposeBag)
        return headView
    }()
}

extension XMItingSectionController: ListSupplementaryViewSource {
    func supportedElementKinds() -> [String] {
        return [UICollectionView.elementKindSectionHeader]
    }
    
    func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
        let head_view = headView
        head_view.layout = layout
        return head_view
        
    }
    
    func sizeForSupplementaryView(ofKind elementKind: String, at index: Int) -> CGSize {
        CGSize(width: collectionContext!.containerSize.width, height: 190)
    }
    
    
}
