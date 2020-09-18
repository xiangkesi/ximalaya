//
//  XMLiveViewModel.swift
//  himalaya
//
//  Created by Farben on 2020/9/1.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import RxSwift
import IGListKit

class XMLiveViewModel {
    
    let disposeBag = DisposeBag()
    
    let rankRequest = XMLiveRankRequest()
    private let rankRequestPublish = PublishSubject<Bool>()
    
    
    let focusImageRequest = XMLiveFocusImageRequest()
    private let focusRequestPublish = PublishSubject<Bool>()
    
    let liveRequest = XMLiveRequest()
    private let liveHotRequestPublish = PublishSubject<Bool>()
    
    
    let liveCommonRequestPublish = PublishSubject<Bool>()
    
    
    let resultCategoryVoLists = PublishSubject<XMLiveCategoryLayout>()
    
    private var loadingView: XMLoadingView?
    
    lazy var layouts = [XMLiveLayout]()
    private var isHaveValue: Bool = false
    init(adapter: ListAdapter) {
        
        loadingView = XMLoadingView.showLoadingView(view: adapter.viewController?.view, loadingType: XMLoadingView.LoadingType.loading)
        let resultRank = rankRequestPublish.flatMapLatest { (finish) -> Single<XMLiveResponse<XMLiveRankDataModel>> in
            return base_provider.rx.base_rx_request_model(target: BaseAPI(request: self.rankRequest), model: XMLiveResponse<XMLiveRankDataModel>.self, callbackQueue: DispatchQueue.global())
        }
        let resultFocusImage = focusRequestPublish.flatMapLatest { (finish) -> Single<XMLiveResponse<XMLiveFocusImageModel>> in
            return base_provider.rx.base_rx_request_model(target: BaseAPI(request: self.focusImageRequest), model: XMLiveResponse<XMLiveFocusImageModel>.self, callbackQueue: DispatchQueue.global())
        }
        let resultLive = liveHotRequestPublish.flatMapLatest {[weak self] (finish) -> Single<XMLiveResponse<XMLiveModel>> in
            XMLoadingView.startAnimation(self?.loadingView)
            self?.liveRequest.pageId = 1
            self?.liveRequest.sign = 2
            return base_provider.rx.base_rx_request_model(target: BaseAPI(request: self!.liveRequest), model: XMLiveResponse<XMLiveModel>.self, callbackQueue: DispatchQueue.global())
        }
        Observable.combineLatest(resultRank, resultFocusImage, resultLive).subscribe(onNext: { (rankResult, focusResult, liveResult) in
            self.layouts.removeAll()
            if liveResult.ret == 0 {
                if let lives = liveResult.model?.lives, lives.count > 0 {
                    self.liveRequest.pageId = liveResult.model!.pageId + 1
                    for (index, live) in lives.enumerated() {
                        if index == 4 {
                            if let hotModule = liveResult.model?.hotModule {
                            let layout = XMLiveLayout(hotModule: hotModule)
                                self.layouts.append(layout)
                            }
                        }
                        let layout = XMLiveLayout(hallModel: live)
                        self.layouts.append(layout)
                    }
                }
            }
            if focusResult.ret == 0 {
                if let focusImages = focusResult.focusImages, focusImages.count > 0 {
                    let layout = XMLiveLayout(focusImages: focusImages)
                    if self.layouts.count > 8 {
                        self.layouts.insert(layout, at: 9)
                    }else{
                        self.layouts.append(layout)
                    }
                }
            }
            if rankResult.ret == 0 {
                if let ranks = rankResult.model?.rankSection, ranks.count > 0 {
                    let layout = XMLiveLayout(rank: rankResult.model!)
                    if self.layouts.count > 13 {
                        self.layouts.insert(layout, at: 14)
                    }else{
                        self.layouts.append(layout)
                    }
                }
            }
            DispatchQueue.main.async {
                XMLoadingView.disMiss(loadingView: &self.loadingView)
                if let categoryVoLists = liveResult.model?.categoryVoLists, self.isHaveValue == false {
                    self.isHaveValue = true
                    let layout = XMLiveCategoryLayout(lists: categoryVoLists)
                    self.resultCategoryVoLists.onNext(layout)
                }
                adapter.performUpdates(animated: true) {[weak adapter] (finish) in
                    adapter?.collectionView?.refresh_status = .DropDownSuccess
                }
            }
            
        }, onError: { (error) in
            
        }).disposed(by: disposeBag)
        
        
        liveCommonRequestPublish.flatMapLatest {[weak self] (drop) -> Single<XMLiveResponse<XMLiveModel>> in
            self?.liveRequest.isRefreshHeader = drop
            if drop == true {self?.liveRequest.pageId = 1}
            self?.liveRequest.sign = 1
            return base_provider.rx.base_rx_request_model(target: BaseAPI(request: self!.liveRequest), model: XMLiveResponse<XMLiveModel>.self, callbackQueue: DispatchQueue.global())
        }.subscribe(onNext: {[weak self] (result) in
            if result.ret == 0 {
                if let lives = result.model?.lives, lives.count > 0 {
                    if result.model?.pageId == 1 {
                        self?.layouts.removeAll()
                    }
                    if result.model?.lastPage == false {
                        self?.liveRequest.pageId = result.model!.pageId + 1
                    }
                    for live in lives {
                        let layout = XMLiveLayout(hallModel: live)
                        self?.layouts.append(layout)
                    }
                    DispatchQueue.main.async {
                        adapter.performUpdates(animated: true, completion: nil)
                        adapter.collectionView?.refresh_status = .DropDownSuccess
                        adapter.collectionView?.refresh_status = result.model?.lastPage == true ? .PullSuccessNoMoreData : .PullSuccessHasMoreData
                        
                    }
                }
            }
            
        }, onError: { (error) in
            DispatchQueue.main.async {
                adapter.collectionView?.refresh_status = .DropDownSuccess
                adapter.collectionView?.refresh_status = .PullSuccessNoMoreData
            }
        }).disposed(by: disposeBag)
        
    }
    
