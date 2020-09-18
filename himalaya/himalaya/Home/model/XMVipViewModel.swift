//
//  XMVipViewModel.swift
//  himalaya
//
//  Created by Farben on 2020/8/18.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import RxSwift
import IGListKit


class XMVipViewModel {
    
    lazy var layouts = [XMVipLayout]()
    let requestTopMsg = PublishSubject<Bool>()
    let requestCategories = PublishSubject<Bool>()
    
    let requestDetail = PublishSubject<XMVipCategorieWordModel>()
    
    
    let disposeBag = DisposeBag()
    
    lazy var request = XMVipRequest()
    lazy var requestCategory = XMVipCategorieRequest()
    lazy var requestDetailParam = XMVipCategorieDetailRequest()
    weak var adapter: ListAdapter?
    
    lazy var currentLayouts = [XMVipAlbumLayout]()
    private var loadingView: XMLoadingView?
    
    func request(isDrop: Bool) {
        requestDetailParam.isDrop = isDrop
        requestDetail.onNext(self.requestDetailParam.currentWord!)
    }
    
    init(adapter: ListAdapter) {
        self.adapter = adapter
        loadingView = XMLoadingView.showLoadingView(view: adapter.viewController?.view, loadingType: XMLoadingView.LoadingType.loading)
        Observable.combineLatest(requestTopMsg.flatMapLatest { (next) -> Single<XMVipResponse<XMVipModel>> in
            XMLoadingView.startAnimation(self.loadingView)
            return base_provider.rx.base_rx_request_model(target: BaseAPI(request: self.request), model: XMVipResponse<XMVipModel>.self, callbackQueue: DispatchQueue.global())
        }, requestCategories.flatMapFirst { (next) -> Single<XMVipResponse<XMVipModel>> in
            return base_provider.rx.base_rx_request_model(target: BaseAPI(request: self.requestCategory), model: XMVipResponse<XMVipModel>.self, callbackQueue: DispatchQueue.global())
        }).subscribe(onNext: { (resultMsg, resultKeyWords) in
            if resultMsg.ret == 0 {
                if let models = resultMsg.data?.modules {
                    for model in models {
                        let layout = XMVipLayout(module: model)
                        self.layouts.append(layout)
                    }
                }
            }
            if resultKeyWords.ret == 0 {
                 if let words = resultKeyWords.data?.categorieWords, words.count > 0 {
                    self.requestDetailParam.currentWord = words.first
                    let layout = XMVipLayout(categorieWords: words)
                    self.layouts.append(layout)
                 }
            }
            DispatchQueue.main.async {
                XMLoadingView.disMiss(loadingView: &self.loadingView)
                self.adapter?.performUpdates(animated: true, completion: nil)
                if let word = self.requestDetailParam.currentWord {
                    self.requestDetail.onNext(word)
                }
                
            }
        }, onError: { (error) in
            print("哪个失败了")
        }).disposed(by: disposeBag)
        
        
        requestDetail.flatMapLatest { (wordId) -> Single<XMVipResponse<XMVipModel>> in
            self.requestDetailParam.currentWord = wordId
            return base_provider.rx.base_rx_request_model(target: BaseAPI(request: self.requestDetailParam), model: XMVipResponse<XMVipModel>.self, callbackQueue: DispatchQueue.global())
        }.map { (result) -> Bool in
            if result.ret == 0 {
                self.requestDetailParam.offset = result.data?.offset ?? 0
                if let arrayModels = result.data?.albumItems, arrayModels.count > 0 {
                    var album_layouts = [XMVipAlbumLayout]()
                    for album in arrayModels {
                        let layout = XMVipAlbumLayout(album: album)
                        album_layouts.append(layout)
                    }
                    if self.requestDetailParam.isDrop == true {
                        self.currentLayouts.removeAll()
                    }
                    self.currentLayouts += album_layouts
                    return true
                }
            }
            return false
        }.subscribe(onNext: { (finish) in
            if finish {
                DispatchQueue.main.async {
                    self.adapter?.reloadData(completion: nil)
//                    let indexSet = IndexSet.init(integer: self.layouts.count - 1)
//                    self.adapter?.collectionView?.reloadSections(indexSet)
                    if self.requestDetailParam.isDrop == true {
                        self.adapter?.collectionView?.refresh_status = .DropDownSuccess
                    }
                }
            }
        }, onError: { (error) in
            
        }).disposed(by: disposeBag)
        
//        .map{
//            if $0.ret == 0 {
//                if let arrayModels = $0.data?.albumItems, arrayModels.count > 0 {
//                    var album_layouts = [XMVipAlbumLayout]()
//                    for album in arrayModels {
//                        let layout = XMVipAlbumLayout(album: album)
//                        album_layouts.append(layout)
//                    }
//                    if let word = self.requestDetailParam.currentWord {
//                        word.layouts += album_layouts
//                    }
//                }
//            }
//        }
        
//        .subscribe(onNext: { (result) in
//            if result.ret == 0 {
//                if let arrayModels = result.data?.albumItems, arrayModels.count > 0{
//                        var album_layouts = [XMVipAlbumLayout]()
//                        for album in arrayModels {
//                            let layout = XMVipAlbumLayout(album: album)
//                            album_layouts.append(layout)
//                        }
//                    if let word = self.requestDetailParam.currentWord {
//                        word.layouts += album_layouts
//                    }
//                    DispatchQueue.main.async {
//                        adapter.reloadData(completion: nil)
////                        adapter.performUpdates(animated: true, completion: nil)
//                    }
//                }
//            }
//            print("成功了吗")
//        }, onError: { (error) in
//
//        }).disposed(by: disposeBag)
        
//        http://112.29.204.34/vip/v1/recommand/ts-1597735675839?appid=0&device=iPhone&deviceId=1605D009-7E02-4A91-B8AA-E053CE83BA30&isAppleReview=false&network=WIFI&operator=3&scale=2&uid=80567972&version=6.6.93&xt=1597735675840
//        if let adPath = Bundle.main.path(forResource: "home18", ofType: "json"), let adData = NSData(contentsOfFile: adPath) as Data? {
//            let jsonString = xmResponseDataFormatter(adData)
//
//            if let result = XMVipResponse<XMVipModel>.init(JSONString: jsonString) {
//                if result.ret == 0 {
//                    if let models = result.data?.modules {
//                        for index in 0..<models.count {
//                                let model = models[index]
//                                let layout = XMVipLayout(module: model)
//                                self.layouts.append(layout)
//                        }
//
//                    }
//                }
//            }
//        }
        
//        if let adPath = Bundle.main.path(forResource: "home17", ofType: "json"), let adData = try? Data(contentsOf: URL(fileURLWithPath: adPath)) {
//            let jsonString = xmResponseDataFormatter(adData)
//            if let result = XMVipResponse<XMVipModel>.init(JSONString: jsonString) {
//                if result.ret == 0 {
//                    if let words = result.data?.categorieWords, words.count > 0 {
//                        let layout = XMVipLayout(categorieWords: words)
//                        self.layouts.append(layout)
//                    }
//                }
//            }
//        }
        
        
//        for index in 12..<17 {//XMVipAlbumLayout
//            if let json = Bundle.main.path(forResource: "home\(index)", ofType: "json"), let data = try? Data(contentsOf: URL(fileURLWithPath: json)) {
//                let jsonString = xmResponseDataFormatter(data)
//                if let result = XMVipResponse<XMVipModel>(JSONString: jsonString) {
//                    if result.ret == 0 {
//                        if let arrayModels = result.data?.albumItems, arrayModels.count > 0 {
//                            var album_layouts = [XMVipAlbumLayout]()
//                            for album in arrayModels {
//                                let layout = XMVipAlbumLayout(album: album)
//                                album_layouts.append(layout)
//                            }
//                            if let vipLayout = self.layouts.last, let words = vipLayout.categorieWords {
//                                for word in words {
//                                    word.layouts += album_layouts
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
    }
    
}
