//
//  XMAdResponse.swift
//  himalaya
//
//  Created by Farben on 2020/8/10.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import ObjectMapper
class XMAdResponse<T: Mappable>: BaseResponse<T> {
    
    
    var adModels: [T]?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    override init() {
        super.init()
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        adModels          <- map["data"]
//        bodys             <- map["body"]
    }
}
//http://adse.ximalaya.com/ting/preload/ts-1597719401495?device=iPhone&xt=1597719401496&network=WIFI&scale=2&operator=3&version=6.6.93&appid=0&name=preload

class XMPreloadAdRequest: BaseRequest {
    var device: String = "iPhone" //
    var xt: Int64 = getTimeStamp()
    var network: String = "WIFI"
    var scale: Int = 2
    var operator_id: Int = 3
    var version: String = "6.6.93"
    var appid: Int = 0 //
    var name: String = "preload"
    
    override var baseUrl: URL {
           return URL(string: "http://adse.ximalaya.com")!
       }
       
       override var path: String {
           let pathStr = "/ting/preload/ts-\(getTimeStamp())"
           return pathStr
       }
       
       override var method: RequestMethod {
           return .get
       }
       
       override init() {
           super.init()
       }
       required init?(map: Map) {
           super.init(map: map)
       }
           
       override func mapping(map: Map) {
           super.mapping(map: map)
           device         >>> map["device"]
           xt         >>> map["xt"]
           network         >>> map["network"]
           scale         >>> map["scale"]
           operator_id         >>> map["operator"]
           version         >>> map["version"]
           appid         >>> map["appid"]
           name         >>> map["name"]
       }
    
    
}

//http://adse.ximalaya.com/ting/loading/ts-1597722203033?appid=0&device=iPhone&name=loading_v2&network=WIFI&operator=3&positionId=1&preRequestAdIds=&scale=2&secure=0&userAgent=Mozilla%2F5.0%20%28iPhone%3B%20CPU%20iPhone%20OS%2012_4_7%20like%20Mac%20OS%20X%29%20AppleWebKit%2F605.1.15%20%28KHTML%2C%20like%20Gecko%29%20Mobile%2F15E148&version=6.6.93&xt=1597722203033
class XMAdRequest: BaseRequest {
    
    
    var positionId: Int = 1
    var secure: Int = 0
    var userAgent: String = "Mozilla%2F5.0%20%28iPhone%3B%20CPU%20iPhone%20OS%2012_4_7%20like%20Mac%20OS%20X%29%20AppleWebKit%2F605.1.15%20%28KHTML%2C%20like%20Gecko%29%20Mobile%2F15E148"
    
    
    
    var device: String = "iPhone" //
    var xt: Int64 = getTimeStamp()
    
    var network: String = "WIFI"
    
    var scale: Int = 2
    
    var operator_id: Int = 3
    
    var version: String = "6.6.93"
    
    var appid: Int = 0 //
    var name: String = "loading_v2"
    
    
    override var baseUrl: URL {
        return URL(string: "http://adse.ximalaya.com")!
    }
    
    override var path: String {
        let pathStr = "/ting/loading/ts-\(getTimeStamp())"
        return pathStr
    }
    
    override var method: RequestMethod {
        return .get
    }
    
    override init() {
        super.init()
    }
    required init?(map: Map) {
        super.init(map: map)
    }
        
    override func mapping(map: Map) {
        super.mapping(map: map)
        device         >>> map["device"]
        xt         >>> map["xt"]
        network         >>> map["network"]
        scale         >>> map["scale"]
        operator_id         >>> map["operator"]
        version         >>> map["version"]
        appid         >>> map["appid"]
        name         >>> map["name"]
        positionId         >>> map["positionId"]
        secure         >>> map["secure"]
        userAgent         >>> map["userAgent"]
    }
}