    func request() {
        rankRequestPublish.onNext(true)
        focusRequestPublish.onNext(true)
        liveHotRequestPublish.onNext(true)
//        for index in 14..<15 {
//                   if let path = Bundle.main.path(forResource: "home\(index)", ofType: "json"),
//                      let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
//                       let jsonString = String(data: data, encoding: String.Encoding.utf8),
//                       let result = XMLiveResponse<XMLiveRankDataModel>(JSONString: jsonString) {
//                       if result.ret == 0 {
//                        if let ranks = result.model?.rankSection, ranks.count > 0 {
////                            print("一共有几个呢\(ranks.count)")
//                            let layout = XMLiveLayout(rank: result.model!)
//                            self.layouts.append(layout)
//                        }
//                       }
//                   }
//               }
//
//        for index in 15..<16 {
//            if let path = Bundle.main.path(forResource: "home\(index)", ofType: "json"),
//               let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
//                let jsonString = String(data: data, encoding: String.Encoding.utf8),
//                let result = XMLiveResponse<XMLiveFocusImageModel>(JSONString: jsonString) {
//                if result.ret == 0 {
//                    if let focusImages = result.focusImages, focusImages.count > 0 {
//                        let layout = XMLiveLayout(focusImages: focusImages)
//                        layouts.append(layout)
//
//                    }
//                }
//            }
//        }
//
//        for index in 16..<17 {
//                   if let path = Bundle.main.path(forResource: "home\(index)", ofType: "json"),
//                       let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
//                       let jsonString = String(data: data, encoding: String.Encoding.utf8),
//                       let result = XMLiveResponse<XMLiveModel>(JSONString: jsonString) {
//                       if result.ret == 0 {
//                        if let lives = result.model?.lives, lives.count > 0 {
//                            for (index, live) in lives.enumerated() {
//                                if index == 4 {
//                                    if let hotModule = result.model?.hotModule {
//                                        let layout = XMLiveLayout(hotModule: hotModule)
//                                        layouts.append(layout)
//                                    }
//                                }
//                                let layout = XMLiveLayout(hallModel: live)
//                                layouts.append(layout)
//                            }
//                        }
//                           if let categoryVoLists = result.model?.categoryVoLists {
//                            let layout = XMLiveCategoryLayout(lists: categoryVoLists)
//                               resultCategoryVoLists.onNext(layout)
//                           }
//                       }
//                   }
//        }
    }
}
