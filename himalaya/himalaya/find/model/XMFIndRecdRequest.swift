//
//  XMFIndRecdRequest.swift
//  himalaya
//
//  Created by cocoazhang on 2020/9/6.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import ObjectMapper

class XMFIndRecdRequest: BaseRequest {
    
//    http://180.153.100.153/nexus/v4/stream/pull/1599388355823?action=down&allCount=14&includeTopicRecommendation=1&limit=20&score=1599388355799&streamId=1001
//    http://180.153.100.153/nexus/v4/stream/pull/1599385208334?action=down&allCount=14&includeTopicRecommendation=true&limit=20&score=1599385203020&streamId=1001
    
    
//    http://180.153.100.153/nexus/v4/stream/pull/1599388368926?action=up&allCount=28&includeTopicRecommendation=0&limit=20&score=1599388355799&streamId=1001
//    http://180.153.100.153/nexus/v4/stream/pull/1599385241863?action=up&allCount=14&includeTopicRecommendation=false&limit=20&score=1599378524001&streamId=1001
//    http://180.153.100.153/nexus/v4/stream/pull/1599385243716?action=up&allCount=29&includeTopicRecommendation=false&limit=20&score=1599385243401&streamId=1001
//    http://180.153.100.153/nexus/v4/stream/pull/1599385245616?action=up&allCount=44&includeTopicRecommendation=false&limit=20&score=1599385245301&streamId=1001
//    http://180.153.100.153/nexus/v4/stream/pull/1599385247153?action=up&allCount=57&includeTopicRecommendation=false&limit=20&score=1599385247201&streamId=1001
    override var path: String {
        let pathStr = String(format: "/nexus/v4/stream/pull/%lld", getTimeStamp())
        return pathStr
    }
    
    var action: String = "down"
    var allCount: Int = 20
    var includeTopicRecommendation: Bool = true
    
    var limit: Int = 20
    var score = getTimeStamp()
    var streamId: Int = 1001
    
    var currentIndex: Int8 = 0
    
  
    override init() {
        super.init()
    }
        
    override var baseUrl: URL {
        return URL(string: "http://180.153.100.156")!
    }
    
    override var headerDic: [String : String]? {
        return ["Host" : "mobile.ximalaya.com"]
    }
    
    override var method: RequestMethod {
        return .get
    }
        
    required init?(map: Map) {
        super.init(map: map)
    }
        
    override func mapping(map: Map) {
        super.mapping(map: map)
        action         >>> map["action"]
        allCount         >>> map["allCount"]
        includeTopicRecommendation         >>> map["includeTopicRecommendation"]
        limit         >>> map["limit"]
        score         >>> map["score"]
        streamId         >>> map["streamId"]
    }
}
