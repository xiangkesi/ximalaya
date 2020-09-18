//
//  XMVipRequest.swift
//  himalaya
//
//  Created by Farben on 2020/8/18.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import ObjectMapper

class XMVipRequest: BaseRequest {
    
    var appid: Int = 0
    var deviceId: String = "1605D009-7E02-4A91-B8AA-E053CE83BA30"
    var device: String = "iPhone"
    var isAppleReview: Bool = false
    var network: String = "WIFI"
    var operatorId: Int = 3
    var scale: Int = 2
    var uid: Int64 = 80567972
    var version: String = "6.6.99"
    var xt: String = "\(getTimeStamp())"

    override var path: String {
        let pathStr = "/vip/v1/recommand/ts-\(getTimeStamp())"
        return pathStr
    }
        
    override init() {
        super.init()
    }
    
    override var baseUrl: URL {
           return URL(string: "http://219.146.68.28")!
       }
       
       override var method: RequestMethod {
           return .get
       }
       
       override var headerDic: [String : String]? {
           return ["Host" : "mobilehera.ximalaya.com"]
       }
           
       required init?(map: Map) {
           super.init(map: map)
       }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
         appid                          >>> map["appid"]
         deviceId                 >>> map["deviceId"]
         isAppleReview                          >>> map["isAppleReview"]
         device                          >>> map["device"]
         network                          >>> map["network"]
         operatorId                          >>> map["operator"]
         scale                          >>> map["scale"]
         uid                          >>> map["uid"]
         version                          >>> map["version"]
         xt                          >>> map["xt"]
    }
}
//http://180.153.100.153/vip/feed/v1/categories/ts-1598342768667?device=iPhone&source=vip

class XMVipCategorieRequest: BaseRequest {
    var device: String = "iPhone"
    var source: String = "vip"
    
     override var path: String {
         let pathStr = "/vip/feed/v1/categories/ts-\(getTimeStamp())"
         return pathStr
     }
         
     override init() {
         super.init()
     }
     
     override var baseUrl: URL {
            return URL(string: "http://180.153.100.153")!
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
          device                          >>> map["device"]
          source                 >>> map["source"]
     }
}

class XMVipCategorieDetailRequest: BaseRequest {
    var device: String = "iPhone"
    var source: String = "vip"
    
    var categoryId: Int = 0
    
    var offset: Int = 16
    
    var isDrop: Bool = false
    
    var currentWord: XMVipCategorieWordModel? {
        didSet {
            categoryId = currentWord?.categoryId ?? 0
        }
    }
    
    
    
     override var path: String {
        
         let pathStr = "/vip/feed/v1/mix/ts-\(getTimeStamp())"
        
         return pathStr
     }
         
     override init() {
         super.init()
     }
     
     override var baseUrl: URL {
            return URL(string: "http://180.153.100.168")!
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
          device                          >>> map["device"]
          source                 >>> map["source"]
          categoryId                          >>> map["categoryId"]
          offset                 >>> map["offset"]
        
     }
}

