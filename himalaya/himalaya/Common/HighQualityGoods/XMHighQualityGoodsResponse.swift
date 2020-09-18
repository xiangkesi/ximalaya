//
//  XMHighQualityGoodsResponse.swift
//  himalaya
//
//  Created by Farben on 2020/9/16.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import ObjectMapper

class XMHighQualityGoodsResponse<T: Mappable>: BaseResponse<T> {
    
    var resultModel: T?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    override init() {
        super.init()
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        resultModel         <- map["data"]
    }

}
