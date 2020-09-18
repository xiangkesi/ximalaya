//
//  HomeViewModel.swift
//  himalaya
//
//  Created by Farben on 2020/8/6.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import RxSwift
import IGListKit

class HomeViewModel {
    
    let requestHome = PublishSubject<Bool>()
    
    let disposeBag = DisposeBag()
    private var behaviorDisposable: Disposable?
    private lazy var request = HomeRequest()
    
    let banderResult = PublishSubject<[HomeLayout]>()
    
    lazy var layouts = [HomeLayout]()
    
    private var loadingView: XMLoadingView?
    
    private func JSONResponseDataFormatter(_ data: Data) -> String {
        do {
            let dataAsJSON = try JSONSerialization.jsonObject(with: data)
            let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
            return String(data: prettyData, encoding: .utf8) ?? String(data: data, encoding: .utf8) ?? ""
        } catch {
            return String(data: data, encoding: .utf8) ?? ""
        }
    }
    
     var ads:[XMAdModel]?
    
    init(adapter: ListAdapter) {
//        loadingView = XMLoadingView.showLoadingView(view: adapter.viewController?.view, loadingType: XMLoadingView.LoadingType.loading)
        
        if let adPath = Bundle.main.path(forResource: "adjson", ofType: "json"), let adData = NSData(contentsOfFile: adPath) as Data? {
            let jsonString = self.JSONResponseDataFormatter(adData)
            if let result = XMAdResponse<XMAdModel>.init(JSONString: jsonString) {
                if result.ret == 0 {
                    ads = result.adModels
                }
            }
        }
        
        for index in 1..<17 {
            if let adPath = Bundle.main.path(forResource: "home\(index)", ofType: "json"), let adData = NSData(contentsOfFile: adPath) as Data? {
                let jsonString = self.JSONResponseDataFormatter(adData)
                if let result = HomeResponse<HomeModel>.init(JSONString: jsonString) {
                    if result.ret == 0 {
                        var resultLayouts = [HomeLayout]()
                        if let arrayHeader = result.hearders, arrayHeader.count > 0 {
                            for heder in arrayHeader {
                                let layout = HomeLayout(model: heder)
                                resultLayouts.append(layout)
                            }
                        }
                        if let arrayBodys = result.bodys, arrayBodys.count > 0 {
                            for bodyItem in arrayBodys {
                                let layout = HomeLayout(model: bodyItem)
                                if layout.cellType == .module(.ad) {
                                    if let ads = self.ads, ads.count > 0 {
                                        layout.currentAd = ads[Int(arc4random()) % ads.count]
                                    }
                                }
                                resultLayouts.append(layout)
                            }
                        }
                        self.layouts += resultLayouts
                    }
                }
            }
        }
        
//        requestHome.subscribe(onNext: { (isDrop) in
//            self.behaviorDisposable = BehaviorSubject(value: isDrop).flatMapLatest { (drop) -> Single<HomeResponse<HomeModel>> in
//                self.request.onlyBody = drop
//                XMLoadingView.startAnimation(self.loadingView)
//                return base_provider.rx.base_rx_request_model(target: BaseAPI(request: self.request), model: HomeResponse<HomeModel>.self, callbackQueue: DispatchQueue.global())
//            }.subscribe(onNext: { (result) in
//                if result.ret == 0 {
//                    if self.request.onlyBody == false {//第一次刷新或者下拉刷新
//                        if self.request.isReadCache == false {
//                             XMReadWriteCache.xmCacheDisk().saveData(result.toJSON(), "home_save")
//                        }
//                        self.request.isReadCache = false
//                        self.layouts.removeAll()
//                    }
//                    self.request.offset = result.offset
//                    self.request.index += 1
//                    var resultLayouts = [HomeLayout]()
//                    if let arrayHeader = result.hearders, arrayHeader.count > 0 {
//                        for heder in arrayHeader {
//                            let layout = HomeLayout(model: heder)
//                            resultLayouts.append(layout)
//                        }
//                    }
//                    if let arrayBodys = result.bodys, arrayBodys.count > 0 {
//                        for bodyItem in arrayBodys {
//                            let layout = HomeLayout(model: bodyItem)
//                            if layout.cellType == .module(.ad) {
//                                layout.ads = self.ads
//                            }
//                            resultLayouts.append(layout)
//                        }
//                    }
//                    self.layouts += resultLayouts
//                    DispatchQueue.main.async {
//                        if self.layouts.count == 0 {
//                            XMLoadingView.noMoreData(self.loadingView)
//                            return
//                        }
//                        XMLoadingView.disMiss(loadingView: &self.loadingView)
//                        adapter.performUpdates(animated: true) { (finish) in
//                            if self.request.onlyBody == false {//下拉成功
//                                adapter.collectionView?.refresh_status = .DropDownSuccess
//                            }else {
//                                adapter.collectionView?.refresh_status = .PullSuccessHasMoreData
//                            }
//                        }
//                    }
//                }
//                self.behaviorDisposable?.dispose()
//            }, onError: { (error) in
//                DispatchQueue.main.async {
//                    XMLoadingView.netError(self.loadingView) {[weak self] in
//                        self?.requestHome.onNext(false)
//                    }
//                    adapter.collectionView?.refresh_status = .InvalidData
//                }
//                self.behaviorDisposable?.dispose()
//            })
//        }).disposed(by: disposeBag)

        
        
//        requestHome.flatMapLatest { (isDrop) -> Single<HomeResponse<HomeModel>> in
//            self.request.onlyBody = isDrop
//            XMLoadingView.startAnimation(self.loadingView)
//
//            if let jsonDic = XMReadWriteCache.xmCacheDisk().readData("home_save"),
//                let result = HomeResponse<HomeModel>.init(JSON: jsonDic), self.request.isReadCache == true {
//                return Single.just(result)
//            }
//            return base_provider.rx.base_rx_request_model(target: BaseAPI(request: self.request), model: HomeResponse<HomeModel>.self, callbackQueue: DispatchQueue.global())
//        }.subscribe(onNext: { (result) in
//            if result.ret == 0 {
//                if self.request.onlyBody == false {//第一次刷新或者下拉刷新
//                    if self.request.isReadCache == false {
//                         XMReadWriteCache.xmCacheDisk().saveData(result.toJSON(), "home_save")
//                    }
//                    self.request.isReadCache = false
//                    self.layouts.removeAll()
//                }
//                self.request.offset = result.offset
//                self.request.index += 1
//                var resultLayouts = [HomeLayout]()
//                if let arrayHeader = result.hearders, arrayHeader.count > 0 {
//                    for heder in arrayHeader {
//                        let layout = HomeLayout(model: heder)
//                        resultLayouts.append(layout)
//                    }
//                }
//                if let arrayBodys = result.bodys, arrayBodys.count > 0 {
//                    for bodyItem in arrayBodys {
//                        let layout = HomeLayout(model: bodyItem)
//                        if layout.cellType == .module(.ad) {
//                            layout.ads = self.ads
//                        }
//                        resultLayouts.append(layout)
//                    }
//                }
//                self.layouts += resultLayouts
//                DispatchQueue.main.async {
//                    if self.layouts.count == 0 {
//                        XMLoadingView.noMoreData(self.loadingView)
//                        return
//                    }
//                    XMLoadingView.disMiss(loadingView: &self.loadingView)
//                    adapter.performUpdates(animated: true) { (finish) in
//                        if self.request.onlyBody == false {//下拉成功
//                            adapter.collectionView?.refresh_status = .DropDownSuccess
//                        }else {
//                            adapter.collectionView?.refresh_status = .PullSuccessHasMoreData
//                        }
//                    }
//                }
//            }
//        }, onError: {(error) in
//            self.requestHome.onCompleted()
//            DispatchQueue.main.async {
//                XMLoadingView.netError(self.loadingView)
//                if self.request.onlyBody == false {//下拉成功
//                    adapter.collectionView?.refresh_status = .DropDownSuccess
//                }else {
//                    adapter.collectionView?.refresh_status = .PullSuccessHasMoreData
//                }
//            }
//        }).disposed(by: disposeBag)
    }
}
