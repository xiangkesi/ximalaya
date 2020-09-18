//
//  XMSleepBaseViewController.swift
//  himalaya
//
//  Created by Farben on 2020/9/14.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit
import IGListKit

class XMSleepBaseViewController: XMBaseViewController {

    lazy var viewModel = XMSleepHomeViewModel(adapter: adapter)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    var titleModel: XMSleepTitleModel?
    
    
    override func initWithSubviews() {
        super.initWithSubviews()
        view.backgroundColor = UIColor.colorWithrgba(27, 25, 43)
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.xm_origin = CGPoint(x: 0, y: xm_navgationheight)
        collectionView.xm_size = CGSize(width: view.xm_width, height: view.xm_height - xm_navgationheight)
    }
    
    lazy var collectionView: UICollectionView = {
        let c_view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        c_view.backgroundColor = .clear
        if #available(iOS 11.0, *) {
            c_view.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        return c_view
    }()
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    lazy var imageView: UIImageView = {
        let i_view = UIImageView()
        i_view.backgroundColor = UIColor.colorWithrgba(27, 25, 43)
        i_view.contentMode = .scaleAspectFill
        i_view.clipsToBounds = true
        return i_view
     }()

}

extension XMSleepBaseViewController : ListAdapterDataSource{
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return [] as [ListDiffable]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return ListSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
    
}

@objc extension XMSleepBaseViewController: PageEventHandleable {
    
    func contentViewFirstShow() {
        if let scondId = titleModel?.sceneId, scondId != 4 {
            viewModel.requestPublish.onNext(Int(scondId))
        }
        
    }
}
