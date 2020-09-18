//
//  ActiveViewModel.swift
//  himalaya
//
//  Created by Farben on 2020/8/4.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit
import RxSwift
import IGListKit



class XMFindVoiceViewModel {
    
    lazy var layouts = [XMFindVoiceLayout]()
    let requestActive = PublishSubject<Bool>()
    let disposeBag = DisposeBag()
    lazy var request = XMFindVoiceRequest()
    
    private var loadingView: XMLoadingView?
    deinit {
        print("当前ViewModel销毁了")
    }
    init(_ adapter: ListAdapter) {
        loadingView = XMLoadingView.showLoadingView(view: adapter.viewController?.view, loadingType: XMLoadingView.LoadingType.loading)
        requestActive.flatMapLatest {[weak self] (dowm) -> Single<XMFindVoiceResponse<XMFindVoiceModel>> in
            XMLoadingView.startAnimation(self?.loadingView)
            self?.request.isDrop = dowm
            return base_provider.rx.base_rx_request_model(target: BaseAPI(request: (self?.request)!), model: XMFindVoiceResponse<XMFindVoiceModel>.self, callbackQueue: DispatchQueue.global())
        }.subscribe(onNext: {[weak self] (result) in
            if result.ret == 0 {
                if let items = result.active {
                    if self?.request.offset == 0 {
                        self?.layouts.removeAll()
                    }
                    self?.request.offset = result.offset
                    for item in items {
                        let layout = XMFindVoiceLayout(active: item)
                        self?.layouts.append(layout)
                    }
                    DispatchQueue.main.async {
                        XMLoadingView.disMiss(loadingView: &self!.loadingView)
                        adapter.performUpdates(animated: true) { (finish) in
                            if self?.request.isDrop == true {
                                adapter.collectionView?.refresh_status = .DropDownSuccess
                            }else {
                                adapter.collectionView?.refresh_status = .PullSuccessHasMoreData
                            }
                        }
                    }
                }
            }
        }, onError: {[weak adapter] (error) in
             DispatchQueue.main.async {
                adapter?.collectionView?.refresh_status = .InvalidData
            }
        }).disposed(by: disposeBag)
        
        
//                        for index in 1..<5 {
//                            if let path = Bundle.main.path(forResource: "home\(index)", ofType: "json"),
//                               let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
//                                let jsonString = String(data: data, encoding: String.Encoding.utf8),
//                                let result = XMFindVoiceResponse<XMFindVoiceModel>(JSONString: jsonString) {
//                                if result.ret == 0 {
//                                    if let items = result.active {
//                                        for (index, item) in items.enumerated() {
//                                            let layout = XMFindVoiceLayout(active: item)
//                                            self.layouts.append(layout)
//                                        }
//        
//        
//                                    }
//                                }
//                            }
//                        }
        
//        collectionView.jk_headerRefreshBlock = {[weak self] in
//            self?.request.offset = 0
//            self?.requestActive.onNext(0)
//        }
//        collectionView.jk_footerRefreshBlock = {[weak self] in
//            self?.requestActive.onNext(1)
//        }
//        requestActive.flatMapLatest {(next) -> Single<ActiveResponse<ActiveModel>> in
//            return base_provider.rx.base_rx_request_model(target: BaseAPI(request: self.request), model: ActiveResponse<ActiveModel>.self, callbackQueue: DispatchQueue.global())
//        }.subscribe(onNext: {[weak self] (result) in
//            if result.ret == 0 {
//                if self?.request.offset == 0 {
//                    self?.layouts.removeAll()
//                }
//                self?.request.offset = result.offset
//                var layouts = [ActiveLayout]()
//                if let actives = result.active {
//                    for active in actives {
//                        let layout = ActiveLayout(active: active)
//                        layouts.append(layout)
//                    }
//                    self?.layouts += layouts
//                    DispatchQueue.main.async {
//                        self?.resultLayouts.onNext((self?.layouts)!)
//                        collectionView.refresh_status = .PullSuccessHasMoreData
//                        collectionView.refresh_status = .DropDownSuccess
//                    }
//                }
//            }
//        }, onError: { (error) in
//            DispatchQueue.main.async {
//                collectionView.refresh_status = .PullSuccessHasMoreData
//                collectionView.refresh_status = .DropDownSuccess
//            }
//        }).disposed(by: disposeBag)
    }

}
