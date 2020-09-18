//
//  XMNovelViewController.swift
//  himalaya
//
//  Created by cocoazhang on 2020/8/22.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit
import IGListKit

class XMNovelViewController: XMBaseViewController {
    private lazy var viewModel = XMNoveViewModel(adapter: adapter)
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func initWithSubviews() {
        super.initWithSubviews()
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        collectionView.jk_headerRefreshBlock = {[weak self] in
            self?.viewModel.requestNoveList.onNext(true)
        }
        collectionView.jk_footerRefreshBlock = {[weak self] in
            self?.viewModel.requestNoveList.onNext(false)
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    private lazy var collectionView: UICollectionView = {
        let c_view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
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

extension XMNovelViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return viewModel.layouts
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        guard let layout = object as? XMNoveLayout else {
            fatalError()
        }
        switch layout.cellType {
        case .focusImage:
            return XMNoveFouceImageSectionController()
        case .keyword:
            return XMNoveFuncSectionController(adapter: adapter)
        case .movie:
            return XMNoveFilmSectionController()
        case .adCard:
            return XMNoveAdCardSectionController()
        case .week:
            return XMNoveWeekSectionController()
        case .album:
            return XMNoveAlbumsSectionController()
        case .live:
            return XMNoveLiveSectionController()
        case .project:
            return XMNoveProgectSectionController()
        case .tonight:
            return XMSleepingVerticalSectionController()
        case .recommended:
            return XMNoveRecomdSectionController()
        case .albumTrack:
            return XMNoveAlbumRecomdSectionController()
        case .manWomenLove:
            return XMHomeNoveNanNvSectionController()
        default:
            return XMNoveOtherSectionController()
        }
    }
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
extension XMNovelViewController: PageEventHandleable {
    func contentViewFirstShow() {
        viewModel.requestNoveList.onNext(true)
    }
}
