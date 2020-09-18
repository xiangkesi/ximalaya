//
//  XMHQGTopRequest.swift
//  himalaya
//
//  Created by Farben on 2020/9/17.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import ObjectMapper
//http://mobwsa.ximalaya.com/product/v2/payable/channel/recommend/ts-1600325825559?appid=0&device=iPhone&deviceId=1605D009-7E02-4A91-B8AA-E053CE83BA30&isAppleReview=false&network=WIFI&operator=3&scale=2&uid=80567972&version=6.7.3&xt=1600325825559

//http://mobwsa.ximalaya.com/product/feed/v1/categories/ts-1600325825733?device=iPhone&isAppleReview=false&source=payable

class XMHQGCatrgoryRequest: BaseRequest {
    
    
    var device = "iPhone"
    var isAppleReview = false
    var source = "payable"
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override var baseUrl: URL {
        return URL(string: "http://mobwsa.ximalaya.com")!
    }
    
    override var path: String {
        let pathStr = "/product/feed/v1/categories/ts-\(getTimeStamp())"
        return pathStr
    }
    
    override var method: RequestMethod {
        return .get
    }
    
    override var headerDic: [String : String]? {
        return ["Host" : "mobwsa.ximalaya.com"]
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        isAppleReview                          >>> map["isAppleReview"]
        device                          >>> map["device"]
        source                          >>> map["source"]
    }
}

class XMHQGTopRequest: BaseRequest {
    
    override init() {
        super.init()
    }
    
    var appid: Int = 0
    var device = "iPhone"
    var deviceId = "1605D009-7E02-4A91-B8AA-E053CE83BA30"
    var isAppleReview = false
    var network = "WIFI"
    var operatorId = 3
    var scale = 2
    var uid = 80567972
    var version = "6.7.3"
    var xt = getTimeStamp()
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override var baseUrl: URL {
        return URL(string: "http://mobwsa.ximalaya.com")!
    }
    
    override var path: String {
        let pathStr = "/product/v2/payable/channel/recommend/ts-\(getTimeStamp())"
        return pathStr
    }
    
    override var method: RequestMethod {
        return .get
    }
    
    override var headerDic: [String : String]? {
        return ["Host" : "mobwsa.ximalaya.com"]
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        appid                          >>> map["appid"]
        device                          >>> map["device"]
        deviceId                          >>> map["deviceId"]
        isAppleReview                          >>> map["isAppleReview"]
        network                          >>> map["network"]
        operatorId                          >>> map["operator"]
        scale                          >>> map["scale"]
        uid                          >>> map["uid"]
        version                          >>> map["version"]
        xt                          >>> map["xt"]
    }
}

//http://117.148.166.147/product/feed/v1/mix/ts-1600328454662?categoryId=0&device=iPhone&isAppleReview=false&offset=0&source=payable
class XMHQGAlbumRequest: BaseRequest {
    
    var categoryId: Int8 = 0
    var device = "iPhone"
    var isAppleReview = false
    var offset: Int = 0
    var source = "payable"

    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override var baseUrl: URL {
        return URL(string: "http://mobwsa.ximalaya.com")!
    }
    
    override var path: String {
        let pathStr = "/product/feed/v1/mix/ts-\(getTimeStamp())"
        return pathStr
    }
    
    override var method: RequestMethod {
        return .get
    }
    
    override var headerDic: [String : String]? {
        return ["Host" : "mobwsa.ximalaya.com"]
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        categoryId          >>> map["categoryId"]
        device              >>> map["device"]
        isAppleReview       >>> map["isAppleReview"]
        offset              >>> map["offset"]
        source              >>> map["source"]
    }
}
