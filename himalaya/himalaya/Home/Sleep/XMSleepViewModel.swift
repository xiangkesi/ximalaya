//
//  XMSleepViewModel.swift
//  himalaya
//
//  Created by cocoazhang on 2020/9/13.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import RxSwift

class XMSleepViewModel {
    
    let disposeBag = DisposeBag()
    let titlesResult = PublishSubject<Bool>()
    let titleRequest = PublishSubject<Bool>()
    
    
    lazy var titleModels = [XMSleepTitleModel]()
    init() {
        titleRequest.flatMapLatest {(next) -> Single<XMSleepResponse<XMSleepTitleModel>> in
            return Single<XMSleepResponse<XMSleepTitleModel>>.create { single in
                DispatchQueue.global().async {
                    if let path = Bundle.main.path(forResource: "sleepTitle", ofType: "json"),
                        let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
                        let jsonString = String(data: data, encoding: String.Encoding.utf8),
                        let result = XMSleepResponse<XMSleepTitleModel>.init(JSONString: jsonString) {
                        single(.success(result))
                     }else {
                        single(.error(DataError.cantParseJSON))
                     }
                }
                return Disposables.create()
            }
        }.subscribe(onNext: {[weak self] (result) in
            if result.ret == 0 {
                if let models = result.titleModels, models.count > 0 {
                    self?.titleModels = models
                    DispatchQueue.main.async {
                        self?.titlesResult.onNext(true)
                    }
                }
            }
        }, onError: { (error) in

        }).disposed(by: disposeBag)
        
        
        
//        if let path = Bundle.main.path(forResource: "sleepTitle", ofType: "json"),
//            let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
//            let jsonString = String(data: data, encoding: String.Encoding.utf8),
//            let result = XMSleepResponse<XMSleepTitleModel>.init(JSONString: jsonString) {
//                if result.ret == 0 {
//                    if let models = result.titleModels, models.count > 0 {
//                        titleModels += models
//                    }
//                }
//            }
    }
}

