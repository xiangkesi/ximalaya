//
//  XMMineHeadMsgSectionController.swift
//  himalaya
//
//  Created by Farben on 2020/8/28.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import IGListKit

class XMMineHeadMsgSectionController: ListSectionController {
    
    
    private var layout: XMMineLayout?
    
    override init() {
        super.init()
        supplementaryViewSource = self
        inset = UIEdgeInsets(top: 0, left: xm_padding, bottom: xm_padding, right: xm_padding)
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
    }
    override func numberOfItems() -> Int {
        return 1
    }
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: content_view_width, height: ceil(content_view_width * 0.25 + 95))
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell: XMMineHeadViewCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
            fatalError()
         }
        cell.userMsg = layout?.section?.userMsg
         return cell
    }
    
    
    override func didUpdate(to object: Any) {
        layout = (object as! XMMineLayout)
    }
    
}

extension XMMineHeadMsgSectionController: ListSupplementaryViewSource {
    func supportedElementKinds() -> [String] {
        return [UICollectionView.elementKindSectionHeader]
    }
    
    func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
        return titleHeaderView(atIndex: index)
    }
    
    func sizeForSupplementaryView(ofKind elementKind: String, at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: ceil((collectionContext!.containerSize.width - xm_padding * 2) * 0.12754 + 105) )
    }
    
    private func titleHeaderView(atIndex index: Int) -> UICollectionReusableView {
        guard let headView = collectionContext?.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: self, class: XMMineHeadView.self, at: 0) as? XMMineHeadView else {
              fatalError()
        }
        headView.userMsg = layout?.section?.userMsg
        return headView
    }
    
    
    
    
}


class XMMineVipSectionController: ListSectionController {
    
    override init() {
        super.init()
        workingRangeDelegate = self
        supplementaryViewSource = self
        inset = UIEdgeInsets(top: 0, left: xm_padding, bottom: xm_padding, right: xm_padding)
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
    }
    
    private lazy var viewBg: UIView = {
        let bg = UIView()
        bg.backgroundColor = UIColor.xm.xm_255_30_color
        bg.layer.cornerRadius = 5
        bg.xm_y = xm_padding
        bg.xm_x = xm_padding
        bg.xm_width = content_view_width
        return bg
    }()
    
    private var layout: XMMineLayout?
    override func sizeForItem(at index: Int) -> CGSize {
        return layout?.cellSize ?? CGSize.zero
    }
    
    override func numberOfItems() -> Int {
        return layout?.section?.models?.count ?? 0
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
         guard let cell: XMMineSectionCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
            fatalError()
         }
        if let sections = layout?.section?.models {
            let model = sections[index]
            cell.labelTitle?.text = model.name
            cell.imageView?.setImage(urlString: model.icon, placeHolderName: "image_choice_girl_1")
        }
        return cell
    }
    
    override func didUpdate(to object: Any) {
        layout = (object as! XMMineLayout)
        viewBg.xm_height = layout!.viewBgHeight
    }
}

extension XMMineVipSectionController: ListSupplementaryViewSource {
    func supportedElementKinds() -> [String] {
        return [UICollectionView.elementKindSectionHeader]
    }
    
    func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
         switch elementKind {
         case UICollectionView.elementKindSectionHeader:
            return titleHeaderView(atIndex: index)
         default:
            fatalError()
         }
    }
    
    func sizeForSupplementaryView(ofKind elementKind: String, at index: Int) -> CGSize {
        return CGSize(width: content_view_width, height: 40)
    }
    
    private func titleHeaderView(atIndex index: Int) -> UICollectionReusableView {
        guard let headView = collectionContext?.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: self, class: XMMineVipSectionHeadView.self, at: 0) as? XMMineVipSectionHeadView else {
              fatalError()
        }
        viewBg.xm_y = headView.xm_y
        headView.labelTitle.text = layout?.section?.moduleName
        return headView
    }
}

extension XMMineVipSectionController: ListWorkingRangeDelegate {
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerWillEnterWorkingRange sectionController: ListSectionController) {
        listAdapter.collectionView?.insertSubview(viewBg, at: 0)
    }
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerDidExitWorkingRange sectionController: ListSectionController) {
    }
}
