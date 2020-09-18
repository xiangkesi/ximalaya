//
//  XMFmPageViewController.swift
//  himalaya
//
//  Created by Farben on 2020/9/11.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit
import IGListKit

class XMFmPageViewController: XMBaseViewController {
        
    
    lazy var viewModel = XMFmTitleViewModel()
    private var currentIndex: Int = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.requestTitlePublish.onNext(true)
        XMAudoStream.sharePlayer().playComplete = {[weak self] in
            self?.viewModel.currentTitleItem?.nextPlayer()
            if let playUrl = self?.viewModel.currentTitleItem?.currentTrack?.playPathAacv224 {
                XMAudoStream.sharePlayer().playerFormUrl(urlString: playUrl)
            }
            self?.bigTitleView.labelTitle?.attributedText = self?.viewModel.currentTitleItem?.currentTrack?.attrTitle
            self?.bottomListView.labelTitle?.text = self?.viewModel.currentTitleItem?.nextTrack?.nextTitle
        }
    }
    
    override func initWithSubviews() {
        super.initWithSubviews()
        view.addSubview(imageView)
        view.addSubview(titleView)
        view.addSubview(collectionView)
        view.addSubview(bigTitleView)
        view.addSubview(bottomView)
        view.addSubview(bottomListView)
        
        adapter.dataSource = self
        adapter.collectionView = collectionView
        viewModel.delegate = self
        
        titleView.clickSubject.subscribe(onNext: {[weak self] (indexPath) in
            if self?.currentIndex == indexPath.section {
                return
            }
            XMAudoStream.sharePlayer().stopPlayer()
            self?.currentIndex = indexPath.section
            let item = self?.viewModel.titleItems[self!.currentIndex]
            item?.index = (self?.currentIndex)!
            self?.viewModel.currentTitleItem = item
            self?.adapter.scroll(to: item as Any, supplementaryKinds: nil, scrollDirection: UICollectionView.ScrollDirection.horizontal, scrollPosition: UICollectionView.ScrollPosition.left, animated: false)
            self!.imageView.setImage(urlString: item!.bgPic, placeHolderName: nil)
            if (item?.index == 0 && item?.listModels == nil) || (item!.index > 0 && item?.listInfoModels == nil) {
                self?.viewModel.requestDetailPublish.onNext((self?.viewModel.currentTitleItem)!)
            }else {
                self?.bigTitleView.labelTitle?.attributedText = self?.viewModel.currentTitleItem?.currentTrack?.attrTitle
                self?.bottomListView.labelTitle?.text = self?.viewModel.currentTitleItem?.nextTrack?.nextTitle
                if let playUrl = self?.viewModel.currentTitleItem?.currentTrack?.playPathAacv224 {
                    XMAudoStream.sharePlayer().playerFormUrl(urlString: playUrl)
                }
            }
        }).disposed(by: titleView.dispose)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        imageView.frame = view.bounds
        
        
        let bottomHeight: CGFloat = UIDevice.tabbarBottomHeight + 50
        
        titleView.xm_origin = CGPoint(x: 0, y: xm_navgationheight + 50)
        titleView.xm_size = CGSize(width: view.xm_width, height: 50)
        
        collectionView.xm_origin = CGPoint(x: 0, y: titleView.xm_bottom)
        collectionView.xm_size = CGSize(width: view.xm_width, height: view.xm_height - collectionView.xm_y - bottomHeight - 200)
        
        bigTitleView.xm_origin = CGPoint(x: 0, y: collectionView.xm_bottom)
        bigTitleView.xm_size = CGSize(width: view.xm_width, height: 100)
        
        bottomView.xm_origin = CGPoint(x: 0, y: bigTitleView.xm_bottom)
        bottomView.xm_size = CGSize(width: view.xm_width, height: 100)
        
        bottomListView.xm_origin = CGPoint(x: 0, y: bottomView.xm_bottom)
        bottomListView.xm_size = CGSize(width: view.xm_width, height: bottomHeight)
    }
    
    private lazy var imageView: UIImageView = {
        let i_view = UIImageView()
        return i_view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let c_view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
//        c_view.backgroundColor = UIColor.xm.xm_230_20_color
        c_view.backgroundColor = UIColor.clear
        if #available(iOS 11.0, *) {
            c_view.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        c_view.bounces = false
        c_view.isPagingEnabled = true
        return c_view
    }()
