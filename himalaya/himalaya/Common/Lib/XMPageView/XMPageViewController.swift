//
//  XMPageViewController.swift
//  himalaya
//
//  Created by Farben on 2020/8/24.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit
import IGListKit

class XMPageViewController: UIViewController {
    
    var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(titleView)
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        adapter.scrollViewDelegate = self
//        adapter.delegate = self
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "下一个", style: UIBarButtonItem.Style.plain, target: self, action: #selector(next_vc))
    }
    
//    @objc func next_vc() {
//        print("哈哈哈哈")
//
//
//    }
//
    func reloadData() {
        adapter.performUpdates(animated: true, completion: nil)
        titleView.items = items
    }
    
    lazy var items = [XMPageItem]()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        titleView.frame = CGRect(x: 0, y: xm_navgationheight, width: view.xm_width, height: 44)
        collectionView.xm_origin = CGPoint(x: 0, y: titleView.xm_bottom)
        collectionView.xm_size = CGSize(width: view.xm_width, height: view.xm_height - titleView.xm_height - xm_navgationheight)
    }
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let c_view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        c_view.backgroundColor = UIColor.xm.xm_230_20_color
        c_view.bounces = false
        if #available(iOS 11.0, *) {
            c_view.contentInsetAdjustmentBehavior = .never
        }else {
            automaticallyAdjustsScrollViewInsets = false
        }
           c_view.isPagingEnabled = true
           return c_view
       }()
       
    private lazy var titleView: XMPageTitleView = {
        let title_view = XMPageTitleView()
        title_view.delegate = self
        return title_view
    }()
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()

}

extension XMPageViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return items
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        guard let item = object as? XMPageItem else {
            fatalError()
        }
        if item.theOnlyId == 0 {
            return XMPageHomeSectionController(height: view.xm_height - titleView.xm_height - xm_navgationheight)
        }else {
            return XMPageCommonSectionController(height: view.xm_height - titleView.xm_height - xm_navgationheight)
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}

extension XMPageViewController: XMPageTitleViewDelegate {
    func clickCell(titleView: XMPageTitleView, cell: XMTitleViewCell, item: XMPageItem, index: Int) {
        if currentIndex == index {
            return
        }
        currentIndex = index
        collectionView.scrollToItem(at: IndexPath(item: 0, section: index), at: UICollectionView.ScrollPosition.left, animated: false)
        if item.cell != nil {
            item.cell?.theOnlyId = item.theOnlyId
        }
    }
    
}

extension XMPageViewController: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    
    //停止滚动的时候调用这两个方法
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate == false {
            collectionViewDidEndScroll(scrollView)
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        collectionViewDidEndScroll(scrollView)
    }
    
    private func collectionViewDidEndScroll(_ scrollView: UIScrollView) {
        let index = Int(round(scrollView.contentOffset.x / scrollView.frame.width))
        let item = items[index]
        if index != currentIndex {
            currentIndex = index
        }
        if item.cell != nil {
            item.cell?.theOnlyId = item.theOnlyId
        }
        (item.controller as? XMpageControllerLoadFunc)?.controllerDidShow()
        if item.isFirstLoad == true {
            item.isFirstLoad = false
            (item.controller as? XMpageControllerLoadFunc)?.lazyLoad()
        }
    }
    
    
    
//    //即将绘制的时候调用ListAdapterDelegate
//    func listAdapter(_ listAdapter: ListAdapter, willDisplay object: Any, at index: Int) {
//    }
//    //绘制结束的时候调用
//    func listAdapter(_ listAdapter: ListAdapter, didEndDisplaying object: Any, at index: Int) {
//
//        let currnt_index = Int(round(collectionView.contentOffset.x / collectionView.xm_width))
//        if currentIndex != currnt_index {
//            currentIndex = currnt_index
//        }
//        let item = items[currentIndex]
//        (item.controller as? XMpageControllerFirstLoad)?.controllerDidShow()
//        if item.isFirstLoad == true {
//            item.isFirstLoad = false
//            (item.controller as? XMpageControllerFirstLoad)?.lazyLoad()
//        }
//    }
    
    
//    //即将拖拽的时候调用
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//
//    }
//    //正在滚动时候调用
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//
//    }
//
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        if decelerate == false {
//            print("停止滚动了")
//        }
//    }
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        print("停止滚动了")
//    }
    
}


protocol XMpageControllerLoadFunc where Self: UIViewController {

    //控制器完全显示,并且第一次显示的时候调用
    func lazyLoad()
    
    //控制器完全显示的时候调用
    func controllerDidShow()
}
