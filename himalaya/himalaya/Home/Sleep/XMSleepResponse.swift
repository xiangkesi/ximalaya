//
//  XMSleepResponse.swift
//  himalaya
//
//  Created by cocoazhang on 2020/9/13.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import ObjectMapper

class XMSleepResponse<T: Mappable>: BaseResponse<T> {
    
    var titleModels: [T]?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    override init() {
        super.init()
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        titleModels         <- map["data"]
    }
}
