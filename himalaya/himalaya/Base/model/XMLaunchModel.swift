//
//  XMLaunchModel.swift
//  himalaya
//
//  Created by Farben on 2020/8/11.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import ObjectMapper
import RxSwift
//http://adse.ximalaya.com/ting/preload/ts-1597116548419?appid=0&device=android&name=preload&network=wifi&operator=1&userAgent=Dalvik/2.1.0%20(Linux;%20U;%20Android%2010;%20BMH-AN10%20Build/HUAWEIBMH-AN10)&version=6.6.93&xt=1597116548419

//http://adse.ximalaya.com/ting/loading/ts-1597192841583?appid=0&device=iPhone&name=loading_v2&network=WIFI&operator=3&positionId=1&scale=2&secure=0&userAgent=Mozilla%2F5.0%20%28iPhone%3B%20CPU%20iPhone%20OS%2012_4_7%20like%20Mac%20OS%20X%29%20AppleWebKit%2F605.1.15%20%28KHTML%2C%20like%20Gecko%29%20Mobile%2F15E148&version=6.6.93&xt=1597192841584
class XMLaunchViewModel {
    
    let requestPublish = PublishSubject<Bool>()
    private lazy var request = XMLaunchRequest()
    private let disposeBag = DisposeBag()
    
    init() {
        requestPublish.flatMapLatest { (nest) -> Single<XMLaunchResponse<XMLaunchModel>> in
            xm_provider.rx.base_rx_request_model(target: BaseAPI(request: self.request), model: XMLaunchResponse<XMLaunchModel>.self, callbackQueue: DispatchQueue.global())
        }.subscribe(onNext: { (result) in
            if result.ret == 0 {
                if let launchModels = result.launchModels {
                    for _ in launchModels {
                        
                    }
                }
            }
        }, onError: { (error) in
            
        }).disposed(by: disposeBag)
    }
}

class XMLaunchRequest: BaseRequest {
    
    override var baseUrl: URL {
        return URL(string: "http://adse.ximalaya.com")!
    }
    
    override var path: String {
        let pathStr = "/ting/preload/ts-" + "\(getTimeStamp())"
           return pathStr
    }
    override var method: RequestMethod {
        return .post
    }
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
           
    override func mapping(map: Map) {
        super.mapping(map: map)
        appid            >>> map["appid"]
        device            >>> map["device"]
        name            >>> map["name"]
        network            >>> map["network"]
        operatorType            >>> map["operator"]
        userAgent            >>> map["userAgent"]
        version            >>> map["version"]
        xt            >>> map["xt"]
        scale            >>> map["scale"]
    
    }
    
    var appid: Int = 0
    
    var device = "iPhone"
    var scale: Int = 2
    
    var name = "preload"
    var network = "wifi"
    
    var operatorType = 3
    
    var userAgent = "ting_v6.6.85_c5(CFNetwork, iOS 12.4.7, iPhone6,2)"
    
    var version = "6.6.85"
    
    var xt: Int64 = getTimeStamp()
    
    
    
    
    
}

class XMLaunchResponse<T: Mappable>: BaseResponse<T> {
    var launchModels: [T]?
        
    var adIds: [Int64]?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    override init() {
        super.init()
    }
        
    override func mapping(map: Map) {
        super.mapping(map: map)
        launchModels          <- map["data"]
    }
}
struct XMLaunchModel: Mappable {
    
    var adId: Int64 = 0
    
    var imgUrls: [String]?
    
    var startAt: Int64 = 0
    
    var endAt: Int64 = 0
    
    var videoUrls: [String]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        adId          <- map["adId"]
        imgUrls          <- map["imgUrls"]
        startAt          <- map["startAt"]
        endAt          <- map["endAt"]
        videoUrls          <- map["videoUrls"]
    }
}

