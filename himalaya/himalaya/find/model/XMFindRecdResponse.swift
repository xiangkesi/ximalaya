//
//  XMFindRecdResponse.swift
//  himalaya
//
//  Created by Farben on 2020/9/3.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import ObjectMapper

class XMFindRecdResponse<T: Mappable>: BaseResponse<T> {
    
    var model: T?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    override init() {
        super.init()
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        model             <- map["data"]
    }
}
