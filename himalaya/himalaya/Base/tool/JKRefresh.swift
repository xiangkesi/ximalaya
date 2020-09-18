//
//  JKRefresh.swift
//  jk_immediate
//
//  Created by ZS on 2019/3/1.
//  Copyright © 2019年 ZS. All rights reserved.
//

import Foundation
import UIKit
import MJRefresh
import RxSwift

enum JKRefreshState: Int {
    case InvalidData = 0 //无效的数据
    case DropDownSuccess = 1 //下拉成功
    case PullSuccessHasMoreData = 2 //上拉成功还有更多数据
    case PullSuccessNoMoreData = 3 //上拉成功没有更多数据
    case PullAutoRefreshDown = 4 //自动下拉
    case DropOnlyUpFootResetHidden = 5 //重置没有更多数据
//    case
    case NoWarning = 6
}


private let jk_hearderRefreshBlockKey = UnsafeRawPointer(bitPattern: "jk_hearderRefreshBlockKey".hashValue)!
private let jk_footerRefreshBlockKey = UnsafeRawPointer(bitPattern: "jk_footerRefreshBlockKey".hashValue)!
private let jk_refreshStatusChangeKey = UnsafeRawPointer(bitPattern: "jk_refreshStatusChangeKey".hashValue)!

extension UIScrollView {
    
    var jk_headerRefreshBlock:(()->())? {
        set {
            objc_setAssociatedObject(self, jk_hearderRefreshBlockKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
            jk_addHeaderRefresh()
        }
        get {
            guard let block = objc_getAssociatedObject(self, jk_hearderRefreshBlockKey) as? (() -> ()) else {
                return nil
            }
            return block
        }
    }
    
    var jk_footerRefreshBlock:(() -> ())? {
        set {
            objc_setAssociatedObject(self, jk_footerRefreshBlockKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
            jk_addFooterRefresh()
        }
        
        get {
            
            guard let block = objc_getAssociatedObject(self, jk_footerRefreshBlockKey) as? (() -> ()) else {
                return nil
            }
            return block
        }
    }
    
    
    var refresh_status: JKRefreshState? {
        
        set {
            objc_setAssociatedObject(self, jk_refreshStatusChangeKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            receiveRefresh_status(status: refresh_status)

        }
        
        get {
            return objc_getAssociatedObject(self, jk_refreshStatusChangeKey) as? JKRefreshState

        }
    }
    
    
    private func receiveRefresh_status(status: JKRefreshState?) {
        
        if status == nil {return}
        
        switch status! {
        case JKRefreshState.InvalidData:
            zs_endHeaderRefresh()
            zs_endFooterRefresh()
            break
        case JKRefreshState.DropDownSuccess:
            zs_endHeaderRefresh()
            if mj_footer != nil && mj_footer?.isHidden == true {
                mj_footer?.isHidden = false
            }
            if mj_footer != nil && mj_footer?.state == .noMoreData {
                mj_footer?.resetNoMoreData()
            }
             break
         case JKRefreshState.PullSuccessHasMoreData:
            zs_endFooterRefresh()
            break
        case JKRefreshState.PullSuccessNoMoreData:
            if mj_footer != nil {
                mj_footer?.endRefreshingWithNoMoreData()
            }
            break
        case .PullAutoRefreshDown:
            if mj_header != nil && mj_header?.state != MJRefreshState.refreshing {
                mj_header?.beginRefreshing()
            }
            break
        case JKRefreshState.DropOnlyUpFootResetHidden:
            if mj_footer != nil && mj_footer?.isHidden == true {
                mj_footer?.isHidden = false
            }
            break
        default:
            break
        }
    }
    
    private func jk_addHeaderRefresh() {
        if mj_header == nil {
            let header = JKRefreshHeader {[weak self] in
                //先判断有没有footer正在刷新,如果有就什么事也不干,一次只有一个正在加载,不能上拉和下拉同时进行
                if self?.mj_footer != nil && self?.mj_footer?.state == MJRefreshState.refreshing {
                    self?.mj_header?.endRefreshing()
                    return
                }
                if self?.jk_headerRefreshBlock != nil {
                    self?.jk_headerRefreshBlock!()
                }
            }
            mj_header = header
        }
    }
    

    
    private func jk_addFooterRefresh() {
        if mj_footer == nil {
            let footer = JKRefreshFooter { [weak self] in
                //先判断有没有header正在刷新,如果有就什么事也不干,一次只有一个正在加载,不能上拉和下拉同时进行
                if self?.mj_header != nil && self?.mj_header?.state == MJRefreshState.refreshing {
                    self?.mj_footer?.endRefreshing()
                    return
                }
                if self?.jk_footerRefreshBlock != nil {
                    self?.jk_footerRefreshBlock!()
                }
                
            }
            //为了防止才进来的时候没有数据就显示footer
            footer.isHidden = true
            mj_footer = footer
            
        }
    }
    
    private func zs_endHeaderRefresh() {
        if mj_header != nil && mj_header?.isRefreshing == true {
            mj_header?.endRefreshing()
        }
    }
    
    private func zs_endFooterRefresh() {
        if mj_footer != nil && mj_footer?.isRefreshing == true {
            mj_footer?.endRefreshing()
        }
    }
    
}

class JKRefreshHeader: MJRefreshGifHeader {
    
    override func prepare() {
        super.prepare()
       
        var loadingArrayImage = [UIImage]()
        for index in 2..<20 {
            let imageName = "host_play_flag_wave_" + String(index)
            if let image = UIImage(named: imageName) {
                loadingArrayImage.append(image)
            }
        }
        
        
        setImages([UIImage(named: "host_play_flag_wave_2")!], for: .idle)
        setImages([UIImage(named: "host_play_flag_wave_2")!], for: .pulling)
        setImages(loadingArrayImage, duration: 0.8, for: MJRefreshState.refreshing)
        lastUpdatedTimeLabel?.isHidden = true
        stateLabel?.isHidden = true
    }
    
    
    override var state: MJRefreshState {
        didSet {
            if state == .pulling {
                playSound()
            }
        }
    }
    
    private func playSound() {
        
        if #available(iOS 10.0, *) {
            BSFeedbackTool.manager.play()
        }
    }
}


class JKRefreshFooter: MJRefreshAutoNormalFooter {
    
    override func prepare() {
        super.prepare()
        stateLabel?.textColor = UIColor.xm.dynamicRGB((30, 30, 30), (200, 200, 200))
        stateLabel?.font = UIFont.systemFont(ofSize: 12)
        setTitle("没有更多数据了", for: .noMoreData)
        setTitle("上拉加载更多", for: .idle)
        setTitle("正在加载", for: .refreshing)
    }
}


@available(iOS 10.0, *)
class BSFeedbackTool {
    
    static let manager = BSFeedbackTool()
    
    private var impactLight: UIImpactFeedbackGenerator?
    
    init() {
        let light = UIImpactFeedbackGenerator(style: UIImpactFeedbackGenerator.FeedbackStyle.medium)
        impactLight = light
        light.prepare()
        
        
    }
    
    func play() {
        impactLight?.impactOccurred()
    }
}

//class ImageClass: NSObject {
//
//}
//extension Reactive where Base: ImageClass {
//
//    func add() {
//
//    }
//}
////extension NSObject: ReactiveCompatible { }
//
//class MyClass {
//
//}
//
//extension MyClass: ReactiveCompatible{}
//
//
//extension Reactive where Base: MyClass {
//
//    func add() {
//        print("")
//    }
//}
