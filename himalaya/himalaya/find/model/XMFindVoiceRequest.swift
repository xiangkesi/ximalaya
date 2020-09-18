//
//  ActiveRequest.swift
//  himalaya
//
//  Created by Farben on 2020/8/4.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import ObjectMapper
class XMFindVoiceRequest: BaseRequest {
    
//    http://45.124.126.14/discovery-stream-mobile/discoveryPage/dubShow/v3/hotDubbingItems/ts-1599439751642?offset=0
//    http://45.124.126.14/discovery-stream-mobile/discoveryPage/dubShow/v3/hotDubbingItems/ts-1599439775459?offset=13
//    http://45.124.126.14/discovery-stream-mobile/discoveryPage/dubShow/v3/hotDubbingItems/ts-1599439779743?offset=23
//    http://45.124.126.14/discovery-stream-mobile/discoveryPage/dubShow/v3/hotDubbingItems/ts-1599439782482?offset=33
    
//    http://45.124.126.14/discovery-stream-mobile/discoveryPage/dubShow/v3/hotDubbingItems/ts-1599439785241?offset=43
//
    override var path: String {
        let pathStr = String(format: "/discovery-stream-mobile/discoveryPage/dubShow/v3/hotDubbingItems/ts-%lld", getTimeStamp())
        return pathStr
    }
    
    var limit: Int = 20
    var offset: Int = 0
    
    var isDrop: Bool = true {
        didSet {
            if isDrop == true {
                offset = 0
            }
        }
    }
        
    override init() {
        super.init()
    }
        
    override var baseUrl: URL {
        return URL(string: "http://45.124.126.14")!
    }
    
    override var headerDic: [String : String]? {
        return ["Host" : "mobilehera.ximalaya.com"]
    }
    
    override var method: RequestMethod {
        return .get
    }
        
    required init?(map: Map) {
        super.init(map: map)
    }
        
    override func mapping(map: Map) {
        super.mapping(map: map)
        offset         >>> map["offset"]
    }
}