//    XMFmBigTitleView
    private lazy var bigTitleView: XMFmBigTitleView = {
        let t_view = XMFmBigTitleView()
        
        return t_view
    }()
    
    private lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    private lazy var titleView: XMFmTitleView = {
        let title_view = XMFmTitleView()
        return title_view
    }()
    
    private lazy var bottomView: XMFmBottomPlayerView = {
        let bottom_view = XMFmBottomPlayerView()
        bottom_view.delegate = self
//        bottom_view.backgroundColor = UIColor.yellow
        return bottom_view
    }()
    
    private lazy var bottomListView: XMFmBottomListView = {
        let list_view = XMFmBottomListView()
        return list_view
    }()

}

extension XMFmPageViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return viewModel.titleItems
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let sectionController = XMFmPageSectionController()
        sectionController.delegate = self
        return sectionController
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
//     func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//           if decelerate == false {
//                      print("00000000")
//                  }
//       }
//       func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//          print("1111111")
//       }
}

extension XMFmPageViewController: XMFmPageSectionControllerDelegate {
    
    func pageSectionController(_ sectionController: XMFmPageSectionController, currentIndex index: Int) {
        if index == currentIndex {
            return
        }
        XMAudoStream.sharePlayer().stopPlayer()
        let item = viewModel.titleItems[index]
        imageView.setImage(urlString: item.bgPic, placeHolderName: nil)
         currentIndex = index
        item.index = currentIndex
        viewModel.currentTitleItem = item
        if (item.index == 0 && item.listModels == nil) || (item.index > 0 && item.listInfoModels == nil) {
            viewModel.requestDetailPublish.onNext((viewModel.currentTitleItem)!)
        }else {
            bigTitleView.labelTitle?.attributedText = viewModel.currentTitleItem?.currentTrack?.attrTitle
            bottomListView.labelTitle?.text = viewModel.currentTitleItem?.nextTrack?.nextTitle
            if let playUrl = viewModel.currentTitleItem?.currentTrack?.playPathAacv224 {
                XMAudoStream.sharePlayer().playerFormUrl(urlString: playUrl)
            }
        }
    }
}

extension XMFmPageViewController: XMFmTitleViewModelDelegate {
    
    func loadTitleDetailsFInish() {
        bigTitleView.labelTitle?.attributedText = viewModel.currentTitleItem?.currentTrack?.attrTitle
        bottomListView.labelTitle?.text = viewModel.currentTitleItem?.nextTrack?.nextTitle
        if let urlString = viewModel.currentTitleItem?.currentTrack?.playPathAacv224 {
            XMAudoStream.sharePlayer().playerFormUrl(urlString: urlString)
        }
    }
    
    func loadTitlesFInish() {
        imageView.setImage(urlString: viewModel.currentTitleItem?.bgPic, placeHolderName: "")
        titleView.titleModels = viewModel.titleItems
        adapter.performUpdates(animated: true, completion: nil)
    }
    
    
}

extension XMFmPageViewController: XMFmBottomPlayerViewDelegate {
    func clickBtn(bottomView: XMFmBottomPlayerView, btn: UIButton, tag: Int8) {
        if tag == 40 {
            bigTitleView.labelTitle?.attributedText = viewModel.currentTitleItem?.currentTrack?.attrTitle
            bottomListView.labelTitle?.text = viewModel.currentTitleItem?.nextTrack?.nextTitle
            XMAudoStream.sharePlayer().stopPlayer()
            viewModel.currentTitleItem?.nextPlayer()
            if let playUrl = viewModel.currentTitleItem?.currentTrack?.playPathAacv224 {
                XMAudoStream.sharePlayer().playerFormUrl(urlString: playUrl)
            }
            
        }else if tag == 30 {
            if btn.isSelected == false {
                btn.isSelected = true
                XMAudoStream.sharePlayer().stopPlayer()
            }else {
                btn.isSelected = false
                XMAudoStream.sharePlayer().play()
            }
        }else if tag == 20 {
            btn.isSelected = !btn.isSelected
        }
    }
    
    
}

//extension XMFmPageViewController: HideNavigationBarProtocol {}XMFmTitleViewModelDelegate
