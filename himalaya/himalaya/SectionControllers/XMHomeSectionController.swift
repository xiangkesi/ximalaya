//
//  XMBanderSectionController.swift
//  himalaya
//
//  Created by Farben on 2020/8/17.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import IGListKit

class XMHomeSectionController: ListSectionController {
    
    
    private var layout: HomeLayout? {
        didSet {
            if layout?.cellType == .module(.focus){
                self.workingRangeDelegate = self
            }
        }
    }
    override func numberOfItems() -> Int {
        return 1
    }
    override init() {
        super.init()
        inset = UIEdgeInsets(top: xm_padding, left: 0, bottom: 0, right: 0)
        
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return layout!.cellSize
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        switch layout?.cellType {
        case .module(.focus):
            guard let cell: HomeBanderCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                fatalError()
            }
            cell.delegate = self
            cell.imageUrls = layout?.urlStrings
            
            return cell
        case .module(.square):
            guard let cell: HomeFunctionContentCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                fatalError()
            }
            cell.delegate = self
            cell.lists = layout?.heder.headerItem?.lists
            return cell
        case .module(.topBuzz):
            guard let cell: HomeHotCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                fatalError()
            }
            cell.layout = layout
            return cell
        case .module(.guessYouLike):
            guard let cell: HomeGuessLikeContentCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                fatalError()
            }
            cell.delegate = self
            cell.layout = layout
            return cell
        case .module(.ad),
             .video,
             .special://使用同一个cell
            guard let cell: HomeCommonCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                fatalError()
            }
            cell.layout = layout
            return cell
        case .one_key_listen_scene,
             .recent_listen:
            guard let cell: XMHomePersonFmCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                fatalError()
            }
            cell.layout = layout
            return cell
        default:
            guard let cell: HomeBodyAlbumCell = collectionContext?.dequeueReusableCell(for: self, at: index) else {
                fatalError()
            }
            cell.layout = layout
            return cell
        }
        
    }
    
    override func didUpdate(to object: Any) {
        if let l = object as? HomeLayout {
            layout = l
        }
    }
    
    override func didSelectItem(at index: Int) {
        
        switch layout?.cellType {
        case .one_key_listen_scene:
            
            
            let fmVc = XMFmPageViewController()
            viewController?.navigationController?.pushViewController(fmVc, animated: true)
        case .album:
            let albumListVc = XMAlbumListController()
            viewController?.navigationController?.pushViewController(albumListVc, animated: true)
        case .track:
            let albumDetailVc = XMAlbumDetailController()
            let nav = NavgationController(rootViewController: albumDetailVc)
            viewController?.navigationController?.present(nav, animated: true, completion: nil)
        case .live:
//            XMLiveDetailViewController
            let liveDetailVc = XMLiveDetailViewController()
            let nav = NavgationController(rootViewController: liveDetailVc)
            viewController?.navigationController?.present(nav, animated: true, completion: nil)
        case .module(.ad):
            if let ad = layout?.currentAd {
                let webVc = BaseWebViewController()
                webVc.urlString = ad.realLink
                viewController?.navigationController?.pushViewController(webVc, animated: true)
            }
        case .recent_listen:
            let albumListVc = XMAlbumListController()
            viewController?.navigationController?.pushViewController(albumListVc, animated: true)
        case .module(.topBuzz):
            let topBuzzVc = XMFmPageViewController()
            viewController?.navigationController?.pushViewController(topBuzzVc, animated: true)
        case .special:
            let webVc = BaseWebViewController()
            var urlString = common_damin
            urlString.urlAddCompnentForDic(dic: ["id": "\(layout?.heder.headerItem?.specialId ?? 0)", "use_lottie": "false"])
            webVc.urlString = urlString
            viewController?.navigationController?.pushViewController(webVc, animated: true)
        case .video:
            let videoVc = XMVideoController()
            viewController?.navigationController?.pushViewController(videoVc, animated: true)
            
        default:
            break
        }
        
//        case .module(.ad),
//                    .video,
//                    .special:/
        
//        if layout?.param?.msg_type == "74" {//点击了FM
//            let fmVc = XMFmPageViewController()
//            viewController?.navigationController?.pushViewController(fmVc, animated: true)
//        }
//
//        if layout?.cellType == .module(.topBuzz) {
//            let hotListVc = XMHotListViewController()
//            viewController?.navigationController?.pushViewController(hotListVc, animated: true)
//
//        }else {
//            let albumListVc = XMAlbumListController()
//            viewController?.navigationController?.pushViewController(albumListVc, animated: true)
//
////            XMAudoStream.sharePlayer().playerFormUrl(urlString: "http://aod.cos.tx.xmcdn.com//storages//e990-audiofreehighqps//BC//0C//CMCoOSIDG4eGAATXpABOkGy3.mp3")
//        }
        
    }
}

