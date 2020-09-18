//
//  XMNoveRequest.swift
//  himalaya
//
//  Created by Farben on 2020/8/26.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import ObjectMapper
//http://180.153.100.168/discovery-category/v4/category/recommend/ts-1598936793239?appid=0&categoryId=49&device=iPhone&deviceId=1605D009-7E02-4A91-B8AA-E053CE83BA30&gender=9&inreview=false&isHomepage=true&network=WIFI&operator=3&scale=2&uid=80567972&version=6.6.99&xt=1598936793241
//http://180.153.100.168/discovery-category/v4/category/recommend/ts-1598936793239?appid=0&categoryId=49&device=iPhone&deviceId=1605D009-7E02-4A91-B8AA-E053CE83BA30&gender=9&inreview=false&isHomepage=true&network=WIFI&operator=3&scale=2&uid=80567972&version=6.6.99&xt=1598936793241
//http://59.63.235.31/discovery-category/v4/category/recommend/ts-1598936854160?appid=0&categoryId=49&device=iPhone&deviceId=1605D009-7E02-4A91-B8AA-E053CE83BA30&gender=9&inreview=false&isHomepage=true&network=WIFI&offset=30&operator=3&scale=2&uid=80567972&version=6.6.99&xt=1598936854160
//http://59.63.235.31/discovery-category/v4/category/recommend/ts-1598936857718?appid=0&categoryId=49&device=iPhone&deviceId=1605D009-7E02-4A91-B8AA-E053CE83BA30&gender=9&inreview=false&isHomepage=true&network=WIFI&offset=45&operator=3&scale=2&uid=80567972&version=6.6.99&xt=1598936857719
//mobile.ximalaya.com
//get

//http://180.153.100.156/discovery-category/v4/category/recommend/ts-1598937335004?appid=0&categoryId=49&contentType=album&device=android&deviceId=3b415853-d57e-3df9-a2e3-d8ab2232c5c6&gender=9&isHomepage=true&network=wifi&operator=1&scale=1&uid=80567972&version=6.6.99
//http://180.153.100.156/discovery-category/v4/category/recommend/ts-1598937367691?categoryId=49&channelId=34&device=android&deviceId=3b415853-d57e-3df9-a2e3-d8ab2232c5c6&offset=15
//http://180.153.100.156/discovery-category/v4/category/recommend/ts-1598937373932?categoryId=49&channelId=34&device=android&deviceId=3b415853-d57e-3df9-a2e3-d8ab2232c5c6&offset=30
//http://180.153.100.156/discovery-category/v4/category/recommend/ts-1598937378560?categoryId=49&channelId=34&device=android&deviceId=3b415853-d57e-3df9-a2e3-d8ab2232c5c6&offset=45
//http://180.153.100.156/discovery-category/v4/category/recommend/ts-1598937384047?categoryId=49&channelId=34&device=android&deviceId=3b415853-d57e-3df9-a2e3-d8ab2232c5c6&offset=60
class XMNoveRequest: BaseRequest {
    
    var appid: Int = 0
    var categoryId: Int = 49
    var channelId: Int = 34
    var device = "iPhone"
    var contentType = "album"
    var deviceId: String = "1605D009-7E02-4A91-B8AA-E053CE83BA30"
    var gender: Int = 9
    var isHomepage: Bool = false {
        didSet {
            if isHomepage == true {
                offset = 0
            }
        }
    }
    var network = "WIFI"
    var inreview: Bool = false
    
    var offset: Int = 0
    var operatorId: Int = 3
    var scale: Int = 2
    var uid: Int = 80567972
    var version: String = "6.6.99"
    var xt: Int64 = getTimeStamp()
    
    override var path: String {
        let pathStr = "/discovery-category/v4/category/recommend/ts-\(getTimeStamp())"
        return pathStr
    }
        
    override init() {
        super.init()
    }
    
    override var baseUrl: URL {
        return URL(string: "http://180.153.100.156")!
    }
       
    override var method: RequestMethod {
        return .get
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
        categoryId                          >>> map["categoryId"]
        channelId                          >>> map["channelId"]
        device                          >>> map["device"]
        contentType                          >>> map["contentType"]
        deviceId                          >>> map["deviceId"]
        gender                          >>> map["gender"]
        isHomepage                          >>> map["isHomepage"]
        network                          >>> map["network"]
        offset                          >>> map["offset"]
        operatorId                          >>> map["operator"]
        scale                          >>> map["scale"]
        uid                          >>> map["uid"]
        version                          >>> map["version"]
        xt                          >>> map["xt"]
        inreview                          >>> map["inreview"]
    }
}
