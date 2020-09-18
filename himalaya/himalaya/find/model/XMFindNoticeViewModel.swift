//
//  XMFindNoticeViewModel.swift
//  himalaya
//
//  Created by Farben on 2020/9/8.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import RxSwift
import IGListKit

class XMFindNoticeViewModel {
    
    let requestPublist = PublishSubject<Bool>()
    let disposeBag = DisposeBag()
    lazy var layouts = [XMFindRecdLayout]()
    let request = XMFIndRecdRequest()
    private var loadingView: XMLoadingView?
    
    private var noticeHeadLayout = XMFindRecdLayout()
    init(adapter: ListAdapter) {
        loadingView = XMLoadingView.showLoadingView(view: adapter.viewController?.view, loadingType: XMLoadingView.LoadingType.loading)
        
        if let path = Bundle.main.path(forResource: "voice0", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
            let jsonString = String(data: data, encoding: String.Encoding.utf8), let result = XMFindRecdResponse<XMCycleModel>.init(JSONString: jsonString) {
            if result.ret == 0 {
                noticeHeadLayout.noticeHeadModel = result.model
            }
        }
        
        requestPublist.flatMapLatest {[weak self] (down) -> Single<XMFindRecdResponse<XMFindRecmModel>> in
            XMLoadingView.startAnimation(self?.loadingView)
            self?.request.includeTopicRecommendation = down
            self?.request.currentIndex = down ? 0 : self!.request.currentIndex
            return Single<XMFindRecdResponse<XMFindRecmModel>>.create { single in
                        DispatchQueue.global().async {
                            Thread.sleep(forTimeInterval: 0.5)
//                             XMCacheData.xmCacheDisk().saveData(result.toJSON(), "find_notice_json\(self.request.currentIndex)")
                            if let json = XMReadOnlyCache.xmCacheDisk().readData("find_notice_json\(self?.request.currentIndex ?? 0)"),
                                let result = XMFindRecdResponse<XMFindRecmModel>.init(JSON: json) {
                                single(.success(result))
                            }else {
                                single(.error(DataError.cantParseJSON))
                            }
                        }
                        return Disposables.create()
                    }
        }.subscribe(onNext: { (result) in
            if result.ret == 0 {
                if let items = result.model?.noticeLines {
                    if self.request.currentIndex == 0 {
                        self.layouts.removeAll()
                        self.layouts.append(self.noticeHeadLayout)
                    }
                    self.request.currentIndex += 1
                    for item in items {
                        let layout = XMFindRecdLayout(model: item)
                        self.layouts.append(layout)
                    }
                    DispatchQueue.main.async {
                        XMLoadingView.disMiss(loadingView: &self.loadingView)
                          adapter.performUpdates(animated: true) { (finish) in
                                if self.request.includeTopicRecommendation == false {
                                    if result.model?.hasMore == true {
                                        adapter.collectionView?.refresh_status = .PullSuccessHasMoreData
                                    }
                                }else {
                                    adapter.collectionView?.refresh_status = .DropDownSuccess
                                }
                                if result.model?.hasMore == false {
                                    adapter.collectionView?.refresh_status = .PullSuccessNoMoreData
                                }
                        }
                    }
                }
            }
        }, onError: { (error) in
            
        }).disposed(by: disposeBag)
        
//        for index in 2..<3 {
//            if let path = Bundle.main.path(forResource: "home\(index)", ofType: "json"),
//                let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
//                let jsonString = String(data: data, encoding: String.Encoding.utf8),
//                let result = XMFindRecdResponse<XMFindRecmModel>(JSONString: jsonString) {
//                if result.ret == 0 {
//                    if let items = result.model?.noticeLines {
//                        for (index, item) in items.enumerated() {
//                            //                                    if index == 15 {
//                            //                                    if item.type == "FeedItem" {
//                            let layout = XMFindRecdLayout(model: item)
//                            self.layouts.append(layout)
//                            //                                    }
//                            //                                    }
//
//                        }
//
//
//                    }
//                }
//            }
//        }
    }
}
