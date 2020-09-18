//
//  XMSleepHomeViewModel.swift
//  himalaya
//
//  Created by Farben on 2020/9/14.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import RxSwift
import IGListKit

class XMSleepHomeViewModel {
    
    lazy var detailModels = [XMSleepDetailModel]()
    let disposeBag = DisposeBag()
    
    
    let requestPublish = PublishSubject<Int>()
    
    
    init(adapter: ListAdapter) {
        requestPublish.flatMapLatest { (type) -> Single<XMSleepResponse<XMSleepDetailModel>> in
            return Single<XMSleepResponse<XMSleepDetailModel>>.create { single in
                DispatchQueue.global().async {
                    if let path = Bundle.main.path(forResource: "sleep\(type)", ofType: "json"),
                        let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
                        let jsonString = String(data: data, encoding: String.Encoding.utf8),
                        let result = XMSleepResponse<XMSleepDetailModel>.init(JSONString: jsonString) {
                            if result.ret == 0 {
                                if let models = result.titleModels, models.count > 0 {
                                    self.detailModels.removeAll()
                                    if type == 4 {
                                        let firstModel = XMSleepDetailModel(100)
                                        self.detailModels.append(firstModel)
                                    }
                                }
                            }
                         single(.success(result))
                    }else {
                        single(.error(DataError.cantParseJSON))
                    }
                }
                return Disposables.create()
            }
        }.subscribe(onNext: { (result) in
            if result.ret == 0 {
                if let models = result.titleModels, models.count > 0 {
                    self.detailModels += models
                    let footModel = XMSleepDetailModel(103)
                    self.detailModels.append(footModel)
                    
                    DispatchQueue.main.async {
                        adapter.performUpdates(animated: true, completion: nil)
                    }
                }
            }
        }, onError: { (error) in
            
        }).disposed(by: disposeBag)
    }
}
