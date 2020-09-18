//
//  XMSleepCommonFotterSectionCOntroller.swift
//  himalaya
//
//  Created by Farben on 2020/9/14.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import IGListKit

class XMSleepCommonFotterSectionController: ListSectionController {
    
    override init() {
        super.init()
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
           return CGSize(width: collectionContext!.containerSize.width, height: 120)
       }
       
       override func cellForItem(at index: Int) -> UICollectionViewCell {
           guard let cell: XMSleepCommonBottomCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
               fatalError()
           }
           return cell
       }
}
