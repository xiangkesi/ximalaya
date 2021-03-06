//
//  ListCollectionContextExtension.swift
//  himalaya
//
//  Created by Farben on 2020/8/18.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit
import IGListKit

extension ListCollectionContext {
    /**
     Dequeues a cell from the collection view reuse pool.

     - Parameters:
        - reuseIdentifier: A reuse identifier for the specified cell. This parameter may be `nil`.
        - sectionController: The section controller requesting this information.
        - index: The index of the cell.

     - Returns: A cell dequeued from the reuse pool or a newly created one.
     */
    public func dequeueReusableCell<T: UICollectionViewCell>(
        withReuseIdentifier reuseIdentifier: String,
        for sectionController: ListSectionController,
        at index: Int
    ) -> T {
        guard let cell = self.dequeueReusableCell(
            of: T.self,
            withReuseIdentifier: reuseIdentifier,
            for: sectionController,
            at: index
        ) as? T else {
            fatalError()
        }

        return cell
    }

    /**
     Dequeues a cell from the collection view reuse pool.

     - Parameters:
         - sectionController: The section controller requesting this information.
         - index: The index of the cell.

     - Returns: A cell dequeued from the reuse pool or a newly created one.

     - Note: This method uses a string representation of the cell class as the identifier.
     */
    public func dequeueReusableCell<T: UICollectionViewCell>(
        for sectionController: ListSectionController,
        at index: Int
    ) -> T {
        guard let cell = self.dequeueReusableCell(
            of: T.self,
            for: sectionController, at: index
        ) as? T else {
            fatalError()
        }

        return cell
    }
}