extension XMHomeSectionController: HomeGuessLikeContentCellDelegate {
    func clickHeadMore(cell: HomeGuessLikeContentCell) {
        let guessLiveVc = XMGuessLikeViewController()
        viewController?.navigationController?.pushViewController(guessLiveVc, animated: true)
        
           
    }
       
       
    func clickCell(cell: HomeGuessLikeContentCell, item: HomeHeaderItemData) {
        let albumVc = XMAlbumListController()
        viewController?.navigationController?.pushViewController(albumVc, animated: true)
    }
}
extension XMHomeSectionController: HomeBanderCellDelegate, HomeFunctionContentCellDelegate {
   
    /// 点击分类
    /// - Parameters:
    ///   - cell: <#cell description#>
    ///   - item: <#item description#>
    func clickCell(cell: HomeFunctionContentCell, item: HomeHeaderItemData, index: Int) {
        if index == 0 {
            let voiceVc = FindVoiceController()
            viewController?.navigationController?.pushViewController(voiceVc, animated: true)
            
//            let topListVc = XMTopListViewController()
//            viewController?.navigationController?.pushViewController(topListVc, animated: true)
        }else if index == 1 {
            let webVc = BaseWebViewController()
            webVc.urlString = item.url
            viewController?.navigationController?.pushViewController(webVc, animated: true)
        }else if index == 2 {
            let sleepVc = XMSleepPageDecomController()
            let nav = XMSleepNavController(rootViewController: sleepVc)
            nav.modalPresentationStyle = .fullScreen
            viewController?.navigationController?.present(nav, animated: true, completion: nil)
        }else if index == 3 {
            let boutiqueVc = XMHighQualityGoodsViewController()
            viewController?.navigationController?.pushViewController(boutiqueVc, animated: true)
        }else if index == 4 {
            let liveVc = XMLiveViewController()
            viewController?.navigationController?.pushViewController(liveVc, animated: true)
        }
    }
    
    
    /// 点击bander
    /// - Parameters:
    ///   - cell: <#cell description#>
    ///   - bander: <#bander description#>
    func clickCell(cell: HomeBanderCell, atIndex index: Int) {
        if let banders = layout?.heder.headerItem?.lists?.first?.banders {
            let bander = banders[index]
            if bander.isWebVc {
                let webVc = BaseWebViewController()
                webVc.urlString = bander.realLink
                viewController?.navigationController?.pushViewController(webVc, animated: true)
            }else {
                if bander.linkParam?.msg_type == "11" {
//                    XMAlbumListController
                    let albumDetailVc = XMAlbumDetailController()
                    let nav = NavgationController(rootViewController: albumDetailVc)
                    viewController?.navigationController?.present(nav, animated: true, completion: nil)
                }else if bander.linkParam?.msg_type == "13" {
                    let albumListVc = XMAlbumListController()
                    viewController?.navigationController?.pushViewController(albumListVc, animated: true)
                }else if bander.linkParam?.msg_type == "80" {
                    let videoDetailVc = XMVideoController()
                    viewController?.navigationController?.pushViewController(videoDetailVc, animated: true)
                    
                }
//                        print(bander.linkParam?.msg_type)
            }
        }        
    }
}


//为了在看不见的时候不进行图片轮播
extension XMHomeSectionController: ListWorkingRangeDelegate {
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerWillEnterWorkingRange sectionController: ListSectionController) {
        let cell = cellForItem(at: 0)
        if cell is HomeBanderCell {
            (cell as! HomeBanderCell).isShowOnScreen = true
        }
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerDidExitWorkingRange sectionController: ListSectionController) {
         let cell = cellForItem(at: 0)
            if cell is HomeBanderCell {
            (cell as! HomeBanderCell).isShowOnScreen = false
            }
    }
}
