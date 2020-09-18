//
//  XMSpecialListSectionController.swift
//  himalaya
//
//  Created by Farben on 2020/8/17.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import IGListKit

class XMSpecialListSectionController: ListSectionController {
    
    private var item: HomeHeaderItem?
        
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: xm_padding, bottom: 0, right: 10)
        minimumLineSpacing = 10
        supplementaryViewSource = self
    }
    
    override func numberOfItems() -> Int {
        return item?.lists?.count ?? 0
    }
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: 140, height: 120)
    }
        
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell: HomeGuessLikeCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                       fatalError()
        }
        if let items = item?.lists {
            cell.itemData = items[index]
        }
        return cell
    }
    
    override func didSelectItem(at index: Int) {
        
        guard let items = item?.lists else {
            return
        }
//        https://m.ximalaya.com/explore/subject_detail?id=9046&use_lottie=false
        let item = items[index]
        var demo = common_damin
        demo.urlAddCompnentForDic(dic: ["id": "\(item.specialId)", "use_lottie": "false"])
        let webVc = BaseWebViewController()
        webVc.urlString = demo
        viewController?.navigationController?.pushViewController(webVc, animated: true)
    }
        
    override func didUpdate(to object: Any) {
        if let item = object as? HomeHeaderItem {
            self.item = item
        }
    }
}

extension XMSpecialListSectionController: ListSupplementaryViewSource {
    func supportedElementKinds() -> [String] {
        return [UICollectionView.elementKindSectionFooter]
    }
    
    func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
        guard let headView = collectionContext?.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, for: self, class: XMFooterCollectionReusableView.self, at: index) as? XMFooterCollectionReusableView else {
            fatalError()
        }
//        https://m.ximalaya.com/new-listen-list/listentoday?timestamp=1599805038694
        headView.clickFooter = {[weak self] in
            let webVc = BaseWebViewController()
            var urlString = "https://m.ximalaya.com/new-listen-list/listentoday"
            urlString.urlAddCompnentForValue(with: "timestamp", value: "\(getTimeStamp())")
            webVc.urlString = urlString
            self?.viewController?.navigationController?.pushViewController(webVc, animated: true)
            
        }
        headView.btnMore?.frame = headView.bounds
        return headView
    }
    
    func sizeForSupplementaryView(ofKind elementKind: String, at index: Int) -> CGSize {
        return CGSize(width: 80, height: 100)
    }
}
