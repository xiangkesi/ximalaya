//
//  XMVipResponse.swift
//  himalaya
//
//  Created by Farben on 2020/8/18.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import ObjectMapper

class XMVipResponse<T: Mappable>: BaseResponse<T> {
    
       
    var data: T?
              
       
    required init?(map: Map) {
        super.init(map: map)
    }
    override init() {
        super.init()
    }
       
    override func mapping(map: Map) {
        super.mapping(map: map)
        data          <- map["data"]
    }
}
