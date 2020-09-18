//
//  ShortVideoViewModel.swift
//  himalaya
//
//  Created by Farben on 2020/8/14.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import RxSwift

class ShortVideoViewModel {
    
    let requestVideo = PublishSubject<Bool>()
    
    lazy var layouts = [ShortVideoLayout]()
    let disposeBag = DisposeBag()
    
//    let resultLayouts = PublishSubject<[ShortVideoLayout]>()
    
    lazy var request = ShortVideoRequest()
    
//    let result: Observable<[ShortVideoLayout]>?
//    http://112.29.204.34/ugc-web/stream/video/v1/recommend/1597377884817?limit=20
//    http://112.29.204.34/ugc-web/stream/video/v1/recommend/1597377904210?limit=20
//    http://112.29.204.34/ugc-web/stream/video/v1/recommend/1597377906471?limit=20

    private var loadingView: XMLoadingView?
    
    init(_ collectionView: UICollectionView) {
        
//                                for index in 1..<5 {
//                                    if let path = Bundle.main.path(forResource: "home\(index)", ofType: "json"),
//                                       let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
//                                        let jsonString = String(data: data, encoding: String.Encoding.utf8),
//                                        let result = ShortVideoResponse<ShortVideoModel>(JSONString: jsonString) {
//                                        if result.ret == 0 {
//                                            if let items = result.video?.items {
//                                                for (index, item) in items.enumerated() {
//                                                    let layout = ShortVideoLayout(video: item)
//                                                    self.layouts.append(layout)
//                                                }
//
//
//                                            }
//                                        }
//                                    }
//                                }
        
//        collectionView.jk_headerRefreshBlock = {[weak self] in
//            self?.request.isFirst = true
//            self?.requestVideo.onNext(true)
//        }
//        collectionView.jk_footerRefreshBlock = {[weak self] in
//            self?.request.isFirst = false
//            self?.requestVideo.onNext(true)
//        }
//
        loadingView = XMLoadingView.showLoadingView(view: collectionView, loadingType: XMLoadingView.LoadingType.loading)
        requestVideo.flatMapLatest {[weak self] (isDrop) -> Single<ShortVideoResponse<ShortVideoModel>> in
            XMLoadingView.startAnimation(self?.loadingView)
            self?.request.isFirst = isDrop
            return Single<ShortVideoResponse<ShortVideoModel>>.create { single in
                //加载本地json模拟网络请求
                DispatchQueue.global().async {
                    Thread.sleep(forTimeInterval: 0.5)
                    if let jsonDic = XMReadOnlyCache.xmCacheDisk().readData("find_shortvideo_json\(self?.request.currentIndex ?? 0)"), let result = ShortVideoResponse<ShortVideoModel>.init(JSON: jsonDic) {
                        single(.success(result))
                    }else {
                        single(.error(DataError.cantParseJSON))
                    }
//                    if let path = Bundle.main.path(forResource: "shortVideo\(self?.request.currentIndex ?? 0)", ofType: "json"),
//                        let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
//                        let jsonString = String(data: data, encoding: String.Encoding.utf8),
//                        let result = ShortVideoResponse<ShortVideoModel>.init(JSONString: jsonString) {
//                            single(.success(result))
//                    }else {
//                        single(.error(DataError.cantParseJSON))
//                    }
                }
                return Disposables.create()
            }
            //真实网络请求
//             return base_provider.rx.base_rx_request_model(target: BaseAPI(request: (self?.request)!), model: ShortVideoResponse<ShortVideoModel>.self, callbackQueue: DispatchQueue.global())
        }.subscribe(onNext: {[weak self] (result) in
           
            if result.ret == 0 {
                self?.request.timeStamp = result.video!.timestamp
                if let videos = result.video?.items {
                    if self?.request.isFirst == true{
                        self?.layouts.removeAll()
                    }
                    self?.request.currentIndex += 1
                    for video in videos {
                        let layout = ShortVideoLayout(video: video)
                        self?.layouts.append(layout)
                    }
                    DispatchQueue.main.async {
                        collectionView.reloadData()
                        XMLoadingView.disMiss(loadingView: &self!.loadingView)
                        if self?.request.isFirst == true {
                            collectionView.refresh_status = .DropDownSuccess
                        }else {
                            collectionView.refresh_status = .PullSuccessHasMoreData
                        }
                        if result.video?.hasMore == false {
                            collectionView.refresh_status = .PullSuccessNoMoreData
                        }
                    }
                }
            }
        }, onError: { (error) in
             print("当前线程\(Thread.current)")
            DispatchQueue.main.async {
                collectionView.refresh_status = .InvalidData
            }
        }).disposed(by: disposeBag)
   
    }
    
//    func resuestData() -> ShortVideoResponse<ShortVideoModel>? {
//        var result: ShortVideoResponse<ShortVideoModel>?
//        let semaphore = DispatchSemaphore(value: 1)
//        DispatchQueue.global().async {
//            if let path = Bundle.main.path(forResource: "shortVideo\(self.request.currentIndex)", ofType: "json"),
//                let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
//                let jsonString = String(data: data, encoding: String.Encoding.utf8),
//                let result_model = ShortVideoResponse<ShortVideoModel>.init(JSONString: jsonString) {
//                    result = result_model
//                }
//            semaphore.signal()
//        }
//        semaphore.wait()
//        return result
//    }
}
