//
//  HomeRequest.swift
//  himalaya
//
//  Created by Farben on 2020/8/6.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import ObjectMapper

class HomeRequest: BaseRequest {
    
//    http://112.29.204.34/discovery-feed/v3/mix/ts-1597651321199?appid=0&topBuzzVersion=2&click=false&deviceId=1605D009-7E02-4A91-B8AA-E053CE83BA30&onlyBody=false&operator=3&code=43_310000_3100&giftTag=0&ageRange=&hotPlayModuleShowTimes=2&channel=ios-b1&interestedCategories=&adModuleNum=4&version=6.6.93&guessPageId=2&offset=135&uid=80567972&xt=1597651321203&countyCode=310112&scale=2&network=WIFI&traitValue=&traitKey=&device=iPhone&categoryId=-2
    
//    http://112.29.204.34/discovery-feed/v3/mix/ts-1597651338546?appid=0&topBuzzVersion=2&click=false&deviceId=1605D009-7E02-4A91-B8AA-E053CE83BA30&onlyBody=true&operator=3&code=43_310000_3100&giftTag=0&ageRange=&hotPlayModuleShowTimes=2&channel=ios-b1&interestedCategories=&version=6.6.93&guessPageId=3&offset=150&uid=80567972&xt=1597651338546&countyCode=310112&scale=2&network=WIFI&traitValue=&traitKey=&device=iPhone&categoryId=-2
    
//    http://112.29.204.34/discovery-feed/v3/mix/ts-1597651341559?appid=0&topBuzzVersion=2&click=false&deviceId=1605D009-7E02-4A91-B8AA-E053CE83BA30&onlyBody=true&operator=3&code=43_310000_3100&giftTag=0&ageRange=&hotPlayModuleShowTimes=2&channel=ios-b1&interestedCategories=&version=6.6.93&guessPageId=3&offset=165&uid=80567972&xt=1597651341560&countyCode=310112&scale=2&network=WIFI&traitValue=&traitKey=&device=iPhone&categoryId=-2
    var appid: Int = 0
    var topBuzzVersion: Int = 2
    var click: Bool = false
    var deviceId: String = "1605D009-7E02-4A91-B8AA-E053CE83BA30"
    var onlyBody: Bool = true {
        didSet {
            if onlyBody == false {
                offset = 15
                index = 0
            }
        }
    }
    
    var isReadCache: Bool = true
    
    
    var index: Int = 1
    
    
    var operator_t: Int  = 3
    var code: String = "43_310000_3100"
    var giftTag: Int = 0
//    var ageRange: = <#value#>
    var hotPlayModuleShowTimes: Int = 2
    var channel: String = "ios-b1"
    var interestedCategories: String?
    var version: String = "6.6.93"
    var guessPageId: Int = 3 //第一个为2
    var offset: Int = 15
    var uid: String = "80567972"
    var xt: String = "\(getTimeStamp())"
    var countyCode: String = "310112"
    var scale: Int = 2
    var network: String = "WIFI"
    var traitValue: String?
    var traitKey: String?
    var device: String = "iPhone"
    var categoryId: Int = -2
        
    override var path: String {
        let pathStr = "/discovery-feed/v3/mix/ts-\(getTimeStamp())"
        return pathStr
    }
        
    override init() {
        super.init()
    }
//    {
//        "ret": 0,
//        "resolve_need": ["mobile.ximalaya.com"],
//        "signature": "bea187fd1577ef302dac814770250659",
//        "ips": {
//            "ad.ximalaya.com": "114.80.138.114",
//            "api.ximalaya.com": "180.153.255.9",
//            "search.ximalaya.com": "114.80.170.77",
//            "linkeye.ximalaya.com": "114.80.170.77",
//            "mobile.ximalaya.com": "114.80.142.162,180.153.255.6,140.207.215.242,140.207.215.252",
//            "live.ximalaya.com": "180.153.255.9",
//            "upload.ximalaya.com": "180.153.255.9",
//            "mpay.ximalaya.com": "114.80.170.77"
//        },
//        "domains": {
//            "download.xmcdn.com": "download.ws1.xmcdn.com"
//        }
//    }
        
    override var baseUrl: URL {
        return URL(string: "http://mobile.ximalaya.com")!
    }
    
    override var method: RequestMethod {
        return .post
    }
    
    override var headerDic: [String : String]? {
        return ["Host" : "mobile.ximalaya.com"]
    }
        
    required init?(map: Map) {
        super.init(map: map)
    }
        
    override func mapping(map: Map) {
        super.mapping(map: map)
        appid                          >>> map["appid"]
        topBuzzVersion                 >>> map["topBuzzVersion"]
        click                          >>> map["click"]
        deviceId                       >>> map["deviceId"]
        onlyBody                       >>> map["onlyBody"]
        operator_t                     >>> map["operator"]
        code                           >>> map["code"]
        giftTag                        >>> map["giftTag"]
        hotPlayModuleShowTimes         >>> map["hotPlayModuleShowTimes"]
        channel                        >>> map["channel"]
        interestedCategories           >>> map["interestedCategories"]
        version                        >>> map["version"]
        guessPageId                    >>> map["guessPageId"]
        offset                         >>> map["offset"]
        uid                            >>> map["uid"]
        xt                             >>> map["xt"]
        countyCode                     >>> map["countyCode"]
        scale                          >>> map["scale"]
        network                        >>> map["network"]
        traitValue                     >>> map["traitValue"]
        traitKey                       >>> map["traitKey"]
        device                         >>> map["device"]
        categoryId                     >>> map["categoryId"]
    }
}
