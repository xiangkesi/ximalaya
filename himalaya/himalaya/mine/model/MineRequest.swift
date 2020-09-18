//
//  MineRequest.swift
//  himalaya
//
//  Created by Farben on 2020/8/3.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import ObjectMapper

class MineRequest: BaseRequest {
    
    
    var shouldRefresh: Bool = false
    
    override var path: String {
        return "/mobile-user/homePage/entrance/1596430635128.239"
    }
    
    override init() {
        super.init()
    }
    
    override var baseUrl: URL {
        return URL(string: "http://112.13.171.241")!
    }
    
    override var headerDic: [String : String]? {
        return ["Host" : "mobile.ximalaya.com"]
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
//        businessType         >>> map["businessType"]
    }
}

class MineMsgRequest: BaseRequest {
    
    var uid: String = "80567972"
    var date: String = "20200806"
    var playDuration: Int = 0
    var timestamp: Int64 = timeToTimeStamp() * 1000
    var coinSwitch1: Bool = false
    
    override var path: String {
        return "/mobile-user/homePage/"
    }
    
    override var headerDic: [String : String]? {
        return ["Host" : "mobile.ximalaya.com"]
    }
        
    override init() {
        super.init()
    }
        
    override var baseUrl: URL {
        return URL(string: "http://223.111.19.149")!
    }
        
    required init?(map: Map) {
        super.init(map: map)
    }
        
    override func mapping(map: Map) {
        super.mapping(map: map)
        uid         >>> map["uid"]
        date         >>> map["date"]
        playDuration         >>> map["playDuration"]
        timestamp         >>> map["timestamp"]
        coinSwitch1         >>> map["coinSwitch1"]
    }
}
