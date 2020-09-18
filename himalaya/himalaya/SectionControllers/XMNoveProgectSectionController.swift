//
//  XMNoveProgectSectionController.swift
//  himalaya
//
//  Created by Farben on 2020/8/31.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import IGListKit

class XMNoveProgectSectionController: ListSectionController {
    
    private var layout: XMNoveLayout?
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: xm_padding, bottom: 0, right: xm_padding)
        minimumLineSpacing = 10
        minimumLineSpacing = 10
        supplementaryViewSource = self
    }
    
    override func numberOfItems() -> Int {
        if let count = layout?.categoryContent?.lists?.count, count > 0 {
            return count
        }
        return 0
    }
    
    private let cellWidth: CGFloat = floor((content_view_width - 10) * 0.5)
    private let topViewHeight: CGFloat = ceil((content_view_width - 10) * 0.2)
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: cellWidth, height: layout?.cellHeight ?? 0)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell: XMCommonLevelListDetailCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
            fatalError()
        }
        if let items = layout?.categoryContent?.lists {
            let item = items[index]
            cell.topView.xm_height = topViewHeight
//            cell.topView.imageView.setWebpRoundImage(urlString: item.coverPathBig, placeHolderName: "new_playpage_default_wide", corner: 10, rectCorner: [.topLeft, .topRight])
            cell.topView.imageView.setWebpImage(urlString: item.coverPathBig, placeHolderName: "new_playpage_default_wide")
            cell.labelTitle.xm_origin = CGPoint(x: 10, y: cell.topView.xm_bottom + 10)
            cell.labelTitle.xm_size = CGSize(width: cellWidth - 20, height: item.titleAttrHeight)
            cell.labelTitle.attributedText = item.titleAttr
        }
        
        return cell
        
    }
    
    override func didUpdate(to object: Any) {
        layout = (object as! XMNoveLayout)
    }
}

extension XMNoveProgectSectionController: ListSupplementaryViewSource {
    func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
        return titleHeaderView(atIndex: index)
    }
    
    func sizeForSupplementaryView(ofKind elementKind: String, at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 55)
    }
    
    func supportedElementKinds() -> [String] {
        return [UICollectionView.elementKindSectionHeader]
    }
    
    private func titleHeaderView(atIndex index: Int) -> UICollectionReusableView {
        guard let headView = collectionContext?.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: self, class: XMMineVipSectionHeadView.self, at: 0) as? XMMineVipSectionHeadView else {
              fatalError()
        }
        headView.labelTitle.xm_x = xm_padding
        headView.labelTitle.xm_y = xm_padding
        headView.labelTitle.xm_height = 40
        headView.labelTitle.text = layout?.categoryContent?.title
        return headView
    }
}
