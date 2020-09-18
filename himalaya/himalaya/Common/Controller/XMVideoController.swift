//
//  XMVideoController.swift
//  himalaya
//
//  Created by Farben on 2020/8/18.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit
import IGListKit

class XMVideoController: XMBaseViewController {

    override func initWithSubviews() {
        super.initWithSubviews()
        view.addSubview(playerView)
        view.addSubview(segmengView)
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
//        adapter.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerView.xm_origin = CGPoint(x: 0, y: 0)
        playerView.xm_size = CGSize(width: view.xm_width, height: view.xm_width * 0.6)
        segmengView.xm_origin = CGPoint(x: 0, y: playerView.xm_bottom)
        segmengView.xm_size = CGSize(width: view.xm_width, height: 50)
    }
    
    private lazy var playerView: XMPlayView = {
        let p_view = XMPlayView()
        p_view.backgroundColor = UIColor.red
        return p_view
    }()
    
    private lazy var segmengView: XMVideoTopView = {
        let s_view = XMVideoTopView()
        return s_view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let c_view = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        c_view.backgroundColor = UIColor.xm.xm_230_20_color
        if #available(iOS 11.0, *) {
            c_view.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        return c_view
    }()
    
    private lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()

}
//
//extension XMVideoController: ListAdapterDataSource {
//    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
//        <#code#>
//    }
//
//    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
//        <#code#>
//    }
//
//    func emptyView(for listAdapter: ListAdapter) -> UIView? {
//        <#code#>
//    }
//
//
//}
