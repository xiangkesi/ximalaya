//
//  ArrayExtension.swift
//  gokarting
//
//  Created by Farben on 2020/7/21.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper
extension Array {
    
    var mapArrray: Observable<Any> {
        return Observable.create { (obs) -> Disposable in
            for item in self {
                obs.onNext(item)
            }
            obs.onCompleted()
            return Disposables.create()
        }
    }
    
}
