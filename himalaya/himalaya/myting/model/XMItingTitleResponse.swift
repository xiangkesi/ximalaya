//
//  XMItingResponse.swift
//  himalaya
//
//  Created by Farben on 2020/9/18.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import ObjectMapper

class XMItingTitleResponse<T: Mappable>: BaseResponse<T> {
    
    var resultModels: [T]?
    
    var resultModel: T?
    
    
    required init?(map: Map) {
        super.init(map: map)
    }
    override init() {
        super.init()
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        resultModels         <- map["data"]
        resultModel         <- map["data"]
    }
    
}
