//
//  ShortVideoRequest.swift
//  himalaya
//
//  Created by Farben on 2020/8/14.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import ObjectMapper
class ShortVideoRequest: BaseRequest {
    
//http://mobwsa.ximalaya.com/ugc-web/stream/video/v1/recommend/1599550434518?limit=20
//http://mobwsa.ximalaya.com/ugc-web/stream/video/v1/recommend/1599550474701?limit=20
//    http://mobwsa.ximalaya.com/ugc-web/stream/video/v1/recommend/1599550477449?limit=20
//    http://mobwsa.ximalaya.com/ugc-web/stream/video/v1/recommend/1599550479813?limit=20
//    http://mobwsa.ximalaya.com/ugc-web/stream/video/v1/recommend/1599550482179?limit=20
//    http://mobwsa.ximalaya.com/ugc-web/stream/video/v1/recommend/1599550484380?limit=20
//    http://mobwsa.ximalaya.com/ugc-web/stream/video/v1/recommend/1599550487169?limit=20
    override var path: String {
        let pathStr = String(format: "/ugc-web/stream/video/v1/recommend/%lld", timeStamp)
        return pathStr
    }
    
    var limit: Int = 20
        
    var isFirst: Bool = true {
        didSet {
            if isFirst == true {
                currentIndex = 0
            }
        }
    }
    
    var currentIndex: Int8 = 0
    
    
    override init() {
        super.init()
    }
        
    var timeStamp: Int64 = getTimeStamp()
    
    override var baseUrl: URL {
        return URL(string: "http://mobwsa.ximalaya.com")!
    }
    
    override var headerDic: [String : String]? {
        return ["Host" : "mobwsa.ximalaya.com"]
    }
    
    override var method: RequestMethod {
        return .get
    }
        
    required init?(map: Map) {
        super.init(map: map)
    }
        
    override func mapping(map: Map) {
        super.mapping(map: map)
        limit         >>> map["limit"]
    }
}
