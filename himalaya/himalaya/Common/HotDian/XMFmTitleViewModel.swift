//
//  XMFmTitleViewModel.swift
//  himalaya
//
//  Created by cocoazhang on 2020/9/11.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import RxSwift
import IGListKit

@objc protocol XMFmTitleViewModelDelegate {
    func loadTitlesFInish()
    
    func loadTitleDetailsFInish()
}

class XMFmTitleViewModel {
    
    weak var delegate: XMFmTitleViewModelDelegate?
    
    let requestTitlePublish = PublishSubject<Bool>()
    let requestDetailPublish = PublishSubject<XMFmTitleModel>()
    let requestModel = XMFmTitleDetailRequest()
    
    
    lazy var titleItems = [XMFmTitleModel]()
    
    let disposeBag = DisposeBag()
    
    
    var currentTitleItem: XMFmTitleModel?
    init() {
        
        
        requestTitlePublish.flatMapLatest { (drop) -> Single<XMFmTitleResponse<XMFmModel>> in
            let requestTitle = XMFmTitleRequest()
            return base_provider.rx.base_rx_request_model(target: BaseAPI(request: requestTitle), model: XMFmTitleResponse<XMFmModel>.self, callbackQueue: DispatchQueue.global())
        }.subscribe(onNext: { (result) in
            if result.ret == 0 {
                if let titleModels = result.data?.titleModels, let firstModel = titleModels.first {
                    self.titleItems += titleModels
                    self.currentTitleItem = firstModel
                    DispatchQueue.main.async {
                        if self.delegate != nil {
                            self.delegate?.loadTitlesFInish()
                        }
                        self.requestDetailPublish.onNext(self.currentTitleItem!)
                    }
                    
                    
                }
            }
        }, onError: { (error) in
            
        }).disposed(by: disposeBag)
        
        requestDetailPublish.flatMapLatest { (titleModel) -> Single<XMFmTitleResponse<XMFmModel>> in
            self.requestModel.currentIndex = titleModel.index
            self.requestModel.channelId = titleModel.channelId
            self.requestModel.cover = titleModel.cover
            return base_provider.rx.base_rx_request_model(target: BaseAPI(request: self.requestModel), model: XMFmTitleResponse<XMFmModel>.self, callbackQueue: DispatchQueue.global())
        }.subscribe(onNext: { (result) in
            if result.ret == 0 {
                if self.currentTitleItem?.index == 0 {
                    if let detailModels = result.trackInfo?.listModels {
                        self.currentTitleItem?.listModels = detailModels
                    }
                }else {
                    if let detailModels = result.trackInfo?.detailInfoModels {
                        self.currentTitleItem?.listInfoModels = detailModels
                    }
                }
                DispatchQueue.main.async {
                    if self.delegate != nil {
                        self.delegate?.loadTitleDetailsFInish()
                    }
                }
            }
        }, onError: { (error) in
            
        }).disposed(by: disposeBag)
        
//        if let path = Bundle.main.path(forResource: "voice5", ofType: "json"),
//            let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
//            let jsonString = String(data: data, encoding: String.Encoding.utf8),
//            let result = XMFmTitleResponse<XMFmModel>.init(JSONString: jsonString) {
//            if result.ret == 0 {
//                if let titles = result.data?.titleModels, titles.count > 0 {
//                    titleItems += titles
//                }
//            }
//        }
        
      
        
//        if let path = Bundle.main.path(forResource: "voice3", ofType: "json"),
//            let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
//            let jsonString = String(data: data, encoding: String.Encoding.utf8),
//            let result = XMFmTitleResponse<XMFmCurrentTrackModel>.init(JSONString: jsonString) {
//            if result.ret == 0 {
//                if let titles = result.trackInfo {
//
//                }
//            }
//        }
        
    }
    
    func requestLists() -> [XMFmDetailListModel]? {
        if let path = Bundle.main.path(forResource: "voice4", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
            let jsonString = String(data: data, encoding: String.Encoding.utf8),
            let result = XMFmTitleResponse<XMFmModel>.init(JSONString: jsonString) {
            if result.ret == 0 {
                return result.trackInfo?.listModels
            }
        }
        return nil
    }
    
}
