//
//  XMFindRecdViewModel.swift
//  himalaya
//
//  Created by Farben on 2020/9/3.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import RxSwift
import IGListKit

class XMFindRecdViewModel {
    
    let requestPublist = PublishSubject<Bool>()
    let request = XMFIndRecdRequest()
    let disposeBag = DisposeBag()
    
    
    
    lazy var layouts = [XMFindRecdLayout]()
    
    private var loadingView: XMLoadingView?
    init(adapter: ListAdapter) {
        loadingView = XMLoadingView.showLoadingView(view: adapter.viewController?.view, loadingType: XMLoadingView.LoadingType.loading)
        requestPublist.flatMapLatest {[weak self] (down) -> Single<XMFindRecdResponse<XMFindRecmModel>> in
//            self.request.action = down ? "down" : "up"
            XMLoadingView.startAnimation(self?.loadingView)
            self?.request.includeTopicRecommendation = down
            self?.request.currentIndex = down ? 0 : self!.request.currentIndex
            
//            XMCacheData.xmCacheDisk().saveData(result.toJSON(), "find_recd_json\(self.request.currentIndex)")
            return Single<XMFindRecdResponse<XMFindRecmModel>>.create { single in
                DispatchQueue.global().async {
                    Thread.sleep(forTimeInterval: 0.5)
                    if let json = XMReadOnlyCache.xmCacheDisk().readData("find_recd_json\(self?.request.currentIndex ?? 0)"),
                        let result = XMFindRecdResponse<XMFindRecmModel>.init(JSON: json) {
                        single(.success(result))
                    }else {
                        single(.error(DataError.cantParseJSON))
                    }
//                    if let path = Bundle.main.path(forResource: "FindRecdjson\(self?.request.currentIndex ?? 0)", ofType: "json"),
//                        let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
//                        let jsonString = String(data: data, encoding: String.Encoding.utf8),
//                        let result = XMFindRecdResponse<XMFindRecmModel>.init(JSONString: jsonString) {
//                            single(.success(result))
//                    }else {
//                        single(.error(DataError.cantParseJSON))
//                    }
                }
                return Disposables.create()
            }
//            return base_provider.rx.base_rx_request_model(target: BaseAPI(request: self.request), model: XMFindRecdResponse<XMFindRecmModel>.self, callbackQueue: DispatchQueue.global())
        }.subscribe(onNext: { (result) in
            if result.ret == 0 {
                 
//                self.request.score = result.model!.endScore
                if let items = result.model?.streamLists {
                    if self.request.currentIndex == 0 {
                        
                        self.layouts.removeAll()
                        
                    }
                    self.request.currentIndex += 1
                    for item in items {
                        let layout = XMFindRecdLayout(model: item)
                        self.layouts.append(layout)
                    }
                }
                DispatchQueue.main.async {
                    adapter.performUpdates(animated: true) { (finish) in
                        if self.request.includeTopicRecommendation == false {
//                            self.request.allCount += 15
                            if result.model?.hasMore == true {
                                adapter.collectionView?.refresh_status = .PullSuccessHasMoreData
                            }
                        }else {
                            XMLoadingView.disMiss(loadingView: &self.loadingView)
                            adapter.collectionView?.refresh_status = .DropDownSuccess
                        }
                        if result.model?.hasMore == false {
                            adapter.collectionView?.refresh_status = .PullSuccessNoMoreData
                        }
                    }
                }
            }
        }, onError: { (error) in
            DispatchQueue.main.async {
                adapter.collectionView?.refresh_status = .InvalidData
            }
        }).disposed(by: disposeBag)
    }
}
