//
//  XMHQGViewModel.swift
//  himalaya
//
//  Created by Farben on 2020/9/16.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import RxSwift
import IGListKit

class XMHQGViewModel {
    
    let disposeBag = DisposeBag()
    
    lazy var layouts = [XMHQGLayout]()
    
    private var currentLayout: XMHQGLayout?
    
    let requestTop = PublishSubject<Bool>()
    let requestAlbum = PublishSubject<Int8>()
    let requestCategory = PublishSubject<Bool>()
    
    lazy var requestParam = XMHQGAlbumRequest()
    
    private var loadingView: XMLoadingView?
    
    deinit {
        print("销毁了")
    }
    
    init(_ adapter: ListAdapter) {
        loadingView = XMLoadingView.showLoadingView(view: adapter.viewController?.view, loadingType: XMLoadingView.LoadingType.loading)
        let requestTopParam = XMHQGTopRequest()
        
        let resultTop = requestTop.flatMapLatest {[weak self] (drop) -> Single<XMHighQualityGoodsResponse<XMHighQualityGoodsModel>> in
            XMLoadingView.startAnimation(self?.loadingView)
            return base_provider.rx.base_rx_request_model(target: BaseAPI(request: requestTopParam), model: XMHighQualityGoodsResponse<XMHighQualityGoodsModel>.self, callbackQueue: DispatchQueue.global())
        }
        
        let categoryRequest = XMHQGCatrgoryRequest()
        let resultCategory = requestCategory.flatMapLatest { (param) -> Single<XMHighQualityGoodsResponse<XMHighQualityGoodsModel>> in
            base_provider.rx.base_rx_request_model(target: BaseAPI(request: categoryRequest), model: XMHighQualityGoodsResponse<XMHighQualityGoodsModel>.self, callbackQueue: DispatchQueue.global())
        }
        
        Observable.combineLatest(resultTop, resultCategory).subscribe {[weak self] (result_top, result_word) in
            if result_top.ret == 0 {
                if let resultModels = result_top.resultModel?.moduleModels {
                    for resultModel in resultModels {
                        if let layout = XMHQGLayout(resultModel) {
                            self?.layouts.append(layout)
                        }
                        
                    }
                }
            }
            if result_word.ret == 0 {
                if let resultTitles = result_word.resultModel?.titleModels {
                    let layout = XMHQGLayout(titleModels: resultTitles)
                    self?.currentLayout = layout
                    self?.layouts.append(layout)
                    if self?.currentLayout != nil {
                        self?.requestAlbum.onNext(0)
                    }
                }
            }
            DispatchQueue.main.async {
                XMLoadingView.disMiss(loadingView: &(self!.loadingView))
                adapter.performUpdates(animated: true, completion: nil)
                
            }
        } onError: { (error) in
            
        }.disposed(by: disposeBag)

        requestAlbum.flatMapLatest {[weak self] (categoryId) -> Single<XMHighQualityGoodsResponse<XMHighQualityGoodsModel>> in
            self?.requestParam.categoryId = categoryId
            return base_provider.rx.base_rx_request_model(target: BaseAPI(request: (self?.requestParam)!), model: XMHighQualityGoodsResponse<XMHighQualityGoodsModel>.self, callbackQueue: DispatchQueue.global())
        }.subscribe {[weak self] (result) in
            if result.ret == 0 {
                if let resultAlbums = result.resultModel?.albums {
                    var albumLayouts = [XMHQGAlbumLayout]()
                    for album in resultAlbums {
                        let layout = XMHQGAlbumLayout(album: album)
                        albumLayouts.append(layout)
                    }
                    if self?.currentLayout != nil {
                        if self?.requestParam.offset == 0 {
                            self?.currentLayout!.albumLayouts.removeAll()
                        }
                        
                        self?.currentLayout?.albumLayouts += albumLayouts
                        DispatchQueue.main.async {
                            adapter.reloadData { (finish) in
                                if self?.requestParam.offset == 0 {
                                    adapter.collectionView?.refresh_status = .DropDownSuccess
                                }else {
                                    adapter.collectionView?.refresh_status = .PullSuccessHasMoreData
                                }
                                self?.requestParam.offset = result.resultModel!.offset
                            }
                        }
                    }
                }
            }
        } onError: { (error) in
        }.disposed(by: disposeBag)
    }
}
